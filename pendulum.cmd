! CMD Version:2
! Version 2 enables expanded acceptable characters for object names.
! If unspecified, set to 1 or set to an invalid value, Adams View assumes traditional naming requirements.
!
!-------------------------- Default Units for Model ---------------------------!
!
!
defaults units  &
   length = mm  &
   angle = deg  &
   force = newton  &
   mass = kg  &
   time = sec
!
defaults units  &
   coordinate_system_type = cartesian  &
   orientation_type = body313
!
!------------------------ Default Attributes for Model ------------------------!
!
!
defaults attributes  &
   inheritance = bottom_up  &
   icon_visibility = on  &
   grid_visibility = off  &
   size_of_icons = 50.0  &
   spacing_for_grid = 1000.0
!
!--------------------------- Plugins used by Model ----------------------------!
!
!
plugin load  &
   plugin_name = .MDI.plugins.controls
!
!------------------------------ Adams View Model ------------------------------!
!
!
model create  &
   model_name = pendulum
!
view erase
!
!-------------------------------- Data storage --------------------------------!
!
!
data_element create variable  &
   variable_name = .pendulum.ANGLE  &
   adams_id = 2  &
   initial_condition = 0.0  &
   function = ""
!
data_element create variable  &
   variable_name = .pendulum.TORQUE  &
   adams_id = 3  &
   initial_condition = 0.0  &
   function = ""
!
data_element create variable  &
   variable_name = .pendulum.ANG_VEL  &
   adams_id = 4  &
   initial_condition = 0.0  &
   function = ""
!
!--------------------------------- Materials ----------------------------------!
!
!
material create  &
   material_name = .pendulum.steel  &
   adams_id = 1  &
   density = 7.801E-06  &
   youngs_modulus = 2.07E+05  &
   poissons_ratio = 0.29
!
!-------------------------------- Rigid Parts ---------------------------------!
!
! Create parts and their dependent markers and graphics
!
!----------------------------------- ground -----------------------------------!
!
!
! ****** Ground Part ******
!
defaults model  &
   part_name = ground
!
defaults coordinate_system  &
   default_coordinate_system = .pendulum.ground
!
! ****** Markers for current part ******
!
marker create  &
   marker_name = .pendulum.ground.MARKER_5  &
   adams_id = 5  &
   location = 0.0, 0.0, 0.0  &
   orientation = 90.0d, 90.0d, 0.0d
!
marker create  &
   marker_name = .pendulum.ground.MARKER_9  &
   adams_id = 9  &
   location = 0.0, 0.0, 0.0  &
   orientation = 90.0d, 90.0d, 0.0d
!
marker create  &
   marker_name = .pendulum.ground.MARKER_13  &
   adams_id = 13  &
   location = 0.0, 0.0, 0.0  &
   orientation = 0.0d, 0.0d, 0.0d
!
part create rigid_body mass_properties  &
   part_name = .pendulum.ground  &
   material_type = .pendulum.steel
!
! ****** Points for current part ******
!
point create  &
   point_name = .pendulum.ground.POINT_1  &
   location = 0.0, 0.0, 0.0
!
point create  &
   point_name = .pendulum.ground.POINT_2  &
   location = 0.0, 0.0, -100.0
!
! ****** Graphics for current part ******
!
part attributes  &
   part_name = .pendulum.ground  &
   name_visibility = off
!
!----------------------------------- PART_2 -----------------------------------!
!
!
defaults coordinate_system  &
   default_coordinate_system = .pendulum.ground
!
part create rigid_body name_and_position  &
   part_name = .pendulum.PART_2  &
   adams_id = 2  &
   location = 0.0, 0.0, 0.0  &
   orientation = 0.0d, 0.0d, 0.0d
!
defaults coordinate_system  &
   default_coordinate_system = .pendulum.PART_2
!
! ****** Markers for current part ******
!
marker create  &
   marker_name = .pendulum.PART_2.MARKER_1  &
   adams_id = 1  &
   location = 0.0, 0.0, 0.0  &
   orientation = 90.0d, 90.0d, 270.0d
