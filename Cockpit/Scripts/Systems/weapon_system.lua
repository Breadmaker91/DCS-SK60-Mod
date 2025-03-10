local WeaponSystem     = GetSelf()
dofile(LockOn_Options.script_path.."debug_util.lua")
dofile(LockOn_Options.common_script_path.."devices_defs.lua")
dofile(LockOn_Options.script_path.."devices.lua")
--dofile(LockOn_Options.script_path.."Systems/stores_config.lua")
dofile(LockOn_Options.script_path.."command_defs.lua")
dofile(LockOn_Options.script_path.."Systems/electric_system_api.lua")
dofile(LockOn_Options.common_script_path.."../../../Database/wsTypes.lua")
dofile(LockOn_Options.script_path.."sounds_def.lua")
-- snd_device:performClickableAction(Keys.SND_CENTER_PANEL, cockpit_sound.basic_switch, false)

local update_time_step = 0.02  --每秒50次刷新
make_default_activity(update_time_step)

local sensor_data = get_base_data()

local iCommandPlaneWingtipSmokeOnOff = 78
local iCommandPlaneJettisonWeapons = 82
local iCommandPlaneFire = 84
local iCommandPlaneFireOff = 85
local iCommandPlaneChangeWeapon = 101
local iCommandActiveJamming = 136
local iCommandPlaneJettisonFuelTanks = 178
local iCommandPlanePickleOn = 350
local iCommandPlanePickleOff = 351
--local iCommandPlaneDropFlareOnce = 357
--local iCommandPlaneDropChaffOnce = 358

local gun_sight_animation = get_param_handle("GUN_SIGHT")

-- 获取锁定状态
-- 是否锁定
local ir_missile_lock_param = get_param_handle("WS_IR_MISSILE_LOCK")
-- 锁定的目标的高程和方向
local ir_missile_az_param = get_param_handle("WS_IR_MISSILE_TARGET_AZIMUTH")
local ir_missile_el_param = get_param_handle("WS_IR_MISSILE_TARGET_ELEVATION")

-- 似乎是设置预设锁定方向？
-- 方位角
local ir_missile_des_az_param = get_param_handle("WS_IR_MISSILE_SEEKER_DESIRED_AZIMUTH")
-- 高程
local ir_missile_des_el_param = get_param_handle("WS_IR_MISSILE_SEEKER_DESIRED_ELEVATION")

WeaponSystem:listen_command(Keys.WingPylonSmokeOn)
WeaponSystem:listen_command(Keys.NozzleSmokeOn)
WeaponSystem:listen_command(Keys.WeaponFireOn)
WeaponSystem:listen_command(Keys.WeaponFireOff)
WeaponSystem:listen_command(Keys.WeaponConfigSingle)
WeaponSystem:listen_command(Keys.WeaponConfigPairs)
WeaponSystem:listen_command(Keys.WeaponConfigAll)
WeaponSystem:listen_command(Keys.WeaponMasterSwitch)
WeaponSystem:listen_command(Keys.WeaponAirGroundChange)
WeaponSystem:listen_command(Keys.GunSightInstall)
WeaponSystem:listen_command(Keys.GunSightUninstall)

local pod_smoke_light = get_param_handle("POD_SMOKE")
local nozzle_smoke_light = get_param_handle("NOZZLE_SMOKE")

function post_initialize()

end

local smokepodstatus = 0
local nozzlesmokestatus = 0

-- fireing mode, 1 is single, 2 is in pairs, 
local rockets_fire_mode = 1
-- ripple mode enable
local rocket_ripple_enable = 0
local has_smoke_pod = 0
local has_nozzle_smoke = 0
-- 0 is nothing, 1 is gunpod, 2 is rockets
local weapon_system_mode = 0
local fire_trigger_status = 0
local gun_sight_is_installed = 0

local gun_sight_display = get_param_handle("GUNSIGHT_ENABLE")

-- PYLON_INFO_LIST[pylonSelection + 1] = {station_data.weapon.level2, station_data.weapon.level3, station_data.count}

local SWITCH_OFF = 0
local SWITCH_ON = 1
local SWITCH_TEST = -1

switch_count = 0
function _switch_counter()
    switch_count = switch_count + 1
    return switch_count
end

local master_switch = _switch_counter()
local AG_switch = _switch_counter()

target_status = {
    {master_switch , SWITCH_OFF, get_param_handle("PTN_413"), "PTN_413"},
    {AG_switch , SWITCH_OFF, get_param_handle("PTN_414"), "PTN_414"},
}

current_status = {
    {master_switch , SWITCH_OFF, SWITCH_OFF},
    {AG_switch , SWITCH_OFF, SWITCH_OFF},
}


