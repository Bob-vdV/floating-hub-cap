include <centercap_params.scad>
$fn = $preview ? 16 : 128;

module ArcPart(inner_diam, outer_diam, height, rot_angle, center_rot=true) {
    rotate([0, 0, center_rot ? -rot_angle / 2 : 0])
    rotate_extrude(angle=rot_angle) {
        translate([ inner_diam / 2,0, 0])
        square([(outer_diam - inner_diam) / 2, height]);
    }   
}

if(swing_inner_radius  * 2 - 2 * arm_clearance <= bearing_outer_diam + 2 * bearing_wall_width){
    echo("Warning: Bearing and swing might collide!");
}

module centercap_swing_screws() {
    num_nuts = nuts_per_side * 2 + 1;

    linear_extrude(arm_height){
        circle(d=arm_width);
        
        intersection() {
            translate([-arm_width / 2, 0, 0])
            square([arm_width, swing_inner_radius]);
        
            circle(r=swing_inner_radius + tiny);
        }
    }
    difference() {
        total_angle = (num_nuts * nut_loose_width + (num_nuts + 1) * nut_clearance) /
        ((swing_inner_radius + nut_clearance + nut_loose_width / 2) * 2 * PI) * 360;
           
        rotate([0, 0, 90])
        ArcPart(swing_inner_radius * 2, 2 * arm_length, swing_height, total_angle);
                
        // Screw holes ;)
        angle = (nut_loose_width + nut_clearance) /
        ((swing_inner_radius + nut_clearance + nut_loose_width / 2) * 2 * PI) * 360;
        for(i=[-nuts_per_side: nuts_per_side]){
            rotate([0, 0, i * angle]) 
            translate([0, arm_length - nut_loose_width / 2 - nut_clearance, 0])
            {
                cylinder(h=swing_height, d=nut_hole_size);
                
                cylinder(h=nut_height, d=nut_loose_width, $fn = 6); // Bottom nut
                
                // Small cutout on top for better printability
                translate([0, 0, nut_height + layer_height/2])
                cube([
                    nut_loose_width / 2, 
                    sqrt(3) / 2 * nut_loose_width, 
                    layer_height
                    ], 
                    center=true
                );
            }
        }
    }

    // Shaft
    translate([0, 0, arm_height])
    cylinder(bearing_start_z_offset, d=10.5);

    translate([0, 0, bearing_z_start])
    difference() {
        union() {
            cylinder(bearing_height, d=bearing_inner_diam - bearing_tolerance);
            translate([0, 0, bearing_height])
            cylinder(shaft_height - bearing_height, d=bearing_inner_diam - bearing_tolerance - endcap_tolerance);
        }
        
        translate([0, 0, shaft_height])
        scale([blok_connector_scale, blok_connector_scale, blok_connector_scale])
        rotate([180, 0, 0])
        import("000a_ConnectorNeg_Flat.stl");
    }
}

centercap_swing_screws();
