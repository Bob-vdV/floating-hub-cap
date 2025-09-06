include <centercap_params.scad>

$fn = $preview ? 16 : 128;

module centercap_base(){

// Base plate
linear_extrude(base_height){
    difference(){
        circle(d=outer_diam);
        circle(d=mid_diam + base_hole_clearance);
    }
}

// Bearing holder
translate([0, 0, base_height])
{
    // Bearing ring
    linear_extrude(bearing_height + bearing_lip_height){
        difference(){
            circle(d=bearing_outer_diam + 2 * bearing_wall_width);
            circle(d=bearing_outer_diam);
        }
    }
    
    // Bearing lip
    linear_extrude(bearing_lip_height){
        difference(){
            circle(d=bearing_outer_diam);
            circle(d=bearing_outer_diam - 2 * bearing_lip_width);
        }
    }
    
    // Inner ring
    linear_extrude(inner_ring_height){
        difference() {
            circle(d=inner_ring_diam);
            circle(d=inner_ring_diam - 2 * inner_ring_wall_width);

            // Clearances for clips
            for(i=[0:number_of_clips-1]){
                rotate([0, 0, i * (360 / number_of_clips)])
                translate([outer_diam / 2, 0])
                square([outer_diam, clip_length + 2 * clip_clearance], center=true);
            }
        }
    }

    // Clips
    clip_rot = clip_length / inner_ring_diam / PI * 360;
    for(i = [0: number_of_clips-1]) {
        rotate([0, 0, i * (360 / number_of_clips)]) {
            intersection() {
                rotate([0, 0, -clip_rot/2])
                rotate_extrude(angle=clip_rot) {
                    translate([inner_ring_diam / 2 - clip_width, 0, 0])

                        polygon([
                            [0, 0],
                            [0, clip_height],
                            [clip_width, clip_height],
                            [clip_width + clip_end_width, clip_height - clip_slant_height],
                            [clip_width, clip_straight_height],
                            [clip_width, 0],
                        ]);
                }
                translate([inner_ring_diam / 2 - clip_width, - clip_length / 2, 0])
                cube([clip_width + clip_end_width, clip_length, clip_height]);
            }
        }
    }
}
}
centercap_base();