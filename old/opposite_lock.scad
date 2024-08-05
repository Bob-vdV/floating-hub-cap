$fn = $preview ? 16 : 128;

bearing_inner_diam = 7;

slot_width = 2;
slot_length = slot_width;
slot_height = 2;

shaft_inner_diam = bearing_inner_diam - 2 * slot_width;

h = 3;

tolerance = 0.4;

// Shaft

cylinder(h, d=bearing_inner_diam);

translate([0, 0, h])
intersection() {
    cylinder(h, d=bearing_inner_diam);

    union() {
        for(i=[0:1]){
        rotate([0, 0, i * 180])
        cube(bearing_inner_diam / 2);
        }
    }

}

top_diam = bearing_inner_diam + tolerance;

translate([15, 0, 0]) {
cylinder(h, d=top_diam);

translate([0, 0, h])
intersection() {
    cylinder(h, d=top_diam);

    union() {
        for(i=[0:1]){
        rotate([0, 0, 90 + i * 180])
        translate([tolerance / 2, tolerance / 2, 0])
        cube(top_diam / 2);
        }
    }
}
}
