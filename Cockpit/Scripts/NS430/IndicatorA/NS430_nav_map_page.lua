-- Third Layer for Moving Map display
-- 790 * 475 // 1024 * 512
local Moving_Map_Clip                   = CreateElement "ceMeshPoly" --This is the clipping layer
Moving_Map_Clip.name 			        = "moving_map_clip"
Moving_Map_Clip.vertices 		        = { {0.7715, aspect * 0.92773}, {0.7715,-aspect * 0.92773}, {-0.7715,-aspect * 0.92773}, {-0.7715,aspect * 0.92773},} --四个边角
Moving_Map_Clip.indices 		        = {0,1,2,0,2,3}
Moving_Map_Clip.init_pos		        = {0.2285, 0.0722344, 0}
Moving_Map_Clip.init_rot		        = {0, 0, 0}
Moving_Map_Clip.material		        = "DBG_BLUE"
Moving_Map_Clip.h_clip_relation         = h_clip_relations.INCREASE_IF_LEVEL --INCREASE_IF_LEVEL--COMPARE --REWRITE_LEVEL
Moving_Map_Clip.level			        = NS430_DEFAULT_LEVEL - 1
Moving_Map_Clip.isdraw		            = true
Moving_Map_Clip.change_opacity          = false
Moving_Map_Clip.element_params          = {"NS430_MAP_DISPLAY"}              -- Initialize the main display control
Moving_Map_Clip.controllers             = {{"opacity_using_parameter",0}}
Moving_Map_Clip.parent_element	        = "base_disp_clip"
Moving_Map_Clip.isvisible		        = false--SHOW_MASKS
Add(Moving_Map_Clip)

--[[
-- second clip
local Moving_Map_Clip                   = CreateElement "ceMeshPoly" --This is the clipping layer
Moving_Map_Clip.name 			        = "overlayer_clip"
Moving_Map_Clip.vertices 		        = { {0.29297, aspect * 0.92773}, {0.29297,-aspect * 0.92773}, {-0.29297,-aspect * 0.92773}, {-0.29297,aspect * 0.92773},} --四个边角
Moving_Map_Clip.indices 		        = {0,1,2,0,2,3}
Moving_Map_Clip.init_pos		        = {0.70703-0.2285, 0, 0}
Moving_Map_Clip.init_rot		        = {0, 0, 0}
Moving_Map_Clip.material		        = "DBG_BLUE"
Moving_Map_Clip.h_clip_relation         = h_clip_relations.INCREASE_IF_LEVEL --INCREASE_IF_LEVEL--COMPARE --REWRITE_LEVEL
Moving_Map_Clip.level			        = NS430_DEFAULT_LEVEL - 1
Moving_Map_Clip.isdraw		            = true
Moving_Map_Clip.change_opacity          = false
Moving_Map_Clip.element_params          = {"NS430_MAP_DISPLAY", "NS430_OVERLAYER_RIGHT"}              -- Initialize the main display control
Moving_Map_Clip.controllers             = {{"opacity_using_parameter",0}, {"move_left_right_using_parameter",1,1}}
Moving_Map_Clip.parent_element	        = "moving_map_clip"
Moving_Map_Clip.isvisible		        = SHOW_MASKS
Add(Moving_Map_Clip)
]]--

-- map_base
local movingmap_offset_center                   = CreateElement "ceSimple"
movingmap_offset_center.name                    = "navu_moving_map_center_offset"
movingmap_offset_center.init_pos                = {0, 0, 0}
movingmap_offset_center.element_params          = {"MOV_MAP_CENTER_OFFSET"}
movingmap_offset_center.controllers             = {{"move_up_down_using_parameter",0, aspect * 0.7}}
movingmap_offset_center.collimated	            = true
movingmap_offset_center.use_mipfilter           = true
movingmap_offset_center.additive_alpha          = true
movingmap_offset_center.h_clip_relation         = h_clip_relations.COMPARE
movingmap_offset_center.level                   = NS430_DEFAULT_LEVEL --NS430_DEFAULT_LEVEL
movingmap_offset_center.parent_element	        = "moving_map_clip"
movingmap_offset_center.isvisible               = false
Add(movingmap_offset_center)


