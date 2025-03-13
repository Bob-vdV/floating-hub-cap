include <centercap_params.scad>
use <key.scad>
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
        
        translate([0, 0, bottom_height + mid_height + top_height])
        rotate([180, 0, 180]){
            minkowski() {
                Key();
                sphere(endcap_tolerance);
            }
            
            cylinder(h=m3_hole_depth, d=m3_hole_diam);
        }

        /*
        // Scaled PrintABlock connector
        translate([0, 0, bottom_height + mid_height + top_height])
        scale([blok_connector_scale, blok_connector_scale, blok_connector_scale])
        rotate([180, 0, 0])
        import("000a_ConnectorNeg_Flat.stl");
        */
    }
}

CenterCapTopPlain();