!
marker create  &
   marker_name = .pendulum.PART_2.MARKER_2  &
   adams_id = 2  &
   location = 0.0, 0.0, -100.0  &
   orientation = 90.0d, 90.0d, 270.0d
!
marker create  &
   marker_name = .pendulum.PART_2.cm  &
   adams_id = 10  &
   location = 0.0, 0.0, -50.0  &
   orientation = 0.0d, 0.0d, 0.0d
!
marker create  &
   marker_name = .pendulum.PART_2.MARKER_4  &
   adams_id = 4  &
   location = 0.0, 0.0, 0.0  &
   orientation = 90.0d, 90.0d, 0.0d
!
marker create  &
   marker_name = .pendulum.PART_2.MARKER_7  &
   adams_id = 7  &
   location = 0.0, 0.0, -100.0  &
   orientation = 0.0d, 0.0d, 0.0d
!
marker create  &
   marker_name = .pendulum.PART_2.MARKER_8  &
   adams_id = 8  &
   location = 0.0, 0.0, 0.0  &
   orientation = 90.0d, 90.0d, 0.0d
!
marker create  &
   marker_name = .pendulum.PART_2.MARKER_12  &
   adams_id = 12  &
   location = 0.0, 0.0, 0.0  &
   orientation = 0.0d, 0.0d, 0.0d
!
part create rigid_body mass_properties  &
   part_name = .pendulum.PART_2  &
   material_type = .pendulum.steel
!
! ****** Graphics for current part ******
!
geometry create shape link  &
   link_name = .pendulum.PART_2.LINK_3  &
   i_marker = .pendulum.PART_2.MARKER_1  &
   j_marker = .pendulum.PART_2.MARKER_2  &
   width = 10.0  &
   depth = 5.0
!
part attributes  &
   part_name = .pendulum.PART_2  &
   color = GREEN  &
   name_visibility = off
!
!----------------------------------- PART_3 -----------------------------------!
!
!
defaults coordinate_system  &
   default_coordinate_system = .pendulum.ground
!
part create rigid_body name_and_position  &
   part_name = .pendulum.PART_3  &
   adams_id = 3  &
   location = 0.0, 0.0, 0.0  &
   orientation = 0.0d, 0.0d, 0.0d
!
defaults coordinate_system  &
   default_coordinate_system = .pendulum.PART_3
!
! ****** Markers for current part ******
!
marker create  &
   marker_name = .pendulum.PART_3.MARKER_3  &
   adams_id = 3  &
   location = 0.0, 0.0, -100.0  &
   orientation = 0.0d, 0.0d, 0.0d
!
marker create  &
   marker_name = .pendulum.PART_3.cm  &
   adams_id = 11  &
   location = 0.0, 0.0, -100.0  &
   orientation = 270.0d, 90.0d, 90.0d
!
marker create  &
   marker_name = .pendulum.PART_3.MARKER_6  &
   adams_id = 6  &
   location = 0.0, 0.0, -100.0  &
   orientation = 0.0d, 0.0d, 0.0d
!
part create rigid_body mass_properties  &
   part_name = .pendulum.PART_3  &
   material_type = .pendulum.steel
!
! ****** Graphics for current part ******
!
geometry create shape ellipsoid  &
   ellipsoid_name = .pendulum.PART_3.ELLIPSOID_4  &
   adams_id = 2  &
   center_marker = .pendulum.PART_3.MARKER_3  &
   x_scale_factor = 40.0  &
   y_scale_factor = 40.0  &
   z_scale_factor = 40.0
!
part attributes  &
   part_name = .pendulum.PART_3  &
   color = MAIZE  &
   name_visibility = off
!
!----------------------------------- Joints -----------------------------------!
!
!
constraint create joint revolute  &
   joint_name = .pendulum.JOINT_1  &
   adams_id = 1  &
   i_marker_name = .pendulum.PART_2.MARKER_4  &
   j_marker_name = .pendulum.ground.MARKER_5