local movingmap_rot_center                   = CreateElement "ceSimple"
movingmap_rot_center.name                    = "navu_moving_map_center_rot"
movingmap_rot_center.init_pos                = {0, 0, 0}
movingmap_rot_center.element_params          = {"MAP_ROTATION"}
movingmap_rot_center.controllers             = {{"rotate_using_parameter", 0, 0.0174532925199433},}
movingmap_rot_center.collimated	             = true
movingmap_rot_center.use_mipfilter           = true
movingmap_rot_center.additive_alpha          = true
movingmap_rot_center.h_clip_relation         = h_clip_relations.COMPARE
movingmap_rot_center.level                   = NS430_DEFAULT_LEVEL --NS430_DEFAULT_LEVEL
movingmap_rot_center.parent_element	         = "navu_moving_map_center_offset"
movingmap_rot_center.isvisible               = false
Add(movingmap_rot_center)

local movingmap_move_center                   = CreateElement "ceSimple"
movingmap_move_center.name                    = "navu_moving_map_center"
movingmap_move_center.init_pos                = {0, 0, 0}
movingmap_move_center.element_params          = {"MAP_CENTER_Y", "MAP_CENTER_X"}
movingmap_move_center.controllers             = {{"move_up_down_using_parameter",0,map_scaler},{"move_left_right_using_parameter",1,map_scaler}}
movingmap_move_center.collimated	          = true
movingmap_move_center.use_mipfilter           = true
movingmap_move_center.additive_alpha          = true
movingmap_move_center.h_clip_relation         = h_clip_relations.COMPARE
movingmap_move_center.level                   = NS430_DEFAULT_LEVEL --NS430_DEFAULT_LEVEL
movingmap_move_center.parent_element	      = "navu_moving_map_center_rot"
movingmap_move_center.isvisible               = false
Add(movingmap_move_center)

local aircraft_pos_icon 				   = CreateElement "ceTexPoly"
aircraft_pos_icon.vertices                 = GPS_vert_gen(140,140)
aircraft_pos_icon.indices                  = {0,1,2,2,3,0}
aircraft_pos_icon.tex_coords               = tex_coord_gen(1536,128,128,128,2048,2048)
aircraft_pos_icon.material                 = basic_ns430_material --"DBG_GREEN"--blue_ns430_material
aircraft_pos_icon.name 			           = create_guid_string()
aircraft_pos_icon.init_pos                 = {0, 0, 0}
aircraft_pos_icon.init_rot		           = {0, 0, 0}
aircraft_pos_icon.collimated	           = true
aircraft_pos_icon.element_params           = {"POS_SYMBOL_ENABLE", "MAP_CRAFT_SYMB_ROT"}
aircraft_pos_icon.controllers              = {{"opacity_using_parameter",0},{"rotate_using_parameter", 1, 0.0174532925199433},}
aircraft_pos_icon.use_mipfilter            = true
aircraft_pos_icon.additive_alpha           = true
aircraft_pos_icon.h_clip_relation          = h_clip_relations.COMPARE
aircraft_pos_icon.level                    = NS430_DEFAULT_LEVEL
aircraft_pos_icon.parent_element	       = "navu_moving_map_center_offset"
Add(aircraft_pos_icon)

