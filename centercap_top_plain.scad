include <centercap_params.scad>
$fn = $preview ? 16 : 128;

module CenterCapTopPlain() {
    // Add clearances to everything
    ec_bearing_diam = bearing_inner_diam; //+ endcap_tolerance;
    ec_notch_size = notch_size - endcap_tolerance;
    ec_notch_length = notch_length - endcap_tolerance;

    rotate([180, 0, 0])
    difference(){
        union() {
            cylinder(h=bottom_height, d=endcap_outer_diam);
            
            translate([0, 0, bottom_height])
            cylinder(h=mid_height, d=mid_diam);

            translate([0, 0, bottom_height + mid_height])
            cylinder(h=top_height, d=top_diam);
        }
        
        // Scaled PrintABlock connector
        translate([0, 0, bottom_height + mid_height + top_height])
        scale([blok_connector_scale, blok_connector_scale, blok_connector_scale])
        rotate([180, 0, 0])
        import("000a_ConnectorNeg_Flat.stl");
    }
}

CenterCapTopPlain();