$fn = $preview ? 16 : 128;

bearing_inner_diam = 7;

slot_width = 2;
slot_length = slot_width;
slot_height = 2;

shaft_inner_diam = bearing_inner_diam - 2 * slot_width;

h = 4 * slot_height; // +1 to hold onto something

tolerance = 0.6;

module ArcPart(inner_diam, outer_diam, height, arc_length, center_rot=true) {
    rot_angle = arc_length / (outer_diam * PI) * 360;

    rotate([0, 0, center_rot ? -rot_angle / 2 : 0])
    rotate_extrude(angle=rot_angle) {
        translate([ inner_diam / 2,0, 0])
        square([(outer_diam - inner_diam) / 2, height]);
    }   
}

module AngledArcPart(inner_diam, outer_diam, height, arc_length, center_rot=true) {
    rot_angle = arc_length / (outer_diam * PI) * 360;

    rotate([0, 0, center_rot ? -rot_angle / 2 : 0])
    rotate_extrude(angle=rot_angle) {
        translate([ inner_diam / 2,0, 0])
        polygon([[0,0], [0, height], [(outer_diam - inner_diam) / 2, height / 2]]);
    }   
}

translate([0, 0, 2])
{
translate([0, 0, -2])
cylinder(h=2, d=bearing_inner_diam);


// Shaft part
cylinder(h=h, d=shaft_inner_diam);
rot_angle = slot_width / 
    ((shaft_inner_diam + 2 *slot_width)* PI ) * 360;

for (i = [0:1]) {
    translate([0, 0, h - 2* slot_height])
    rotate([0, 0, i*180])
    AngledArcPart(
        inner_diam = shaft_inner_diam,
        outer_diam= shaft_inner_diam + 2 *slot_width, 
        height= slot_height, 
        arc_length = slot_length);
}
}

// Top part

translate([15, 0, 0]) {

top_inner_diam = shaft_inner_diam + 2 * tolerance;
top_slot_height = slot_height + tolerance;
top_h = 3 * top_slot_height;
top_insert_angle = 135;

difference() {
    cylinder(h=top_h, d= 10);

    cylinder(h=top_h, d = top_inner_diam);  
  
    for (i = [0:1]) {
         rotate([0, 0, i*180]) {
            translate([0, 0, top_h - 1.5 * top_slot_height])
            ArcPart(
                shaft_inner_diam, 
                top_inner_diam + 2* slot_width,
                top_slot_height * 1.5,
                slot_length + tolerance,
                false);  
                
            translate([0, 0, top_h - 2 * top_slot_height])
            //rotate([0, 0, top_insert_angle / 2])
            AngledArcPart(
                shaft_inner_diam, 
                top_inner_diam + 2* slot_width,
                top_slot_height,
                top_insert_angle / 360 * PI * (top_inner_diam + 2* slot_width),
                false); 
        }
    }
}




}