-- Moving map airport display, max 100 airports
-- 310 * 310 in display -> equal to 1900 * 1900  360 * 1024 
for i = 0, 200, 1 do
    -- airport icon
    local airport_icon 				      = CreateElement "ceTexPoly"
    airport_icon.vertices                 = GPS_vert_gen(128, 128)
    airport_icon.indices                  = {0,1,2,2,3,0}
    airport_icon.tex_coords               = tex_coord_gen(1536,0,128,128,2048,2048)
    airport_icon.material                 = basic_ns430_material --"DBG_RED"--blue_ns430_material
    airport_icon.name 			          = create_guid_string()
    airport_icon.init_pos                 = {0, 0, 0}
    airport_icon.init_rot		          = {0, 0, 0}
    airport_icon.collimated	              = true
    airport_icon.element_params           = {"AIRPORT_ENABLE_"..i, "AIRPORT_LON_"..i, "AIRPORT_LAT_"..i}
    airport_icon.controllers              = {{"opacity_using_parameter",0},{"move_up_down_using_parameter",2,map_scaler},{"move_left_right_using_parameter",1,map_scaler}}
    airport_icon.use_mipfilter            = true
    airport_icon.additive_alpha           = true
    airport_icon.h_clip_relation          = h_clip_relations.COMPARE
    airport_icon.level                    = NS430_DEFAULT_LEVEL
    airport_icon.parent_element	          = "navu_moving_map_center"
    Add(airport_icon)

    -- text for airport name
    local airport_name             = CreateElement "ceStringPoly" --Create a character output element "ceTexPoly" means to create a texture model
    airport_name.material          = "BS430_font_white"    --FONT_             --Material type (note the font material created above)
    airport_name.init_pos          = {0, -68 / default_gps_x}         -- This is the coordinates of the alignment point [this is the maximum limit of the current model (do not exceed when aligning the corners)]
    airport_name.alignment         = "CenterTop"       --Alignment settings：Left/Right/Center; Top/Down/Center
    airport_name.stringdefs        = {0.85 *0.004, 1 * 0.004, 0, 0}    --{ecrase vertical si inf a 0.01,ecrase lateral * streccth, 0, 0} The first value controls the width, the second value controls the height
    airport_name.formats           = {"%s", "%s"}
    airport_name.element_params    = {"AIRPORT_ENABLE_"..i, "AIRPORT_LON_"..i, "AIRPORT_LAT_"..i, "AIRPORT_NAME_"..i} -- top left first line display
    airport_name.controllers       = {{"opacity_using_parameter",0},{"move_up_down_using_parameter",2,map_scaler},{"move_left_right_using_parameter",1,map_scaler},{"text_using_parameter",3}}
    airport_name.collimated        = true
    airport_name.use_mipfilter     = true
    airport_name.additive_alpha    = true
    airport_name.isvisible		   = true
    airport_name.h_clip_relation   = h_clip_relations.COMPARE -- INCREASE_IF_LEVEL-- --REWRITE_LEVEL
    airport_name.level			   = NS430_DEFAULT_LEVEL
    airport_name.parent_element    = "navu_moving_map_center"  --Parent node name - can bind parent nodes that are not on the same layer
    Add(airport_name)
end

for i = 0, 99, 1 do
-- "BS430_WP_LON_" "BS430_WP_ENABLE_"
    local test_line                     = CreateElement "ceSimpleLineObject"
    test_line.material                  = "BS430_PURPLE"
    test_line.name 			            = create_guid_string()
    -- test_line.primitivetype          = "lines"
    test_line.width                     = 10/default_gps_x
    test_line.vertices                  = {{0,0}, {0,1}}	
    -- test_line.tex_coords             = tex_coord_gen(1536,0,128,128,2048,2048)
    test_line.init_pos                  = {0, 0, 0}
    test_line.init_rot		            = {0, 0, 0}
    test_line.collimated	            = true
    test_line.element_params            = {"BS430_WP_ENABLE_"..tostring(i+1), "BS430_WP_LON_"..tostring(i), "BS430_WP_LAT_"..tostring(i), "BS430_WP_LON_"..tostring(i+1), "BS430_WP_LAT_"..tostring(i+1)}
    test_line.controllers               = {{"opacity_using_parameter",0},{"line_object_set_point_using_parameters", 0, 1, 2, map_scaler, map_scaler},{"line_object_set_point_using_parameters", 1, 3, 4, map_scaler, map_scaler}}
    test_line.use_mipfilter             = true
    test_line.additive_alpha            = true
    test_line.h_clip_relation           = h_clip_relations.COMPARE
    test_line.level                     = NS430_DEFAULT_LEVEL
    test_line.parent_element	        = "navu_moving_map_center"
    Add(test_line)

    -- airport icon
    local waypoint_icon 				    = CreateElement "ceTexPoly"
    waypoint_icon.vertices                  = create_GPS_circle_pos(8, 0, 0, 15)
    waypoint_icon.indices                   = create_GPS_circle_index(8)
    -- waypoint_icon.tex_coords                = tex_coord_gen(1536,0,128,128,2048,2048)
    waypoint_icon.material                  = "DBG_WHITE"--basic_ns430_material --"DBG_RED"--blue_ns430_material
    waypoint_icon.name 			            = create_guid_string()
    waypoint_icon.init_pos                  = {0, 0, 0}
    waypoint_icon.init_rot		            = {0, 0, 0}
    waypoint_icon.collimated	            = true
    waypoint_icon.element_params            = {"BS430_WP_ENABLE_"..tostring(i), "BS430_WP_LON_"..tostring(i), "BS430_WP_LAT_"..tostring(i)}
    waypoint_icon.controllers               = {{"opacity_using_parameter",0},{"move_up_down_using_parameter",2,map_scaler},{"move_left_right_using_parameter",1,map_scaler}}
    waypoint_icon.use_mipfilter             = true
    waypoint_icon.additive_alpha            = true
    waypoint_icon.h_clip_relation           = h_clip_relations.COMPARE
    waypoint_icon.level                     = NS430_DEFAULT_LEVEL
    waypoint_icon.parent_element	        = "navu_moving_map_center"
    Add(waypoint_icon)    
