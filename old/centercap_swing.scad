include <centercap_params.scad>

$fn = $preview ? 16 : 128;

inner_ring_wall_width = 2;

arm_width = 13.5;
arm_clearance = 2;
arm_length = inner_ring_diam / 2 - inner_ring_wall_width - arm_clearance;
arm_height = 2;
echo(arm_length);

bearing_outer_diam = 22;
bearing_inner_diam = 8;
bearing_height = 7;

bearing_start_z_offset = 1.6;
bearing_z_start = arm_height + bearing_start_z_offset;
bearing_z_mid = bearing_z_start + bearing_height / 2;

nut_width = 8.08; // Measured corner to corner
nut_height = 3.2;
nut_hole_size = 3;//3.25;
nut_tolerance = 0.2;
nut_loose_width = nut_width + nut_tolerance;
nut_clearance = 1;

swing_height = bearing_z_mid + nut_height / 2;

shaft_height = 12.25;
notch_size = 2;
notch_length = 3;

swing_inner_diam = arm_length - nut_loose_width - 2 * nut_clearance; // TODO change name or *2
echo("Swing inner diam:", swing_inner_diam);

if(swing_inner_diam  * 2 <= bearing_outer_diam){
    echo("Warning: Bearing might not fit!!");
}

linear_extrude(arm_height){
    circle( d=arm_width);
    
    translate([-arm_width / 2, 0, 0])
    square([arm_width, swing_inner_diam]);
}

translate([0, 0, 0])
difference() {
    cylinder(h=swing_height, r= arm_length);
        
    translate([arm_length, 10, 0])
    rotate([0, 0, 180])
    cube([2 * arm_length, 2 * arm_length, swing_height]);
        
    cylinder(h= swing_height, r = swing_inner_diam);
            
    // Nut holes ;)
    num_nuts = 1;
    angle = (nut_loose_width + nut_clearance) /
    ((swing_inner_diam + nut_clearance + nut_loose_width / 2) * 2 * PI) * 360; // TODO check
    echo("Angle: ", angle);
    for(i=[-num_nuts: num_nuts]){
        rotate([0, 0, i * angle]) 
        translate([0, arm_length - nut_loose_width / 2 - nut_clearance, bearing_z_mid - nut_height / 2])
        cylinder(h=nut_height, d=nut_loose_width, $fn=6); 

    }
}

x = 1.6;
    
translate([0, 0, arm_height])
cylinder(bearing_start_z_offset, d=10.5);

translate([0, 0, bearing_z_start])
difference() {
    cylinder(shaft_height, d=bearing_inner_diam);

    translate([-notch_size/2, -(bearing_inner_diam / 2), shaft_height - notch_size])
    cube([notch_size, notch_length, notch_size], center=false);

}