-- 1,2,3,4,5,6,7,8 position
-- 2, 4, 5, 7 can be loaded with smoke system, gun pod, and rockets
-- 1, 3, 6, 8 can only be loaded with rockets
-- 0 is nothing mounted, 1 is smoke pod, 2 is nozzle smoke, 3 is gunpod, 
-- 4 is rockets * 1, 5 is rockets * 2,
--#region             1,2,3,4,5,6,7,8
local loading_list = {0,0,0,0,0,0,0,0}

function check_load_status()
    weapon_system_mode = 0
    has_smoke_pod = 0
    has_nozzle_smoke = 0
    for i = 1,8,1 do
        local station = WeaponSystem:get_station_info(i-1)
        if (string.sub(station.CLSID,1,36) == "{3d7bfa20-fefe-4642-ba1f-380d5ae4f9c") then
            -- smokepod
            loading_list[i] = 1
            has_smoke_pod = 1
        elseif (string.sub(station.CLSID,1,36) == "{3d7bfa20-fefe-4642-ba1f-380d5ae4f9d") then
            -- nozzle smoke
            loading_list[i] = 2
            has_nozzle_smoke = 1
        elseif (string.sub(station.CLSID,1,36) == "{d694b359-e7a8-4909-88d4-7100b77afd1") then
            -- this is a rocket, check the number of it
            loading_list[i] = 3 + station.count
            weapon_system_mode = 2
        elseif (string.sub(station.CLSID,1,36) == "{5d5aa063-a002-4de8-8a89-6eda1e80ee7") then
            -- gunpod
            loading_list[i] = 3
            weapon_system_mode = 1
            -- print_message_to_user("gunpod on station "..i)
        else
            loading_list[i] = 0
        end
    end
end

local current_freq = 256E6

local rocket_interval = 0

function check_frequency_change()
    local dev=GetDevice(devices.UHF_RADIO)
    if dev then
        -- check if override by efm radio system
        local freq_efm_signal = get_param_handle("RADIO_EFM_CHANGED")
        local freq_uplink_signal = get_param_handle("RADIO_2EFM_CHANGED")
        local freqency_EFM_exchange = get_param_handle("RADIO_UHF_FREQ_EXC")
        -- dprintf(sprintf("current Freq: %d", dev:get_frequency()))
        -- check if override by simple radio system
        if (dev:get_frequency() ~= current_freq) then
            -- send to efm, change display
            dprintf("lua radio freq changed")
            current_freq = dev:get_frequency()
            -- this direction has higher prioity
            freq_efm_signal:set(0)
            freqency_EFM_exchange:set(current_freq/1e3)
            freq_uplink_signal:set(1)
        elseif freq_efm_signal:get() > 0 then
            dprintf("EFM freq changed")
            current_freq = freqency_EFM_exchange:get() * 1e3
            dev:set_frequency(current_freq)
            freq_uplink_signal:set(0)
            freq_efm_signal:set(0)
        end
    end
end

-- launch_mode: = 0, serial ; 1, in pairs; 2, all
function launch_rockets(launch_mode)
    local launch_signal = 0
    if launch_mode < 2 then
        -- serial mode, normal sequence
        -- start from lower
        for i = 3, 1, -1 do
            -- check left side first
            -- following sequence inner -> outer
            if loading_list[i] == 5 then
                -- launch lower part first
                if launch_mode == 0 then
                    WeaponSystem:launch_station(i-1)
                else
                    WeaponSystem:launch_station(i-1)
                    WeaponSystem:launch_station(6-i)
                end
                launch_signal = 1
                break
            elseif loading_list[7-i] == 5 then
                -- check the opposite side
                WeaponSystem:launch_station(6-i)
                launch_signal = 1
                break
            end
        end
        if launch_signal == 0 then
            -- check upper layer
            normal_serial = {3, 2, 1}
            spec_serial = {2, 1, 3}
            for j = 1, 3, 1 do
                -- check if have 2-1-1 serial
                if WeaponSystem:get_station_info(1).CLSID == WeaponSystem:get_station_info(3).CLSID then
                    i = normal_serial[j]
                else
                    i = spec_serial[j]
                end
                -- check left side first
                -- following sequence inner -> outer
                if loading_list[i] == 4 then
                    -- launch lower part first
                    if launch_mode == 0 then
                        WeaponSystem:launch_station(i-1)
                    else
                        WeaponSystem:launch_station(i-1)
                        WeaponSystem:launch_station(6-i)
                    end
                    launch_signal = 1
                    break
                elseif loading_list[7-i] == 4 then
                    -- check the opposite side
                    WeaponSystem:launch_station(6-i)
                    launch_signal = 1
                    break
                end
            end
        end
    elseif launch_mode == 2 then
        for i = 1, 6, 1 do
            WeaponSystem:launch_station(i-1)
            WeaponSystem:launch_station(i-1)
        end
    end
