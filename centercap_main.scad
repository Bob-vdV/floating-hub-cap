include <centercap_assembly.scad>
include <centercap_base.scad>
include <centercap_swing_screws.scad>
include <centercap_top_plain.scad>
include <centercap_top_vw_curved.scad>
include <centercap_top_vw_flat.scad>

$fn = $preview ? 16 : 128;

/* [Main parameters] */
selected_part = "base"; // ["assembly", "base", "swing", "top-plain", "top-vw-curved", "top-vw-flat"]
outer_diam = 65;
inner_ring_diam = 56;
clip_straight_height = 4.5; // Height of the inner ring

/* [General parameters] */
tiny = 0.01;
layer_height = 0.2;

/* [Bearing parameters] */
bearing_outer_diam = 22;
bearing_inner_diam = 8;
bearing_height = 7;
bearing_tolerance= 0.0;

bearing_ring_diam = 12.0 - 0.5;

/* [Base parameters] */
base_height = 2;

bearing_wall_width = 1.6;
base_hole_clearance = 0.8;
bearing_lip_width = 0.75;
bearing_lip_height = 0.5;

inner_ring_height = 10;
inner_ring_wall_width = 2;

number_of_clips = 6;
clip_clearance = 2;
clip_length = 8;
clip_width = 1.8;
clip_slant_height = 5;
clip_end_width = 1.6;
clip_height = clip_straight_height + clip_end_width + clip_slant_height;

/* [Top parameters] */
endcap_tolerance = 0.2;
endcap_outer_tolerance = 0.4;
endcap_height = 1;
endcap_base_clearance = 2.0;

bottom_height = 2;

mid_diam = bearing_ring_diam;
mid_height = endcap_base_clearance + base_height + bearing_lip_height;

top_diam = bearing_inner_diam;
top_height = 5.0;

endcap_hole_height = bottom_height + mid_height + top_height - endcap_height;
endcap_outer_diam = outer_diam - endcap_outer_tolerance;

top_nut_tol = 0.8;
top_nut_lowerer = 0.2;

/* [Swing parameters] */
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

shaft_height = bearing_height - top_height;
shaft_upper_diam = bearing_inner_diam - bearing_tolerance;

swing_inner_radius = arm_length - nut_loose_width - 2 * nut_clearance;

/* [Key parameters] */
key_size = 3.0;
m3_hole_diam = 3.5;//3.0
m3_head_diam = 6.35;
m3_loose_diam = m3_head_diam + nut_tolerance;
m3_head_height = 2.0;
m3_loose_hole_diam = m3_hole_diam;// + 0.5;
m3_hole_depth = 7.5;
m3_roof_thickness = 4.0; //2.5
m3_nut_diam = m3_loose_diam;
m3_nut_height = 2.15;
key_width = 2.1;

echo("Max screw length:", m3_roof_thickness + bearing_height + mid_height);

/* [Curved VW parameters] */
logo_height = 1;
dome_height = 4;

// ------ CODE ------
if (selected_part == "assembly") {
  assemblyCut();
} else if (selected_part == "base") {
  centercap_base();
} else if (selected_part == "swing") {
  centercap_swing_screws();
} else if (selected_part == "top-plain") {
  CenterCapTopPlain();
} else if (selected_part == "top-vw-curved") {
  centercap_top_vw_curved();
} else if (selected_part == "top-vw-flat") {
  centercap_top_vw_flat();
} else {
  echo("Unknown part selected");
}
