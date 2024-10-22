/*
Assembly of all printed components
Intended for visual inspection only
*/

include <centercap_params.scad>
use <centercap_base.scad>
use <centercap_swing_screws.scad>
use <centercap_top_vw_curved.scad>
use <centercap_top_plain.scad>

$fn = $preview ? 16 : 128;

module assembly() {
color("orange")
centercap_base();

swing_offset = base_height + bearing_height + arm_height + bearing_start_z_offset;
color("blue")
translate([0, 0, swing_offset])
rotate([0, 180, 0])
centercap_swing_screws();

color("silver")
translate([0, 0, -endcap_hole_height])
rotate([0, 180, 180])
centercap_top_vw_curved();
}

rotate([-90, 0, 0])
assembly();