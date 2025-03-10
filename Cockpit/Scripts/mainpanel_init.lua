--初始化座舱模型
shape_name   	   = "Cockpit_SK_60"
is_EDM			   = true
new_model_format   = true

-- 一些颜色定义，基本没啥用
ambient_light    = {255,255,255}
ambient_color_day_texture    = {72, 100, 160}
ambient_color_night_texture  = {40, 60 ,150}
ambient_color_from_devices   = {50, 50, 40}
ambient_color_from_panels	 = {35, 25, 25}

-- 一些不用动的数据
dusk_border					 = 0.4
draw_pilot					 = false

-- 定义外部舱盖模型的arg值
external_model_canopy_arg	 = 38

-- 是否使用外部模型的座舱（指是否默认设置好114隐藏外部模型的座舱
use_external_views = false

local controllers = LoRegisterPanelControls()

day_texture_set_value   = 0.0
night_texture_set_value = 0.1

-- mirror settings
mirrors_data = {
    center_point      	= { 0.418, 0.2 , 0.0 }, --F/B,U/D,L/R location of reflection image generation--{ 0.279, 0.4, 0.00 } 0.279, 0.3, 0.00, difference from cockpit_local_point {2.00, 0.2553,-0.2576},
    width 			  	= 1.9, --integrated (keep in mind that mirrors can be none planar old=0.7)
    aspect 			  	= 1,--0.8/0.3,
	rotation 	 	 	= math.rad(0);
	animation_speed  	= 2.0;
	near_clip 		  	= 0.1;
	--middle_clip		= 100;		
	--far_clip		  	= 60000;	
	arg_value_when_on 	= 1.0;
}

TEMP_VAR = {}

-- 这是封装的设置舱内动画与parameter绑定的函数

function create_cockpit_animation_controller(input_num, set_parameter, _arg_number, _input, _output)
    if (_input == nil) then
        _input = {-1,1}
    end
    if (_output == nil) then
        _output = {-1,1}
    end
    TEMP_VAR[input_num] = CreateGauge("parameter")
    TEMP_VAR[input_num].arg_number		    = _arg_number
    TEMP_VAR[input_num].input				= _input
    TEMP_VAR[input_num].output			    = _output
    TEMP_VAR[input_num].parameter_name		= set_parameter
end

counter_rec = 0

function _counter()
    counter_rec = counter_rec + 1
    return(counter_rec)
end

