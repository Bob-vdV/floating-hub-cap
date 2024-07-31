include <centercap_params.scad>
$fn = $preview ? 16 : 128;

module CenterCapTopPlain() {
    // Add clearances to everything
    ec_bearing_diam = bearing_inner_diam + endcap_tolerance;
    ec_notch_size = notch_size - endcap_tolerance;
    ec_notch_length = notch_length - endcap_tolerance;

    rotate([180, 0, 0])
    difference(){
        union() {
            cylinder(h=bottom_height, d=outer_diam);
            
            translate([0, 0, top_height])
            cylinder(h=mid_height, d=mid_diam);

            translate([0, 0, top_height + mid_height])
            cylinder(h=top_height, d=top_diam);
        }
        
        translate([0, 0, endcap_height])
        difference() {
            cylinder(
            h=endcap_hole_height, 
            d=ec_bearing_diam);
            
            //translate([-ec_notch_size/2, -ec_bearing_diam / 2, 0])
            //cube([ec_notch_size, ec_notch_length, ec_notch_size], center=false);
            union() {
                for(i=[0:1]){
                rotate([0, 0, 90 + i * 180])
                translate([endcap_tolerance / 2, endcap_tolerance / 2, 0])
                cube(ec_bearing_diam / 2);
            }
    }
        }
    }
}

CenterCapTopPlain();