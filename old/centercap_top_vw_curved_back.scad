include <centercap_params.scad>
use <centercap_top_plain.scad>
use <fast_dome.scad>
use <vw.scad>
use <centercap_top_vw_curved_insert.scad>

$fn = $preview ? 16 : 128;

insert_tolerance = endcap_tolerance / 2;
insert_depth = 0.5;

difference(){
    union() {
        CenterCapTopPlain();

        intersection() {
            translate([0, 0, -logo_height])
            dome(d=outer_diam, h=dome_height, $fn = 4 * $fn);

            cylinder(h=dome_height, d=outer_diam);
        }
    }
    VWInsert(endcap_tolerance);  
    
    translate([0, 0, -insert_depth])
    VWInsert(endcap_tolerance);  
}