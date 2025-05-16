// General parameters
tiny = 0.01;
layer_height = 0.2;

// Bearing parameters
bearing_outer_diam = 22;
bearing_inner_diam = 8;
bearing_height = 7;
bearing_tolerance= 0.0;

// Base parameters
base_height = 2;
outer_diam = 65;

bearing_wall_width = 1.6;

inner_ring_height = 10;
inner_ring_diam = 56;
inner_ring_wall_width = 2;

number_of_clips = 6;
clip_clearance = 2;
clip_length = 8;
clip_height = 12;
clip_width = 1.8;
clip_straight_height = 4.5;
clip_slant_height = 5;
clip_end_width = 1;

// Top parameters
endcap_tolerance = 0.2;
endcap_outer_tolerance = 0.4;
endcap_height = 1;

bottom_height = 2;

mid_diam = 18;
mid_height = 1.5;

top_diam = 10.5;
top_height = 1.1;

endcap_hole_height = bottom_height + mid_height + top_height - endcap_height;
endcap_outer_diam = outer_diam - endcap_outer_tolerance;

// Swing parameters
arm_width = 13.5;
arm_clearance = 3.5;
arm_length = inner_ring_diam / 2 - inner_ring_wall_width - arm_clearance;
arm_height = 3;

bearing_start_z_offset = 1.6;
bearing_z_start = arm_height + bearing_start_z_offset;
bearing_z_mid = bearing_z_start + bearing_height / 2;

nuts_per_side = 2;
nut_width = 8.08; // Measured corner to corner
nut_height = 3.2;
nut_hole_size = 4.2;
nut_tolerance = 0.2;
nut_loose_width = nut_width + nut_tolerance;
nut_clearance = 0.2; // Wall thickness
screw_head_height = 2 * 3.2;

swing_clearance = 1;
swing_height = bearing_height + arm_height + bearing_start_z_offset - swing_clearance - screw_head_height;

shaft_height = 8.25;
shaft_upper_diam = bearing_inner_diam - bearing_tolerance - endcap_tolerance;
notch_size = 2;
notch_length = 3;

swing_inner_radius = arm_length - nut_loose_width - 2 * nut_clearance;

// Key parameters
key_size = 2;
m3_hole_diam = 3.0;
m3_head_diam = 5.5;
m3_loose_hole_diam = 3.5;
m3_hole_depth = 4;
m3_head_height = 2.1;
m3_roof_thickness = 3;
key_width = 1;

// Curved VW parameters
logo_height = 1;
dome_height = 4;