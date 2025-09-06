/*
Assembly of all printed components
Intended for visual inspection only
*/

module assembly() {
  color("orange")
  centercap_base();

  swing_offset = base_height + bearing_height + arm_height + bearing_start_z_offset + bearing_lip_height;
  color("blue")
  translate([0, 0, swing_offset])
  rotate([0, 180, 0])
  centercap_swing_screws();
    
  top_offset = -(endcap_base_clearance + bottom_height);
  swing_height = arm_height + bearing_start_z_offset + shaft_height;
  color("silver")
  translate([0, 0, top_offset])
  rotate([0, 180, 180])
  centercap_top_vw_flat();
}

module assemblyCut() {
  rotate([-90, 0, 0])
  intersection() {
    assembly();
    big = 1e3;
    color("red")
    translate([0, -big/2, -big/2])
    cube(big);
  }
}