!
constraint attributes  &
   constraint_name = .pendulum.JOINT_1  &
   name_visibility = off
!
constraint create joint fixed  &
   joint_name = .pendulum.JOINT_2  &
   adams_id = 2  &
   i_marker_name = .pendulum.PART_3.MARKER_6  &
   j_marker_name = .pendulum.PART_2.MARKER_7
!
constraint attributes  &
   constraint_name = .pendulum.JOINT_2  &
   name_visibility = off
!
!----------------------------------- Forces -----------------------------------!
!
!
force create direct single_component_force  &
   single_component_force_name = .pendulum.SFORCE_1  &
   adams_id = 1  &
   type_of_freedom = rotational  &
   i_marker_name = .pendulum.PART_2.MARKER_8  &
   j_marker_name = .pendulum.ground.MARKER_9  &
   action_only = on  &
   function = ""
!
!----------------------------- Simulation Scripts -----------------------------!
!
!
simulation script create  &
   sim_script_name = .pendulum.Last_Sim  &
   commands =   &
              "simulation single_run transient type=auto_select initial_static=no end_time=5.0 number_of_steps=500 model_name=.pendulum"
!
!-------------------------- Adams View UDE Instances --------------------------!
!
!
defaults coordinate_system  &
   default_coordinate_system = .pendulum.ground
!
undo begin_block suppress = yes
!
ude create instance  &
   instance_name = .pendulum.pendulum  &
   definition_name = .controls.controls_plant  &
   location = 0.0, 0.0, 0.0  &
   orientation = 0.0, 0.0, 0.0
!
!-------------------------- Adams View UDE Instance ---------------------------!
!
!
variable modify  &
   variable_name = .pendulum.pendulum.input_channels  &
   object_value = .pendulum.TORQUE
!
variable modify  &
   variable_name = .pendulum.pendulum.output_channels  &
   object_value =   &
      .pendulum.ANGLE,  &
      .pendulum.ANG_VEL
!
variable modify  &
   variable_name = .pendulum.pendulum.file_name  &
   string_value = "pendulum"
!
variable modify  &
   variable_name = .pendulum.pendulum.event_name  &
   string_value = ""
!
variable modify  &
   variable_name = .pendulum.pendulum.solver_type  &
   string_value = "cplusplus"
!
variable modify  &
   variable_name = .pendulum.pendulum.target  &
   string_value = "FMUv2_0"
!
variable modify  &
   variable_name = .pendulum.pendulum.FMI_Master  &
   string_value = "none"
!
variable modify  &
   variable_name = .pendulum.pendulum.analysis_type  &
   string_value = "non_linear"
!
variable modify  &
   variable_name = .pendulum.pendulum.analysis_init  &
   string_value = "no"
!
variable modify  &
   variable_name = .pendulum.pendulum.analysis_init_str  &
   string_value = ""
!
variable modify  &
   variable_name = .pendulum.pendulum.user_lib  &
   string_value = ""
!
variable modify  &
   variable_name = .pendulum.pendulum.host  &
   string_value = "AsusTUF.fme.vutbr.cz"
!
variable modify  &
   variable_name = .pendulum.pendulum.dynamic_state  &
   string_value = "on"
!
variable modify  &
   variable_name = .pendulum.pendulum.tcp_ip  &
   string_value = "off"
!
variable modify  &
   variable_name = .pendulum.pendulum.output_rate  &
   integer_value = 1
!
variable modify  &
   variable_name = .pendulum.pendulum.realtime  &
   string_value = "on"
!
variable modify  &
   variable_name = .pendulum.pendulum.include_mnf  &
   string_value = "no"
!
variable modify  &
   variable_name = .pendulum.pendulum.hp_group  &
   object_value = (NONE)
!
variable modify  &
   variable_name = .pendulum.pendulum.pv_group  &
   object_value = (NONE)