animation_list = {
    {"AOA_IND", 301},
    {"RADAR_ALT_IND", 302},
    {"RPM_LEFT", 303},
    {"RPM_RIGHT", 304},
    {"EGT_LEFT", 305},
    {"EGT_RIGHT", 306},
    {"OP_LEFT", 307},
    {"OP_RIGHT", 308},
    {"OT_LEFT", 309},
    {"OT_RIGHT", 310},
    --{"OP_L", 311},
    --{"OP_R", 312},
    {"AIRBREAK_IND", 316},
    {"NoseWPOS_IND",318},
    {"MainLWPOS_IND", 319},
    {"MainRWPOS_IND", 320},
    {"MACH_IND", 322},
    -- {"G_METER", 323},
    {"G_CURRENT_EFM", 323},
    {"G_MAX_EFM", 324},
    {"GYRO_ROLL", 335},
    {"GYRO_PITCH", 334},

    -- new clock
    {"CLOCK_H", 343},
    {"CLOCK_M", 342},
    {"CLOCK_S", 344},

    {"OXY_QUAN", 329},
    {"ALT_XH_ANALOG", 330},
    {"BARO_x1H", 331},
    {"BARO_x1K", 332},
    {"BARO_x1W", 333},
    {"QNH_x1K", 334},
    {"QNH_x100", 335},
    {"QNH_x10", 336},
    {"QNH_x1", 337},
    {"BARO_POWER", 338},
    {"CLIMB_RATE", 339},
    {"SLIDE_IND", 340},
    {"HSI_COMPASS", 341},
    {"HSI_COURSE", 3420},
    {"HSI_CRS_TOF", 3430},
    {"HSI_HEADING", 3440},
    {"HSI_TACAN", 345},
    {"HSI_ADF", 346},
    {"HSI_T_D_x1k", 347},
    {"HSI_T_D_x100", 348},
    {"HSI_T_D_x10", 349},
    {"HSI_T_D_x1", 350},
    {"HSI_HDG_x100", 351},
    {"HSI_HDG_x10", 352},
    {"HSI_HDG_x1", 353},
    {"FUEL_QUAN_IN", 354},
    {"FUEL_QUAN_SEL", 355},
    {"FUEL_QUAN_A_x1W", 356},
    {"FUEL_QUAN_A_x1K", 357},
    {"FUEL_QUAN_A_x100", 358},
    {"FUEL_QUAN_A_x10", 359},
    {"FUEL_QUAN_A_x1", 360},
	{"NoseWPOS_IND", 318},
	{"MainLWPOS_IND", 319},
	{"MainRWPOS_IND", 320},

    {"Inside_Canopy", 38, {0, 1}, {1, 0}},
    {"RUDDER_PADDLE", 3, {-1, 1}, {1, -1}},
    {"BRAKE_LEFT", 4},
    {"BRAKE_RIGHT", 5},

    {"PTN_109", 109},
    {"PTN_110", 110},
    {"PTN_112", 112},
    {"PTN_113", 113},
    {"PTN_114", 114},
    {"PTN_115", 115},
    {"PTN_116", 116},
    {"PTN_117", 117},
	{"PTN_131", 131}, --{0, 1}, {0.12, 0.19}},
    {"PTN_132", 132}, --{0, 1}, {0.7, 1}},

    {"PTN_136", 136}, --{0, 1}, {0.12, 0.19}},
    {"PTN_137", 137}, --{0, 1}, {0.7, 1}},
    
    {"PTN_601", 601},

    -- Airbrake Ind
    {"AIRBRAKE_IND", 316},
    {"FLAP_LEVEL", 43},

    -- Electric power
    {"PTN_401", 401}, -- Main Power
    {"PTN_402", 402}, -- Left Gen
    {"PTN_404", 404}, -- Right Gen
    {"PTN_417", 417}, -- Nav Bus

    -- Engine
    {"PTN_405", 405},
    {"PTN_406", 406},
    {"PTN_407", 407},
    {"PTN_408", 408},
    {"PTN_418", 418},
    {"PTN_420", 420},
    {"PTN_604", 604},
    {"PTN_605", 605},

    -- Weapon panel
    {"PTN_413", 413},
    {"PTN_414", 414},

    -- generator
    {"PTN_415", 415},
    {"PTN_422", 422},

    -- gun sight
    {"GUN_SIGHT", 915},

    {"PTN_424", 424}, -- Nav light
    {"PTN_429", 429}, -- Anti Col light
    {"PTN_436", 436}, -- taxi light

    -- EADI
    {"PTN_501", 501},
    {"PTN_502", 502},

    {"RUDDER_PADEL", 3},
    {"STICK_PITCH", 1, {-1, 1}, {1, -1}},
    {"STICK_ROLL", 2},
    {"EFM_LEFT_THRUST_A", 104},
    {"EFM_RIGHT_THRUST_A", 105},
    {"AIRSPEED_IND", 321},

    {"POD_SMOKE", 900},
    {"NOZZLE_SMOKE", 901},

    -- GNS 430
    {"PTN_509", 509},
    {"PTN_510", 510},
    {"PTN_511", 511},
    {"PTN_512", 512},
    {"PTN_513", 513},
    {"PTN_514", 514},
    {"PTN_515", 515},
    {"PTN_516", 516},
    {"PTN_517", 517},
    {"PTN_518", 518},
    {"PTN_519", 519},
    {"PTN_520", 520},
    {"PTN_521", 521},
    {"PTN_522", 522},
    {"PTN_523", 523},
    {"PTN_524", 524},
   
    -- warning panel
    {"FIRE_L_ENG"   , 500}, 
    {"CANOPY"       , 501},
    {"FIRE_R_ENG"   , 502},
    {"FUEL_L_ENG"   , 503},
    {"THRUST_REV"   , 504},
    {"FUEL_R_ENG"   , 505},
    {"OIL_L_ENG"    , 506},
    {"BRAKE"        , 507}, 
    {"OIL_R_ENG"    , 508}, 
    {"HYDRO_L"      , 509}, 
    {"CONVERT_A"    , 510}, 
    {"HYDRO_R"      , 511}, 
    {"GEN_L"        , 512}, 
    {"CONVERT_B"    , 513}, 
    {"GEN_R"        , 514},
    {"MASTER_WARN"  , 135},

    -- ipad model shown
    {"IPAD_SHOWN", 950},
    -- show the ias panel
    {"IAS_TEXT", 900},
}

--[[
    animation_list[_counter] = {"RPM_L", 303}
    animation_list[_counter] = {"RPM_R", 304}
    animation_list[_counter] = {"EGT_L", 305}
    animation_list[_counter] = {"EGT_R", 306}
    animation_list[_counter] = {"FF_L", 307}
    animation_list[_counter] = {"FF_R", 308}
    animation_list[_counter] = {"RPM_L", 303}
]]

for k,v in pairs(animation_list) do
    create_cockpit_animation_controller(k,v[1],v[2],v[3],v[4])
end


-- This is the definition of the traditional model standard
--Initialize cockpit animation

--Controls
Landinggearhandle					= CreateGauge("parameter")
Landinggearhandle.arg_number		= 50
Landinggearhandle.input				= {0, 1}
Landinggearhandle.output			= {0, 1}
Landinggearhandle.parameter_name	= "PTN_083"

Fuel								= CreateGauge ()
Fuel.arg_number						= 354
Fuel.input							= {0, 1640}
Fuel.output							= {0, 1}
Fuel.controller						= controllers.base_gauge_TotalFuelWeight


need_to_be_closed = false

--SOUNDS
dofile(LockOn_Options.common_script_path.."tools.lua")