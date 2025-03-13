$fn = $preview ? 16 : 128;

tiny = 1e-3;
large = 1e3;

/* [Bearing dimensions] */
b_outer_diam = 22;
b_inner_diam = 8;
b_height = 8;

wall_width = 1.6;

wall_diam = b_outer_diam + 2*wall_width;

gap_size = 1;
mount_width = 15;
mount_length = 12.5;

screw_diam = 4;
screw_head_diam = 7.4;

bit_diam = 7;
bit_neck_z_offset = 7.5;
bit_neck_height = 6;
bit_neck_diam = 4.5;
bit_end_length = 10;


conversion_height = (b_outer_diam + 2*wall_width - bit_diam) / 2; // 45 degree angle

// ------ CODE ------



difference() {
    hull() {
        cylinder(b_height, d=b_outer_diam + 2*wall_width);

        /*
        translate([-mount_width/2, b_outer_diam / 2, 0])
        cube([mount_width, mount_length, b_height]);
        */
    }
    
    
    
    cylinder(b_height, d=b_outer_diam);
    
    
    cube([gap_size, wall_diam, b_height]);
    /*
    
    // Screw hole
    translate([0, (b_outer_diam + mount_length) / 2, b_height/2])
    rotate([0, 90, 0]) {
        cylinder(h=wall_diam, d=screw_diam, center=true);
        
        
        // head
        //mirror([0, 0, 1])
        translate([0, 0, mount_length/2])
        cylinder(h=large, d=screw_head_diam);
        
        
        // nut
        mirror([0, 0, 1])
        translate([0, 0, mount_length/2])
        rotate([0, 0, 360/12])
        cylinder(h=large, d=screw_head_diam, $fn=6);
        
        
    }
    */
    
}






// Conversion
translate([0, 0, b_height]) {
    intersection() {
        difference() {
            hull() {
                cylinder(h=tiny, d=wall_diam);
                
                translate([0, 0, conversion_height])
                cylinder(h=tiny, d=bit_diam, $fn=6);
            }
            cylinder(h=conversion_height, d1=b_outer_diam, d2=0);
        }
        
        rotate([0, 0, 45])
        union() {
            cube([wall_diam, bit_diam, 2*conversion_height], center=true);
        
            rotate([0, 0, 90])
            cube([wall_diam, bit_diam, 2*conversion_height], center=true);
        }
    }

}



// Chuck holder
translate([0, 0, b_height + conversion_height]) {// guessed
    cylinder(h=bit_end_length, d=bit_diam, $fn=6);

    // neck
    translate([0, 0, bit_end_length])
    cylinder(h=bit_neck_height/2, d1 = bit_diam, d2=bit_neck_diam, $fn=6);
    translate([0, 0, bit_end_length + bit_neck_height/2])
    cylinder(h=bit_neck_height/2, d1 = bit_neck_diam, d2=bit_diam, $fn=6);

    
    translate([0, 0, bit_end_length + bit_neck_height])
    cylinder(h=bit_neck_z_offset, d=bit_diam, $fn=6);
    
}
