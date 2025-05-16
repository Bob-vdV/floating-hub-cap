include <centercap_params.scad>
use <key.scad>
use <ribbed_hole.scad>
$fn = $preview ? 16 : 128;

module CenterCapTopPlain() {
    rotate([180, 0, 0])
    difference(){
        union() {
            cylinder(h=bottom_height, d=endcap_outer_diam);
            
            translate([0, 0, bottom_height])
            cylinder(h=mid_height, d=mid_diam);

            translate([0, 0, bottom_height + mid_height])
            cylinder(h=top_height, d=top_diam);
        }
        
        translate([0, 0, bottom_height + mid_height + top_height]) {
        rotate([180, 0, 180])
            minkowski() {
                Key();
                sphere(endcap_tolerance);
            }
            translate([0,0,-m3_hole_depth])
            RibbedHole(m3_hole_depth, m3_hole_diam);
        }
    }
}

CenterCapTopPlain();