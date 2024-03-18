// CDE23N-60-B50K linear potentiometer (horizontal, on side, knob to the right)
lin_pot_travel = 60;
lin_pot_size = [11, lin_pot_travel+28.3, 13];
lin_pot_mount_screw_d = 3;
lin_pot_mount_screw_dist_from_edge = ( lin_pot_size.y - lin_pot_travel - 20 ) / 2;
lin_pot_mount_screw_pos = [4, lin_pot_size.y-4];
lin_pot_knob_size = [15.3, 5, 1.2];
lin_pot_knob_dist_from_edge = ( lin_pot_size.y - lin_pot_travel ) / 2;
lin_pot_knob_pos_range = [lin_pot_knob_dist_from_edge, lin_pot_size.y - lin_pot_knob_dist_from_edge];

// MT83 engine: 12V, on side
engine_size_d = 32;
engine_size_len = 19.7;
engine_size_shaft_d = 2;
engine_size_shaft_h = 8;
engine_size_shaft_hold_h = 3.5;

// screw row
screw_rod_d = 3;

// engine-to-shaft coupler
coupler_d = 6;
coupler_shaft_in = 5;
coupler_engine_in = 5;
coupler_spacing = 2;
coupler_len = coupler_shaft_in + coupler_spacing + coupler_engine_in;

// servo body
servo_body_bottom_h = 2;
servo_body_wall = 2;
servo_body_mount_screw_d = 3;
servo_body_threaded_insert_slot_d = 5;
servo_body_threaded_insert_slot_h = 6;
servo_body_extra_space_len = 3;

// bearing size [mm]
bearing_size = [3, 7, 3]; // internal_d, external_d, h

// carriage
carriage_magnet_d = 5;
carriage_magnet_h = 5;
carriage_wall = 2;
carriage_rod_h = engine_size_d/2 - lin_pot_size.z/2;
carriage_size = [ 10,
                  lin_pot_knob_size.y + 2*carriage_wall,
                  carriage_rod_h + screw_rod_d/2 + carriage_wall + carriage_magnet_h ];
carriage_threaded_insert_slot_d = 5;
carriage_threaded_insert_slot_h = 6;
