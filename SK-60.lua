SK_60 =  {
      
		Name 			= 'SK-60',--AG
		DisplayName		= _('SK60B'),--AG
        Picture 		= "SK60.png",
        Rate 			= "50",
        Shape			= "SK-60",--AG	
        WorldID			=  WSTYPE_PLACEHOLDER, 
        
	shape_table_data 	= 
	{
		{
			file  	 	= 'SK-60';--AG
			life  	 	= 180; -- lifebar
			vis   	 	= 2; -- visibility gain.
			desrt    	= 'NCPC-7_destr'; -- Name of destroyed object file name
			fire  	 	= { 300, 2}; -- Fire on the ground after destoyed: 300sec 2m
			username	= 'SK-60';--AG
			index       =  WSTYPE_PLACEHOLDER;
			classname   = "lLandPlane";
			positioning = "BYNORMAL";
		},
		--[[
		{
			name  		= "NCPC-7_destr";
			file  		= "NCPC-7_destr";
			fire  		= { 240, 2};
		},]]
	},

	-- apply the SK-60 for all countries currently
	Countries = {"Abkhazia","Australia","Austria","Belarus","Belgium","Brazil","Bulgaria","Canada","China","Croatia",
	"Czech Republic","Denmark","Egypt","Finland","France","Georgia","Germany","Greece","Hungary",
	"India","Insurgents","Iran","Iraq","Israel","Italy","Japan","Kazakhstan","The Netherlands","North Korea",
	"Norway","Pakistan","Poland","Romania","Russia","Saudi Arabia","Serbia","Slovakia","South Korea",
	"South Ossetia","Spain","Sweden","Switzerland","Syria","Turkey","UK","Ukraine","USA","USAF Aggressors"},
	
	
	mapclasskey 		= "P0091000025",
	--attribute  		= {wsType_Air, wsType_Airplane, wsType_Fighter, F_15, "Fighters", "Refuelable",},--AG WSTYPE_PLACEHOLDER
	attribute  			= {wsType_Air, wsType_Airplane, wsType_Fighter, WSTYPE_PLACEHOLDER,"Battleplanes",},--AG WSTYPE_PLACEHOLDER
	Categories			= {"{78EFB7A2-FD52-4b57-A6A6-3BF0E1D6555F}", "Interceptor",},
	
	----------AI DEFS------------------------------------
		M_empty 					=   2150, -- kg	-- kg  with pilot and nose load
		M_nominal					=	3600,	-- kg (Empty Plus Full Internal Fuel)
		M_max						=	4000,	-- kg (Maximum Take Off Weight)
		M_fuel_max					=	1640,	-- kg (Internal Fuel Only) use the JP-5 fuel 6.8 lbs/gal, 0.82 kg/L
		H_max						=	13500,	-- m  (Maximum Operational Ceiling)
		average_fuel_consumption	=	0.172,
		CAS_min						=	56,		-- Minimum CAS speed (m/s) (for AI)
		V_opt						=	200,	-- Cruise speed (m/s) (for AI)
		V_take_off					=	82,		-- Take off speed in m/s (for AI)
		V_land						=	50,		-- Land speed in m/s (for AI)
		has_afteburner				=	false,
		has_speedbrake				=	true,
		radar_can_see_ground		=	true,

		--nose_gear_pos 				                = {5.981,	-1.906,	0},   --{6.30,	-1.75,	0},
		---nose_gear_pos 				                = {-0.001,	-1.2,	4.032},   --{6.30,	-1.75,	0},
	    --nose_gear_amortizer_direct_stroke   		= -0.118,      -- down from nose_gear_pos !!!
	    --nose_gear_amortizer_reversal_stroke  		=  0.317,      -- up 
	    --nose_gear_amortizer_normal_weight_stroke 	= -0.199,      -- down from nose_gear_pos
	    --nose_gear_wheel_diameter 	                =  0.674,  -- in m .754
	
	    --main_gear_pos 						 	    = {-0.472,	-1.685,	1.598},-- maingear coord {-1.598,	-1.685,	2.380},
		---main_gear_pos 						 	    = {2.380,	-1.685,	-1.598},-- maingear coord
	    --main_gear_amortizer_direct_stroke	 	    =  -0.228,     --  down from main_gear_pos !!! -0.228
	    --main_gear_amortizer_reversal_stroke  	    =  0.221,     --  up 0.221
	    --main_gear_amortizer_normal_weight_stroke    =  -0.228,     --  down from main_gear_pos -0.228
	    --main_gear_wheel_diameter 				    =   0.972, --  in m  
		
		nose_gear_pos 				                = {3.5, -1.5, 0},	-- {4.35,	-1.25,	0},
		--nose_gear_pos 				                = {-0.001,	-1.2,	4.032},   --{6.30,	-1.75,	0},
	    nose_gear_amortizer_direct_stroke   		=  0,      -- down from nose_gear_pos !!!
	    nose_gear_amortizer_reversal_stroke  		=  - 0.15,      -- up 
	    nose_gear_amortizer_normal_weight_stroke 	=  - 0.05,      -- down from nose_gear_pos
		nose_gear_wheel_diameter 	                =  0.4,  -- in m
		tand_gear_max								=  0.5774,	-- +- 30 deg for both sides 
	
	    main_gear_pos 						 	    = {- 0.428, -1.334, 1.15}, --{0.598,	-1.05,	1.05},
		--main_gear_pos 						 	    = {2.380,	-1.32,	-1.598},-- maingear coord
	    main_gear_amortizer_direct_stroke	 	    =   0,     --  down from main_gear_pos !!!
	    main_gear_amortizer_reversal_stroke  	    =  - 0.07,     --  up 
	    main_gear_amortizer_normal_weight_stroke  	=  - 0.035,     --  down from main_gear_pos
	    main_gear_wheel_diameter 				    =   0.572, --  in m
		

		AOA_take_off				=	0.16,	-- AoA in take off (for AI)
		stores_number				=	8,
		bank_angle_max				=	60,		-- Max bank angle (for AI)
		Ny_min						=	-2.5,		-- Min G (for AI)
		Ny_max						=	8,		-- Max G (for AI)
		-- adjust speed
		V_max_sea_level				=	263.889,	-- Max speed at sea level in m/s (for AI)
		V_max_h						=	244.444,	-- Max speed at max altitude in m/s (for AI)
		-- wing area is corrected
		wing_area					=	16.3,	-- wing area in m2
		-- thrust has been reset to what it should be
		thrust_sum_max				=	2585.476,	-- thrust in kgf (64.3 kN)
		thrust_sum_ab				=	2585.476,	-- thrust in kgf (95.1 kN)
		-- 10000 ft/min
		Vy_max						=	30.8,		-- Max climb speed in m/s (for AI)
		flaps_maneuver				=	1, -- flap position for take-off
		Mach_max					=	0.81,	-- Max speed in Mach (for AI)
		range						=	2800,	-- Max range in km (for AI)
		RCS							=	2.5,		-- Radar Cross Section m2
		Ny_max_e					=	8,		-- Max G (for AI)
		detection_range_max			=	60,
		IR_emission_coeff			=	0.5,	-- Normal engine -- IR_emission_coeff = 1 is Su-27 without afterburner. It is reference.
		IR_emission_coeff_ab		=	0,		-- With afterburner
		tanker_type					=	2,		--F14=2/S33=4/M29=0/S27=0/F15=1/F16=1/To=0/F18=2/A10A=1/M29K=4/M2000=2/F4=0/F5=0/
		wing_span					=	9.5,	--XX   wing spain in m 13.05 19.54 
		wing_type 					= 	0,		-- 0=FIXED_WING/ 1=VARIABLE_GEOMETRY/ 2=FOLDED_WING/ 3=ARIABLE_GEOMETRY_FOLDED
		length						=	10.8,	--XX
		height						=	2.7,	--XX
		crew_size					=	2, 		--XX
		engines_count				=	2, 		--XX
		wing_tip_pos 				= 	{ -1 , 0, -4.6},-- wingtip coords for visual effects
		
		EPLRS 					    = true,--can you be seen on the A-10C TAD Page?
		TACAN_AA					= true,--I think this will not work for a client slot but AI might add a TACAN for the unit.

	sounderName = "Aircraft/Planes/SK60_Sound",
	
	engines_nozzles = {
		[1] = 
		{
			pos 		        = {- 2.7, 0, 0.7668}, -- nozzle coords
			elevation           = 0,                -- AFB cone elevation
			diameter	        = 0,                -- AFB cone diameter
			exhaust_length_ab   = 0,                -- lenght in m
			exhaust_length_ab_K = 0,             -- AB animation
			smokiness_level 	= 0.0
		},  -- end of [1]
		[2] = 
		{
			pos 		        = {- 2.7, 0, -0.7668}, -- -07668 Y = -3469
			elevation           = 0,                -- AFB cone elevation
			diameter	        = 0,                -- AFB cone diameter
			exhaust_length_ab   = 0,                -- lenght in m
			exhaust_length_ab_K = 0,             -- AB animation
			smokiness_level 	= 0.0
		},  -- end of [1]
	},      -- end of engines_nozzles
		
		crew_members = 
		{
			[1] = 
			{
				ejection_seat_name	=	17,--17=FA-18 58=F-15
				drop_canopy_name	=	0;  --need to update this .EDM file for it to work again.
				pos = 	{6.49,	0.94,	- 0.4},
				g_suit 			    =  6,
				can_be_playable   	= true,
				canopy_arg          = 38,
				ejection_order    	= 2,
				ejection_added_speed= {-3,15,-3}, --pilot on the left
				role      			= "pilot",
				role_display_name   = _("Pilot"),
			}, -- end of [1]
			[2] = 
			{
				ejection_seat_name	=	17,--17=FA-18 58=F-15
				drop_canopy_name	=	0;  --need to update this .EDM file for it to work again.
				pos = 	{6.49,	0.94,	0.4},
				g_suit 			    =  6,
				can_be_playable   	= true,
				canopy_arg          = 38,
				ejection_order    	= 2,
				ejection_added_speed= {-3,15,-3}, --pilot on the right
				role      			= "pilot",
				role_display_name   = _("Pilot"),
			},
		},
		
		brakeshute_name	=	0,
		is_tanker	=	false,
		air_refuel_receptacle_pos = 	{8.319,	0.803,	1.148},
		
		fires_pos =
		{
			[1] =     	{-1,    	0.5,    	0		},		-- fuselage
			[2] =     	{-0,    	0.2,    	0.9		},		-- wing inner right: WING_R_IN
			[3] =     	{-0,    	0.2,    	-0.9	},		-- wing inner left: WING_L_IN
			[4] =     	{-0.5,    	0,	    	0.9		},		-- ? unknow, maybe wing center R?
			[5] =     	{-0.5,    	0,	    	-0.9	},		-- ? unknow, maybe wing center L?
			[6] =     	{-0.5,    	0,	    	3.0		},  	-- wing outer right: WING_R_OUT
			[7] =     	{-0.5,    	0,			-3.0	}, 		-- wing outer left: WING_L_OUT
			[8] =     	{-1.5,    	0,	    	1.0		},		-- left engine
			[9] =     	{-1.5,    	0,  	  	-1.0	},    	-- right engine
			[10] = 		{-0.515,	0.807,		0.7		},		-- unknow but they are reverse to xy plane
			[11] = 		{-0.515,	0.807,		-0.7	},
		}, -- end of fires_pos
		
		chaff_flare_dispenser = 
		{
			[1] = 
			{
				dir = 	{0,	0,	0},
				pos = 	{-1.453,	-0.406,	1.467}, --{-1.453,	-0.206,	1.467},
			}, 
			[2] = 
			{
				dir = 	{0,	0,	0},
				pos = 	{-1.453,	-0.406,	-1.467}, --{-3.776,	-2.0,	0.422},
			}, 
		}, 

-- Countermeasures 
		passivCounterm = {
			CMDS_Edit = true,
			SingleChargeTotal = 240,
			chaff = {default = 120, increment = 30, chargeSz = 1},
			flare = {default = 120, increment = 15, chargeSz = 2}
        },
	
        CanopyGeometry 	= {
            azimuth 	= {-145.0, 145.0},-- pilot view horizontal (AI)
            elevation 	= {-50.0, 90.0}-- pilot view vertical (AI)
        },

Sensors 		= {
},
Countermeasures = {
ECM 			= "AN/ALQ-135"--F15
},
	Failures = {
			{ id = 'asc', 		label = _('ASC'), 		enable = false, hh = 0, mm = 0, mmint = 1, prob = 100 },
			{ id = 'autopilot', label = _('AUTOPILOT'), enable = false, hh = 0, mm = 0, mmint = 1, prob = 100 },
			{ id = 'hydro',  	label = _('HYDRO'), 	enable = false, hh = 0, mm = 0, mmint = 1, prob = 100 },
			{ id = 'l_engine',  label = _('L-ENGINE'), 	enable = false, hh = 0, mm = 0, mmint = 1, prob = 100 },
			{ id = 'r_engine',  label = _('R-ENGINE'), 	enable = false, hh = 0, mm = 0, mmint = 1, prob = 100 },
			{ id = 'radar',  	label = _('RADAR'), 	enable = false, hh = 0, mm = 0, mmint = 1, prob = 100 },
		  --{ id = 'eos',  		label = _('EOS'), 		enable = false, hh = 0, mm = 0, mmint = 1, prob = 100 },
		  --{ id = 'helmet',  	label = _('HELMET'), 	enable = false, hh = 0, mm = 0, mmint = 1, prob = 100 },
			{ id = 'mlws',  	label = _('MLWS'), 		enable = false, hh = 0, mm = 0, mmint = 1, prob = 100 },
			{ id = 'rws',  		label = _('RWS'), 		enable = false, hh = 0, mm = 0, mmint = 1, prob = 100 },
			{ id = 'ecm',   	label = _('ECM'), 		enable = false, hh = 0, mm = 0, mmint = 1, prob = 100 },
			{ id = 'hud',  		label = _('HUD'), 		enable = false, hh = 0, mm = 0, mmint = 1, prob = 100 },
			{ id = 'mfd',  		label = _('MFD'), 		enable = false, hh = 0, mm = 0, mmint = 1, prob = 100 },		
	},
	HumanRadio = {
		frequency 		= 127.5,  -- Radio Freq
		editable 		= true,
		minFrequency	= 100.000,
		maxFrequency 	= 156.000,
		modulation 		= MODULATION_AM
	},

--Guns = {gun_mount("M_61", { count = 480 },{muzzle_pos = {0.50000, 0.500000, -0.000000}})},   --M_61 is F-15C Mounted Gun

--pylons_enumeration = {1, 11, 10, 2, 3, 9, 4, 8, 5, 7, 6},
--pylons_enumeration = {2, 1, 3, 4, 5, 6, 7, 8, 9, 11, 10},  --test for new setup
--pylons_enumeration = {6, 5, 4, 8, 7, 3, 2, 1},
pylons_enumeration = {6, 5, 4, 8, 7, 3, 2, 1},
	
	Pylons =     {
        pylon(1, 0, 0, 0, 0,	-- 0, 0.1, -2.2, --Left Wing pylon 2
            {
				use_full_connector_position = true, connector = "pylon_left_1", arg = 992, arg_value = 0,
				DisplayName 	= "8",
            },
            {
				--{CLSID = "{d694b359-e7a8-4909-88d4-7100b77afd10}", arg_value = 1, arg_increment = 0.1}, -- 135 rocket * 2
				{CLSID = "{d694b359-e7a8-4909-88d4-7100b77afd11}", arg_value = 1, arg_increment = 0.1,
					forbidden = {
						{station = 2, loadout = {"{5d5aa063-a002-4de8-8a89-6eda1e80ee7b}"}},
					}
				}, -- 145 rocket * 2
				{CLSID = "{d694b359-e7a8-4909-88d4-7100b77afd12}", arg_value = 1, arg_increment = 0.1,
					forbidden = {
						{station = 2, loadout = {"{5d5aa063-a002-4de8-8a89-6eda1e80ee7b}"}},
					}
				}, -- 145 rocket * 1
				{CLSID = "{d694b359-e7a8-4909-88d4-7100b77afd13}", arg_value = 1, arg_increment = 0.1,
					forbidden = {
						{station = 2, loadout = {"{5d5aa063-a002-4de8-8a89-6eda1e80ee7b}"}},
					}
				}, -- 135 rocket * 1
            }
        ),

        pylon(2, 0, 0, 0, 0,	-- 0, 0.1, -2.2, --Left Wing pylon 2
            {
				use_full_connector_position = true, connector = "pylon_left_2", arg = 994, arg_value = 0,
				DisplayName 	= "7",
            },
            {
				{CLSID = "{5d5aa063-a002-4de8-8a89-6eda1e80ee7b}",  arg_value = 1, arg_increment = 0.1, attach_point_position = {0.4, -0.22, 0.0},
					forbidden = {
						{station = 1, loadout = {"{d694b359-e7a8-4909-88d4-7100b77afd10}"}},
						{station = 1, loadout = {"{d694b359-e7a8-4909-88d4-7100b77afd11}"}},
						{station = 1, loadout = {"{d694b359-e7a8-4909-88d4-7100b77afd12}"}},
						{station = 1, loadout = {"{d694b359-e7a8-4909-88d4-7100b77afd13}"}},
						{station = 3, loadout = {"{d694b359-e7a8-4909-88d4-7100b77afd10}"}},
						{station = 3, loadout = {"{d694b359-e7a8-4909-88d4-7100b77afd11}"}},
						{station = 3, loadout = {"{d694b359-e7a8-4909-88d4-7100b77afd12}"}},
						{station = 3, loadout = {"{d694b359-e7a8-4909-88d4-7100b77afd13}"}},
					}
				}, -- AKAN gun pod
				--{CLSID = "{ARAKM70BHE}"}, -- ARAK M70HE pod
				--{CLSID = "{ARAKM70BAP}"}, -- ARAK M70AP pod
				--{CLSID = "{M71BOMB}"}, -- HE bomb
				--{CLSID = "{M71BOMBD}"}, -- HE bomb w chute
				--{CLSID = "{LYSBOMB}"}, -- Illumination bomb
				--{CLSID = "{BRU33_2X_MK-82}", arg_value = 0.5}, -- Mk-82 * 2 -- 暂无双联挂架

				--{CLSID = "{d694b359-e7a8-4909-88d4-7100b77afd10}", arg_value = 1, arg_increment = 0.1, attach_point_position = { -0.035, 0.07, 0.0}}, -- 145 rocket * 2
				{CLSID = "{d694b359-e7a8-4909-88d4-7100b77afd11}", arg_value = 1, arg_increment = 0.1, attach_point_position = { -0.035, 0.07, 0.0}}, -- 145 rocket * 2
				{CLSID = "{d694b359-e7a8-4909-88d4-7100b77afd12}", arg_value = 1, arg_increment = 0.1, attach_point_position = { -0.035, 0.07, 0.0}}, -- 145 rocket * 1
				{CLSID = "{d694b359-e7a8-4909-88d4-7100b77afd13}", arg_value = 1, arg_increment = 0.1, attach_point_position = { -0.035, 0.07, 0.0}}, -- 135 rocket * 1
			}
        ),

		pylon(3, 0, 0, 0, 0,	-- 0, 0.1, -2.2, --Left Wing pylon 2
			{
				use_full_connector_position = true, connector = "pylon_left_3", arg = 996, arg_value = 0,
				DisplayName 	= "6",
			},
			{
				--{CLSID = "{d694b359-e7a8-4909-88d4-7100b77afd10}", arg_value = 1, arg_increment = 0.1, attach_point_position = { -0.135, 0.005, 0.0}}, -- 135 rocket * 2
				{CLSID = "{d694b359-e7a8-4909-88d4-7100b77afd11}", arg_value = 1, arg_increment = 0.1, attach_point_position = { -0.135, 0.005, 0.0},
					forbidden = {
						{station = 2, loadout = {"{5d5aa063-a002-4de8-8a89-6eda1e80ee7b}"}},
					}
				}, -- 145 rocket * 2
				{CLSID = "{d694b359-e7a8-4909-88d4-7100b77afd12}", arg_value = 1, arg_increment = 0.1, attach_point_position = { -0.135, 0.005, 0.0},
					forbidden = {
						{station = 2, loadout = {"{5d5aa063-a002-4de8-8a89-6eda1e80ee7b}"}},
					}
				}, -- 145 rocket * 1
				{CLSID = "{d694b359-e7a8-4909-88d4-7100b77afd13}", arg_value = 1, arg_increment = 0.1, attach_point_position = { -0.135, 0.005, 0.0},
					forbidden = {
						{station = 2, loadout = {"{5d5aa063-a002-4de8-8a89-6eda1e80ee7b}"}},
					}
				}, -- 135 rocket * 1
			}
		),

		pylon(4, 0, 0, 0, 0,	-- 0, 0.1, -2.2, --Left Wing pylon 2
			{
				use_full_connector_position = true, connector = "pylon_right_3", arg = 995, arg_value = 0,
				DisplayName 	= "3",
			},
			{
				--{CLSID = "{d694b359-e7a8-4909-88d4-7100b77afd10}", arg_value = 1, arg_increment = 0.1, attach_point_position = { -0.135, 0.005, 0.0}}, -- 135 rocket * 2
				{CLSID = "{d694b359-e7a8-4909-88d4-7100b77afd11}", arg_value = 1, arg_increment = 0.1, attach_point_position = { -0.135, 0.005, 0.0},
					forbidden = {
						{station = 5, loadout = {"{5d5aa063-a002-4de8-8a89-6eda1e80ee7b}"}},
					}
				}, -- 145 rocket * 2
				{CLSID = "{d694b359-e7a8-4909-88d4-7100b77afd12}", arg_value = 1, arg_increment = 0.1, attach_point_position = { -0.135, 0.005, 0.0},
					forbidden = {
						{station = 5, loadout = {"{5d5aa063-a002-4de8-8a89-6eda1e80ee7b}"}},
					}
				}, -- 145 rocket * 1
				{CLSID = "{d694b359-e7a8-4909-88d4-7100b77afd13}", arg_value = 1, arg_increment = 0.1, attach_point_position = { -0.135, 0.005, 0.0},
					forbidden = {
						{station = 5, loadout = {"{5d5aa063-a002-4de8-8a89-6eda1e80ee7b}"}},
					}
				}, -- 135 rocket * 1
			}
		),

        pylon(5, 1, 0, 0, 0, 	--0, 0.1, 2.2, --Right Wing Pylon 2
            {
				use_full_connector_position = true, connector = "pylon_right_2", arg = 993, arg_value = 0,
				DisplayName 	= "2",
            },
            {
				{CLSID = "{5d5aa063-a002-4de8-8a89-6eda1e80ee7b}",  arg_value = 1, arg_increment = 0.1, attach_point_position = {0.4, -0.22, 0.0},
					forbidden = {
						{station = 4, loadout = {"{d694b359-e7a8-4909-88d4-7100b77afd10}"}},
						{station = 4, loadout = {"{d694b359-e7a8-4909-88d4-7100b77afd11}"}},
						{station = 4, loadout = {"{d694b359-e7a8-4909-88d4-7100b77afd12}"}},
						{station = 4, loadout = {"{d694b359-e7a8-4909-88d4-7100b77afd13}"}},
						{station = 6, loadout = {"{d694b359-e7a8-4909-88d4-7100b77afd10}"}},
						{station = 6, loadout = {"{d694b359-e7a8-4909-88d4-7100b77afd11}"}},
						{station = 6, loadout = {"{d694b359-e7a8-4909-88d4-7100b77afd12}"}},
						{station = 6, loadout = {"{d694b359-e7a8-4909-88d4-7100b77afd13}"}},
					}
				}, -- AKAN gun pod
				--{CLSID = "{ARAKM70BHE}"}, -- ARAK M70HE pod
				--{CLSID = "{ARAKM70BAP}"}, -- ARAK M70AP pod
				--{CLSID = "{M71BOMB}"}, -- HE bomb
				--{CLSID = "{M71BOMBD}"}, -- HE bomb w chute
				--{CLSID = "{LYSBOMB}"}, -- Illumination bomb
				--{CLSID = "{BRU33_2X_MK-82}", arg_value = 0.5}, -- Mk-82 * 2 -- 暂无双联挂架
				--{CLSID = "{d694b359-e7a8-4909-88d4-7100b77afd10}", arg_value = 1, arg_increment = 0.1, attach_point_position = { -0.035, 0.07, 0.0}}, -- 145 rocket * 2
				{CLSID = "{d694b359-e7a8-4909-88d4-7100b77afd11}", arg_value = 1, arg_increment = 0.1, attach_point_position = { -0.035, 0.07, 0.0}}, -- 145 rocket * 2
				{CLSID = "{d694b359-e7a8-4909-88d4-7100b77afd12}", arg_value = 1, arg_increment = 0.1, attach_point_position = { -0.035, 0.07, 0.0}}, -- 145 rocket * 1
				{CLSID = "{d694b359-e7a8-4909-88d4-7100b77afd13}", arg_value = 1, arg_increment = 0.1, attach_point_position = { -0.035, 0.07, 0.0}}, -- 135 rocket * 1
			}
        ),

		pylon(6, 0, 0, 0, 0,	-- 0, 0.1, -2.2, --Left Wing pylon 2
			{
				use_full_connector_position = true, connector = "pylon_right_1", arg = 991, arg_value = 0,
				DisplayName 	= "1",
			},
			{
				--{CLSID = "{d694b359-e7a8-4909-88d4-7100b77afd10}", arg_value = 1, arg_increment = 0.1}, -- 135 rocket * 2
				{CLSID = "{d694b359-e7a8-4909-88d4-7100b77afd11}", arg_value = 1, arg_increment = 0.1,
					forbidden = {
						{station = 5, loadout = {"{5d5aa063-a002-4de8-8a89-6eda1e80ee7b}"}},
					}
				}, -- 145 rocket * 2
				{CLSID = "{d694b359-e7a8-4909-88d4-7100b77afd12}", arg_value = 1, arg_increment = 0.1,
					forbidden = {
						{station = 5, loadout = {"{5d5aa063-a002-4de8-8a89-6eda1e80ee7b}"}},
					}
				}, -- 145 rocket * 1
				{CLSID = "{d694b359-e7a8-4909-88d4-7100b77afd13}", arg_value = 1, arg_increment = 0.1,
					forbidden = {
						{station = 5, loadout = {"{5d5aa063-a002-4de8-8a89-6eda1e80ee7b}"}},
					}
				}, -- 135 rocket * 1
			}
		),

		pylon(7, 2, - 2.5, 0, -0.7668,
            {
				use_full_connector_position=true,
				DisplayName 	= "Left Nozzle Smoke",
            },
            {
				--{CLSID = "{3d7bfa20-fefe-4642-ba1f-380d5ae4f9d1}"},-- Smokewinder red
				--{CLSID = "{3d7bfa20-fefe-4642-ba1f-380d5ae4f9d2}"},-- Smokewinder green
				--{CLSID = "{3d7bfa20-fefe-4642-ba1f-380d5ae4f9d3}"},-- Smokewinder blue
				--{CLSID = "{3d7bfa20-fefe-4642-ba1f-380d5ae4f9d4}"},-- Smokewinder white
				--{CLSID = "{3d7bfa20-fefe-4642-ba1f-380d5ae4f9d5}"},-- Smokewinder yellow
				--{CLSID = "{3d7bfa20-fefe-4642-ba1f-380d5ae4f9d6}"},-- Smokewinder orange
            }
        ),

		pylon(8, 2, - 2.5, 0, 0.7668,
			{
				use_full_connector_position=true,
				DisplayName 	= "Right Nozzle Smoke",
			},
			{
				--{CLSID = "{3d7bfa20-fefe-4642-ba1f-380d5ae4f9d1}"},-- Smokewinder red
				--{CLSID = "{3d7bfa20-fefe-4642-ba1f-380d5ae4f9d2}"},-- Smokewinder green
				--{CLSID = "{3d7bfa20-fefe-4642-ba1f-380d5ae4f9d3}"},-- Smokewinder blue
				--{CLSID = "{3d7bfa20-fefe-4642-ba1f-380d5ae4f9d4}"},-- Smokewinder white
				--{CLSID = "{3d7bfa20-fefe-4642-ba1f-380d5ae4f9d5}"},-- Smokewinder yellow
				--{CLSID = "{3d7bfa20-fefe-4642-ba1f-380d5ae4f9d6}"},-- Smokewinder orange
			}
		),
	},
	
	Tasks = {
        aircraft_task(GroundAttack),
		aircraft_task(PinpointStrike),
        aircraft_task(CAS),
        aircraft_task(AFAC),
		aircraft_task(RunwayAttack),
		aircraft_task(SEAD),
		aircraft_task(Escort),
		aircraft_task(Reconnaissance),
    },	
	DefaultTask = aircraft_task(GroundAttack),

	SFM_Data = {
		aerodynamics = -- Cx = Cx_0 + Cy^2*B2 +Cy^4*B4
		{
			Cy0			=	0,       -- zero AoA lift coefficient
			Mzalfa		=	10,      -- coefficients for pitch agility 
			Mzalfadt	=	0.77,    -- coefficients for pitch agility 0.8 -- Plus le chiffre est grand moins le pitch est sensible
			kjx			=	3.50,    -- Inertie roulis 2.70
			kjz			=	0.00125, -- Unknown constant
			Czbe		=	-0.013,  -- coefficient, along Z axis (perpendicular), affects yaw, negative value means force orientation in FC coordinate system
			cx_gear		=	0.065,    -- coefficient, drag, gear
			cx_flap		=	0.087,    -- coefficient, drag, full flaps
			cy_flap		=	0.34,    -- coefficient, normal force, lift, flaps 0.28
			cx_brk		=	0.12,    -- coefficient, drag, air breaks 
			table_data  = 
			{	--      M		Cx0		 	Cya			B		 	B4	    	Omxmax		Aldop		Cymax
				[1] = 	{0.0,	0.020,		0.07,		0.042,		0.012,		2.0,		21,			1.16},
				[2] = 	{0.4,	0.021,		0.07,		0.042,		0.012,		2.0,		21,			1.16},
				[3] = 	{0.5,	0.022,		0.07,		0.042,		0.012,		2.0,		21,			1.16},
				[4] = 	{0.6,	0.022,		0.08,		0.042,		0.012,		4.2,		15,			1.12},
				[5] = 	{0.7,	0.0225,		0.08,		0.052,		0.012,		4.2,		15,			1.12},
				[6] = 	{0.8,	0.0235,		0.08,		0.062,		0.012,		4.2,		11,			1.18},
				[7] = 	{0.9,	0.0868,		0.08,		0.072,		0.012,		4.2,		10,			1.25},
				[8] = 	{1.0,	0.390,		0.08,		0.072,		0.012,		4.2,		10,			2.35},
			}, -- end of table_data
			-- M - Mach number
			-- Cx0 - Coefficient, drag, profile, of the airplane
			-- Cya - Normal force coefficient of the wing and body of the aircraft in the normal direction to that of flight. 
			-- Inversely proportional to the available G-loading at any Mach value.
			--(lower the Cya value, higher G available) per 1 degree AOA
			-- B - Polar quad coeff Coeff de trainée de profil due à la forme de l'aile et la friction de l'air
			-- B4 - Polar 4th power coeff -- Coeff de trainée induite par les vortexs en bout d'aile. 
			-- Si l'AOA augmente, la portance et la trainée également.
			-- Omxmax - roll rate, rad/s
			-- Aldop - Alfadop Max AOA at current M - departure threshold
			-- Cymax - Coefficient, lift, maximum possible (ignores other calculations if current Cy > Cymax)
		},-- end of aerodynamics
		engine = 
		{
			Nmg		=	56.4, -- RPM at idle
			MinRUD	=	0, -- Min state of the throttle
			MaxRUD	=	1, -- Max state of the throttle
			MaksRUD	=	1, -- Military power state of the throttle 1 89
			ForsRUD	=	1, -- Afterburner state of the throttle	94
			typeng	=	0,
			-- [[
				-- E_TURBOJET = 0
				-- E_TURBOJET_AB = 1
				-- E_PISTON = 2
				-- E_TURBOPROP = 3
				-- E_TURBOFAN	= 4
				-- E_TURBOSHAFT = 5
			--]]
			
			hMaxEng	=	13, -- Max altitude for safe engine operation in km
			dcx_eng	=	0.015, -- Engine drag coefficient 0.015
			cemax	=	1.24, -- not used for fuel calculation , only for AI routines to check flight time ( fuel calculation algorithm is built in )
			cefor	=	2.56, -- not used for fuel calculation , only for AI routines to check flight time ( fuel calculation algorithm is built in )
			dpdh_m	=	2000, --  altitude coefficient for max thrust 6600
			dpdh_f	=	16200,  --  altitude coefficient for AB thrust
			table_data = 
			-- take 1000 m as reference
			{		--   M		Pmax		 Pfor	
				[1] = 	{0.0,	17081	},
				[2] = 	{0.1,	15154	},
				[3] = 	{0.2,	13730	},
				[4] = 	{0.3,	12425	},
				[5] = 	{0.4, 	11239	},
				[6] = 	{0.5, 	10913	},
				[7] = 	{0.6, 	9489	},
				[8] = 	{0.7, 	9405	},
				[9] = 	{0.8, 	8900	},
				-- p for is not used
			}, -- end of table_data
			-- M - Mach number
			-- Pmax - Engine thrust at military power
			-- Pfor - Engine thrust at AFB
			extended =
			{
				thrust_max = -- thrust interpolation table by altitude and mach number, 2d table
				{ -- Minimum thrust 2000 kN, maximum thrust 17000 kN
					M 		 = {0,0.1,0.2,0.3,0.4,0.5,0.6,0.7,0.8},
					H		 = {0,3048,6096,9144,11000,12192,13716},
					thrust	 = {-- M 0     		0.1    	0.2   	0.3       0.4     0.5    0.6    0.7     0.8
								{    17081,   15154,   13730,   12425,   11239,	 10913,	 9489,	9045,	8938	},--H = 0 (S. L.)
								{    13967,   12780,   11624,   10586,   9697,	 8955,	 8302,	7799,	7384	},--H = 3048 (10kft)
								{    10615,   9844,    9103,    8391,    7828,   7384,	 7057,	6731,	6435	},--H = 6096 (20kft)
								{    6828,    6553,    6138,    5901,    5782,   5693,	 5604,	5485,	5218	},--H = 9144 (30kft)
								{    5189,    5011,    4833,    4388,    4270,   4329,	 4418,	4507,	4596	},--H = 11000 (36kft)
								{    3944,    3825,    3765,    3706,    3499,   3528,	 3467,	3766,	3855	},--H = 12192 (40kft)
								{    3232,    3113,    3024,    2965,    2787,   2802,	 2846,	2876,	2787	},--H = 13716 (45kft)					
					},
				},
			}, -- end of extended data
		}, -- end of engine
	},

	net_animation = -- transmit animations over network (multiplayer)
	{
        0, -- nose gear
		1, -- nose suspension
		2, -- nose wheel steering
        3, -- right gear
		4, -- right suspension
        5, -- left gear
		6, -- left suspension
        9, -- right flap
        10, -- left flap
        11, -- right aileron
        12, -- left aileron
        15, -- right elevator
        17, -- rudder
        21, -- air brake
        38, -- canopy
		39, -- pilot head
		76,
		77,
		99, 
		190, 
		191, 
		192,
		193, -- launch bar
		194,
		209,
		250, -- wheel chocks, FOD and ladder
		-- multicrew sync test
		520,
		521,
		-- special
		999,
	},


	--damage , index meaning see in  Scripts\Aircrafts\_Common\Damage.lua
	Damage = verbose_to_dmg_properties(
	{
		["AILERON_L"]          	= {critical_damage = 1.8, args = {-1}, construction = {durability = 0.65, skin = "Aluminum"},},
		["AILERON_R"]          	= {critical_damage = 1.8, args = {-1}, construction = {durability = 0.65, skin = "Aluminum"},},
		["FLAP_L"]          	= {critical_damage = 6.4, args = {-1}, construction = {durability = 1.05, skin = "Aluminum"},},
		["FLAP_R"]          	= {critical_damage = 6.4, args = {-1}, construction = {durability = 1.05, skin = "Aluminum"},},
		["WING_L_OUT"]          = {critical_damage = 3, args = {200}, construction = {durability = 2.00, skin = "Aluminum"}, deps_cells = {"AILERON_L"},},
		["WING_R_OUT"]          = {critical_damage = 3, args = {202}, construction = {durability = 2.00, skin = "Aluminum"}, deps_cells = {"AILERON_R"},},
		["WING_L_IN"]           = {critical_damage = 10, args = {201}, construction = {durability = 3.00, skin = "Aluminum"},deps_cells = {"FLAP_L","WING_L_OUT"},},
		["WING_R_IN"]           = {critical_damage = 10, args = {203}, construction = {durability = 3.00, skin = "Aluminum"},deps_cells = {"FLAP_R","WING_R_OUT"},},
		["CREW_1"]              = {critical_damage = 1, args = {-1}, construction = {durability = 2.00, skin = "Fabric"},},
		["CREW_2"]              = {critical_damage = 1, args = {-1}, construction = {durability = 2.00, skin = "Fabric"},},
		["MAIN"]  				= {critical_damage = 10, args = {-1}, construction = {durability = 7.69, skin = "Aluminum"},},
		["TAIL_BOTTOM"]  		= {critical_damage = 10, args = {-1}, },
		["FUSELAGE_BOTTOM"]  	= {critical_damage = 10, args = {-1}, },
		["ENGINE_1"]			= {args = {160},	critical_damage = 2},
		["ENGINE_2"]			= {args = {160},	critical_damage = 2},
	}),
	
	DamageParts = 
	{  
		[1] = "", -- wing R
		[2] = "", -- wing L
		[3] = "", -- nose
		[4] = "", -- tail R
		[5] = "", -- tail L
	},

	lights_data = { typename = "collection", lights = {
	
    [1] = { typename = "collection", -- WOLALIGHT_STROBES
					lights = {	
						{typename = "natostrobelight", argument = 193, period = 1.2, phase_shift = 3},-- beacon lights
							}
			},
	[2] = { typename = "collection",
					lights = {-- 1=Landing light -- 2=Landing/Taxi light
						{typename = "argumentlight", argument = 194, dir_correction = {elevation = math.rad(-1)}},--"MAIN_SPOT_PTR_02","RESERV_SPOT_PTR"
						--{typename = "spotlight", connector = "MAIN_SPOT_PTR", argument = 208, dir_correction = {elevation = math.rad(3)}},--"MAIN_SPOT_PTR_01","RESERV_SPOT_PTR","MAIN_SPOT_PTL",
							}
			},
    [3]	= {	typename = "collection", -- nav_lights_default
					lights = {
						{typename  = "argumentlight",argument  =  190,color = {0.99, 0.11, 0.3}},-- Left Position(red)
						{typename  = "argumentlight",argument  =  191,color = {0, 0.894, 0.6}},-- Right Position(green)
						--{typename  = "omnilight",connector =  "BANO_0"  ,argument  =  192,color = {1, 1, 1}},-- Tail Position white)
							}
			},
	[4] = { typename = "collection", -- formation_lights_default
					lights = {
						{typename  = "argumentlight" ,argument  =  192,},--old aircraft arg 
							}
			},
--[[			
	[5] = { typename = "collection", -- strobe_lights_default
					lights = {
						{typename  = "strobelight",connector =  "RED_BEACON"  ,argument = 193, color = {0.8,0,0}},-- Arg 193, 83,
						{typename  = "strobelight",connector =  "RED_BEACON_2",argument = 194, color = {0.8,0,0}},-- (-1"RESERV_RED_BEACON")
						{typename  = "strobelight",connector =  "RED_BEACON"  ,argument =  83, color = {0.8,0,0}},-- Arg 193, 83,
							}
			},
--]]			
	}},
}

add_aircraft(SK_60)