!
variable modify  &
   variable_name = .pendulum.pendulum.gp_group  &
   object_value = (NONE)
!
variable modify  &
   variable_name = .pendulum.pendulum.pf_group  &
   object_value = (NONE)
!
variable modify  &
   variable_name = .pendulum.pendulum.ude_group  &
   object_value = (NONE)
!
variable modify  &
   variable_name = .pendulum.pendulum.expose_variant  &
   integer_value = 0
!
variable modify  &
   variable_name = .pendulum.pendulum.expose_event  &
   integer_value = 0
!
variable modify  &
   variable_name = .pendulum.pendulum.add_to_fmu  &
   string_value = ""
!
ude modify instance  &
   instance_name = .pendulum.pendulum
!
undo end_block
!
!------------------------------ Dynamic Graphics ------------------------------!
!
!
defaults coordinate_system  &
   default_coordinate_system = .pendulum.ground
!
geometry create shape force  &
   force_name = .pendulum.SFORCE_1_force_graphic_1  &
   adams_id = 1  &
   force_element_name = .pendulum.SFORCE_1  &
   applied_at_marker_name = .pendulum.PART_2.MARKER_8
!
!---------------------------------- Accgrav -----------------------------------!
!
!
force create body gravitational  &
   gravity_field_name = gravity  &
   x_component_gravity = 0.0  &
   y_component_gravity = 0.0  &
   z_component_gravity = -9806.65
!
!----------------------------- Analysis settings ------------------------------!
!
!
!---------------------------------- Measures ----------------------------------!
!
!
measure create function  &
   measure_name = .pendulum.FUNCTION_MEA_1  &
   function = ""  &
   units = "no_units"  &
   create_measure_display = no
!
data_element attributes  &
   data_element_name = .pendulum.FUNCTION_MEA_1  &
   color = WHITE
!
measure create function  &
   measure_name = .pendulum.FUNCTION_MEA_2  &
   function = ""  &
   units = "no_units"  &
   create_measure_display = no
!
data_element attributes  &
   data_element_name = .pendulum.FUNCTION_MEA_2  &
   color = WHITE
!
!---------------------------- Function definitions ----------------------------!
!
!
data_element modify variable  &
   variable_name = .pendulum.ANGLE  &
   function = ".pendulum.FUNCTION_MEA_1"
!
data_element modify variable  &
   variable_name = .pendulum.TORQUE  &
   function = "0"
!
data_element modify variable  &
   variable_name = .pendulum.ANG_VEL  &
   function = ".pendulum.FUNCTION_MEA_2"
!
measure modify function  &
   measure_name = .pendulum.FUNCTION_MEA_1  &
   function = "AX( .pendulum.PART_2.MARKER_12, .pendulum.ground.MARKER_13)"
!
measure modify function  &
   measure_name = .pendulum.FUNCTION_MEA_2  &
   function = "WX(.pendulum.PART_2.MARKER_12, .pendulum.ground.MARKER_13, .pendulum.ground.MARKER_13)"
!
force modify direct single_component_force  &
   single_component_force_name = .pendulum.SFORCE_1  &
   function = "VARVAL(.pendulum.TORQUE)"
!
!-------------------------- Adams View UDE Instance ---------------------------!
!
!
ude modify instance  &
   instance_name = .pendulum.pendulum
!
!--------------------------- Expression definitions ---------------------------!
!
!
defaults coordinate_system  &
   default_coordinate_system = ground
!
marker modify  &
   marker_name = .pendulum.ground.MARKER_5  &
   location =   &
      (LOC_RELATIVE_TO({0, 0, 0}, .pendulum.ground.POINT_1))
!
marker modify  &
   marker_name = .pendulum.ground.MARKER_9  &
   location =   &
      (LOC_RELATIVE_TO({0, 0, 0}, .pendulum.ground.POINT_1))
!
marker modify  &
   marker_name = .pendulum.ground.MARKER_13  &
   location =   &
      (LOC_RELATIVE_TO({0, 0, 0}, .pendulum.ground.POINT_1))