end

function SetCommand(command,value)
    if (get_elec_dc_status() and current_status[master_switch][2] == SWITCH_ON ) then
        check_load_status()
        if (command == Keys.WeaponFireOn) then
            if (weapon_system_mode == 2 and rocket_ripple_enable == 0) then
                -- rocket
                launch_rockets(rockets_fire_mode-1)
                fire_trigger_status = 0
            else
                fire_trigger_status = 1
            end
        elseif (command == Keys.WeaponFireOff) then
            fire_trigger_status = 0
        end
    end
    if (command == Keys.WeaponConfigAll) then
        rocket_ripple_enable = 1 - rocket_ripple_enable
        dprintf("rocket fire Ripple status change")
    elseif (command == Keys.WeaponConfigSingle) then
        rockets_fire_mode = 1
        dprintf("rocket fire mode Single")
    elseif (command == Keys.WeaponConfigPairs) then
        rockets_fire_mode = 2
        dprintf("rocket fire mode Pairs")
    elseif (command == Keys.WeaponMasterSwitch) then
        target_status[master_switch][2] = 1 - target_status[master_switch][2]
        dispatch_action(devices.SOUND_SYSTEM, Keys.SND_LEFT_PANEL, cockpit_sound.basic_switch)
        check_load_status()
    elseif (command == Keys.GunSightInstall) then
        gun_sight_is_installed = 1
        gun_sight_animation:set(1 - gun_sight_is_installed)
    elseif (command == Keys.GunSightUninstall) then
        gun_sight_is_installed = 0
        gun_sight_animation:set(1 - gun_sight_is_installed)
    elseif (command == Keys.WingPylonSmokeOn) then
        check_load_status()
        if (loading_list[2] == 1 or loading_list[5] == 1) then
            if loading_list[2] == 1 then
                WeaponSystem:launch_station(1)
            end
            if loading_list[5] == 1 then
                WeaponSystem:launch_station(4)
            end
            smokepodstatus = 1 - smokepodstatus
            if smokepodstatus == 1 then
                dprintf("Smoke pod is ON")
            else
                dprintf("Smoke pod is OFF")
            end
        else
            dprintf("No Smoke Pod on Pylon")
            smokepodstatus = 0
        end
    elseif (command == Keys.NozzleSmokeOn) then
        check_load_status()
        if (has_nozzle_smoke == 1) then
            WeaponSystem:launch_station(6)
            WeaponSystem:launch_station(7)
            nozzlesmokestatus = 1 - nozzlesmokestatus
            if nozzlesmokestatus == 1 then
                dprintf("Nozzle smoke is ON")
            else
                dprintf("Nozzle smoke is OFF")
            end
        else
            nozzlesmokestatus = 0
            dprintf("Nozzle Smoke Not Loaded")
        end
    end
end

function update_switch_status()
    local switch_moving_step = 0.25
    for k,v in pairs(target_status) do
        if math.abs(target_status[k][2] - current_status[k][2]) < switch_moving_step then
            current_status[k][2] = target_status[k][2]
        elseif target_status[k][2] > current_status[k][2] then
            current_status[k][2] = current_status[k][2] + switch_moving_step
        elseif target_status[k][2] < current_status[k][2] then
            current_status[k][2] = current_status[k][2] - switch_moving_step
        end
        target_status[k][3]:set(current_status[k][2])
        local temp_switch_ref = get_clickable_element_reference(target_status[k][4])
        temp_switch_ref:update()
        -- print_message_to_user(k)
    end
end

function update()
    -- check_load_status()
    pod_smoke_light:set(smokepodstatus)
    nozzle_smoke_light:set(nozzlesmokestatus)
    update_switch_status()
    gun_sight_animation:set(1 - gun_sight_is_installed)
    if (get_elec_dc_status() and current_status[master_switch][2] == SWITCH_ON and gun_sight_is_installed == 1) then
        gun_sight_display:set(1)
    else
        gun_sight_display:set(0)
    end
    rocket_interval = rocket_interval - update_time_step
    if fire_trigger_status == 1 then
        if (weapon_system_mode == 2) then
            check_load_status()
            if rocket_interval <= 0 then
                rocket_interval = 0.12
                launch_rockets(rockets_fire_mode-1)
            end
        else
            for i = 1, 3, 1 do
                -- WeaponSystem:launch_station(i-1)
                if loading_list[i] == 3 then
                    WeaponSystem:launch_station(i-1)
                    WeaponSystem:launch_station(6-i)
                end
            end
        end
    end
    check_frequency_change()
end

need_to_be_closed = false