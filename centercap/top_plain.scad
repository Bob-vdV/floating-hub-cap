include <key.scad>
include <ribbed_hole.scad>

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
        translate([0, 0, bottom_height - top_nut_lowerer]) {
            hull() {
                rotate([0, 0, 1/12*360])
                cylinder(m3_nut_height + top_nut_tol, d=m3_nut_diam + nut_tolerance, $fn=6);
                
                translate([0, mid_height/2 + nut_loose_width, 0])
                rotate([0, 0, 1/12*360])
                cylinder(m3_nut_height + top_nut_tol, d=m3_nut_diam + nut_tolerance, $fn=6);
            }
        }
        
        translate([0, 0, bottom_height + mid_height + top_height]) {
        rotate([180, 0, 180])
            minkowski() {
                Key();
                sphere(endcap_tolerance);
            }
            translate([0,0,-m3_hole_depth])
            RibbedHole(m3_hole_depth, m3_hole_diam, rib_depth_ratio=0);
        }
    }
}