end

-- here start the textures for maps
-- 
local Map_Scaler_Preset = {0.5, 1, 2, 3.2, 8, 16, 32, 80};
function state_map_scale_coord_gen()
    temp = {}
    for i = 1, 8, 1 do
        temp[i] = cen_tex_coord_gen(1024,1024,1024*80/Map_Scaler_Preset[i],1024*80/Map_Scaler_Preset[i],2048,2048);
    end
    return temp
end
local temp_map_size = 2700;
function get_map_verts(lon_min, lon_max, lat_min, lat_max)
    local map_width = 36000*math.cos(math.rad(0.5*(lat_max+lat_min)))*(lon_max-lon_min)
    local map_height = 36000*(lat_max-lat_min)
    return GPS_vert_gen(map_width, map_height)
end

-- map materials
water_ns430_caucasus_material = MakeMaterial(GPS_IND_TEX_PATH.."NAVU_IND_WATER_Caucasus.dds", {0,50,150,255})
water_ns430_persiangulf_material = MakeMaterial(GPS_IND_TEX_PATH.."NAVU_IND_WATER_PersianGulf.dds", {0,50,150,255})

-- Longitude_Scaler = cos(temp_map_center.y * DEG_2_RAD);
local water_map_caucasus 				    = CreateElement "ceTexPoly"
water_map_caucasus.vertices                 =  get_map_verts(35,47,41,47) --GPS_vert_gen(2*80*temp_map_size*math.cos(math.rad(44)),80*temp_map_size)
water_map_caucasus.indices                  = {0,1,2,2,3,0}
water_map_caucasus.state_tex_coords         = state_map_scale_coord_gen()
water_map_caucasus.material                 = water_ns430_caucasus_material --"DBG_GREEN"--blue_ns430_material
water_map_caucasus.name 			        = create_guid_string()
water_map_caucasus.init_pos                 = {0, 0, 0}
water_map_caucasus.init_rot		            = {0, 0, 0}
water_map_caucasus.collimated	            = true
water_map_caucasus.element_params           = {"WATER_MAP_Caucasus", "MAP_SCALE_FACTOR"}
water_map_caucasus.controllers              = {{"opacity_using_parameter",0},{"change_texture_state_using_parameter",1}}
water_map_caucasus.use_mipfilter            = true
water_map_caucasus.additive_alpha           = true
water_map_caucasus.h_clip_relation          = h_clip_relations.COMPARE
water_map_caucasus.level                    = NS430_DEFAULT_LEVEL
water_map_caucasus.parent_element	        = "navu_moving_map_center"
Add(water_map_caucasus)

-- NAVU_IND_WATER_PersianGulf
local water_map_caucasus 				    = CreateElement "ceTexPoly"
water_map_caucasus.vertices                 =  get_map_verts(48,62,20,32) --GPS_vert_gen(2*80*temp_map_size*math.cos(math.rad(44)),80*temp_map_size)
water_map_caucasus.indices                  = {0,1,2,2,3,0}
water_map_caucasus.state_tex_coords         = state_map_scale_coord_gen()
water_map_caucasus.material                 = water_ns430_persiangulf_material --"DBG_GREEN"--blue_ns430_material
water_map_caucasus.name 			        = create_guid_string()
water_map_caucasus.init_pos                 = {0, 0, 0}
water_map_caucasus.init_rot		            = {0, 0, 0}
water_map_caucasus.collimated	            = true
water_map_caucasus.element_params           = {"WATER_MAP_PersianGulf", "MAP_SCALE_FACTOR"}
water_map_caucasus.controllers              = {{"opacity_using_parameter",0},{"change_texture_state_using_parameter",1}}
water_map_caucasus.use_mipfilter            = true
water_map_caucasus.additive_alpha           = true
water_map_caucasus.h_clip_relation          = h_clip_relations.COMPARE
water_map_caucasus.level                    = NS430_DEFAULT_LEVEL
water_map_caucasus.parent_element	        = "navu_moving_map_center"
Add(water_map_caucasus)