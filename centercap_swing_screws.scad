include <centercap_params.scad>
$fn = $preview ? 16 : 128;

module ArcPart(inner_diam, outer_diam, height, rot_angle, center_rot=true) {
    rotate([0, 0, center_rot ? -rot_angle / 2 : 0])
    rotate_extrude(angle=rot_angle) {
        translate([ inner_diam / 2,0, 0])
        square([(outer_diam - inner_diam) / 2, height]);
    }   
}

nuts_per_side = 2; // TODO move to params
num_nuts = nuts_per_side * 2 + 1;

echo("Swing inner diam:", swing_inner_diam);
echo("try",  bearing_outer_diam + 2 * bearing_wall_width - 2 * arm_clearance);


if(swing_inner_diam  * 2 - 2 * arm_clearance <= bearing_outer_diam + 2 * bearing_wall_width){
    echo("Warning: Bearing might not fit!!");
}

linear_extrude(arm_height){
    circle(d=arm_width);
    
    intersection() {
        translate([-arm_width / 2, 0, 0])
        square([arm_width, swing_inner_diam]);
    
        circle(r=swing_inner_diam);
    }
}

difference() {
    total_angle = (num_nuts * nut_loose_width + (num_nuts + 1) * nut_clearance) /
    ((swing_inner_diam + nut_clearance + nut_loose_width / 2) * 2 * PI) * 360;
       
    rotate([0, 0, 90])
    ArcPart(swing_inner_diam * 2, 2 * arm_length, swing_height, total_angle);
    
    /*
    cylinder(h=swing_height, r= arm_length);
    
    translate([arm_length, 6, 0])
    rotate([0, 0, 180])
    cube([2 * arm_length, 2 * arm_length, swing_height]);
        
    cylinder(h= swing_height, r = swing_inner_diam);*/
            
    // Screw holes ;)
    angle = (nut_loose_width + nut_clearance) /
    ((swing_inner_diam + nut_clearance + nut_loose_width / 2) * 2 * PI) * 360;
    echo("Angle: ", angle);
    for(i=[-nuts_per_side: nuts_per_side]){
        rotate([0, 0, i * angle]) 
        translate([0, arm_length - nut_loose_width / 2 - nut_clearance, 0])
        {
        /*
            translate([0, 0, swing_height - screw_head_height]) //bearing_z_mid - screw_head_height / 2])
            cylinder(h=screw_head_height, d=nut_loose_width); // Screw head
            */
            cylinder(h=swing_height, d=nut_hole_size);
            
            cylinder(h=nut_height, d=nut_loose_width, $fn = 6); //Bottom nut
        }
    }
}

// Shaft
translate([0, 0, arm_height])
cylinder(bearing_start_z_offset, d=10.5);

translate([0, 0, bearing_z_start])
difference() {
    cylinder(shaft_height, d=bearing_inner_diam - bearing_tolerance);

    translate([0, 0, shaft_height - endcap_hole_height])
    union() {
        for(i=[0:1]){
        rotate([0, 0, i * 180])
        cube(bearing_inner_diam / 2);
        }
    }
}

