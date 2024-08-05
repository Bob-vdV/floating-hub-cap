include <centercap_params.scad>

$fn = $preview ? 16 : 128;

if(swing_inner_diam  * 2 - arm_clearance <= bearing_outer_diam + 2 * bearing_wall_width){
    echo("Warning: Bearing might not fit!!");
}

swing_cutoff = 10; // TODO move
wall_width = 1; // TODO move


linear_extrude(arm_height){
    circle( d=arm_width);
    
    translate([-arm_width / 2, 0, 0])
    square([arm_width, swing_inner_diam]);
}

translate([0, 0, 0])
difference() {
    cylinder(h=swing_height, r= arm_length);
        
        
    translate([arm_length, swing_cutoff, 0])
    rotate([0, 0, 180])
    cube([2 * arm_length, 2 * arm_length, swing_height]);
        
    cylinder(h= swing_height, r = swing_inner_diam);
           
          
    // Cavity for sand
    translate([0, 0, wall_width])
    difference() {
        cylinder(h=swing_height - 2 * wall_width, r= arm_length - wall_width);
        
        cylinder(h= swing_height - 2 * wall_width, r = swing_inner_diam + wall_width);

        translate([arm_length, swing_cutoff + wall_width, 0])
        rotate([0, 0, 180])
        cube([2 * arm_length, 2 * arm_length, swing_height]);   
    }
    
    translate([18, swing_cutoff + wall_width, swing_height / 2]) // TODO not hardcode this
    rotate([90, 0, 0])
    cylinder(h=wall_width, d=5);
}
    
translate([0, 0, arm_height])
cylinder(bearing_start_z_offset, d=10.5);

translate([0, 0, bearing_z_start])
difference() {
    cylinder(shaft_height, d=bearing_inner_diam);

    translate([-notch_size/2, -(bearing_inner_diam / 2), shaft_height - notch_size])
    cube([notch_size, notch_length, notch_size], center=false);

}