!
marker modify  &
   marker_name = .pendulum.PART_2.MARKER_1  &
   location =   &
      (LOC_RELATIVE_TO({0, 0, 0}, .pendulum.ground.POINT_1))  &
   orientation =   &
      (ORI_ALONG_AXIS(.pendulum.ground.POINT_1, .pendulum.ground.POINT_2, "X"))  &
   relative_to = .pendulum.PART_2
!
defaults coordinate_system  &
   default_coordinate_system = .pendulum.ground
!
marker modify  &
   marker_name = .pendulum.PART_2.MARKER_2  &
   location =   &
      (LOC_RELATIVE_TO({0, 0, 0}, .pendulum.ground.POINT_2))  &
   orientation =   &
      (ORI_ALONG_AXIS(.pendulum.ground.POINT_1, .pendulum.ground.POINT_2, "X"))  &
   relative_to = .pendulum.PART_2
!
defaults coordinate_system  &
   default_coordinate_system = .pendulum.ground
!
geometry modify shape link  &
   link_name = .pendulum.PART_2.LINK_3  &
   width = (10.0mm)  &
   depth = (5.0mm)
!
marker modify  &
   marker_name = .pendulum.PART_2.MARKER_4  &
   location =   &
      (LOC_RELATIVE_TO({0, 0, 0}, .pendulum.ground.POINT_1))  &
   relative_to = .pendulum.PART_2
!
defaults coordinate_system  &
   default_coordinate_system = .pendulum.ground
!
marker modify  &
   marker_name = .pendulum.PART_2.MARKER_7  &
   location =   &
      (LOC_RELATIVE_TO({0, 0, 0}, .pendulum.ground.POINT_2))  &
   relative_to = .pendulum.PART_2
!
defaults coordinate_system  &
   default_coordinate_system = .pendulum.ground
!
marker modify  &
   marker_name = .pendulum.PART_2.MARKER_8  &
   location =   &
      (LOC_RELATIVE_TO({0, 0, 0}, .pendulum.ground.POINT_1))  &
   relative_to = .pendulum.PART_2
!
defaults coordinate_system  &
   default_coordinate_system = .pendulum.ground
!
marker modify  &
   marker_name = .pendulum.PART_2.MARKER_12  &
   location =   &
      (LOC_RELATIVE_TO({0, 0, 0}, .pendulum.ground.POINT_1))  &
   relative_to = .pendulum.PART_2
!
defaults coordinate_system  &
   default_coordinate_system = .pendulum.ground
!
marker modify  &
   marker_name = .pendulum.PART_3.MARKER_3  &
   location =   &
      (LOC_RELATIVE_TO({0, 0, 0}, .pendulum.ground.POINT_2))  &
   relative_to = .pendulum.PART_3
!
defaults coordinate_system  &
   default_coordinate_system = .pendulum.ground
!
geometry modify shape ellipsoid  &
   ellipsoid_name = .pendulum.PART_3.ELLIPSOID_4  &
   x_scale_factor = (2 * 20mm)  &
   y_scale_factor = (2 * 20mm)  &
   z_scale_factor = (2 * 20mm)
!
marker modify  &
   marker_name = .pendulum.PART_3.MARKER_6  &
   location =   &
      (LOC_RELATIVE_TO({0, 0, 0}, .pendulum.ground.POINT_2))  &
   relative_to = .pendulum.PART_3
!
defaults coordinate_system  &
   default_coordinate_system = .pendulum.ground
!
material modify  &
   material_name = .pendulum.steel  &
   density = (7801.0(kg/meter**3))  &
   youngs_modulus = (2.07E+11(Newton/meter**2))
!
geometry modify shape force  &
   force_name = .pendulum.SFORCE_1_force_graphic_1  &
   applied_at_marker_name = (.pendulum.SFORCE_1.i)
!
model display  &
   model_name = pendulum
