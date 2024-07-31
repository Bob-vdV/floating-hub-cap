include <centercap_params.scad>
use <centercap_top_plain.scad>
use <fast_dome.scad>
use <vw.scad>

$fn = $preview ? 16 : 128;

module VWInsert(tolerance=0) {
    difference(){
        union() {
            intersection()
            {
                dome(d=outer_diam, h=dome_height);

                linear_extrude(dome_height)
                if(tolerance == 0) {
                    vw(outer_diam);
                } else {
                    minkowski() {    
                        vw(outer_diam);
                        circle(d=tolerance);
                    }
                }
            }
            translate([0, 0, -logo_height])
            cylinder(h=logo_height, d=outer_diam);
        }
        
        translate([0, 0, -logo_height])
        dome(d=outer_diam, h=dome_height);
        
        translate([0, 0, -2*logo_height])
        cylinder(h=logo_height, d=outer_diam);
    }
}

VWInsert();
