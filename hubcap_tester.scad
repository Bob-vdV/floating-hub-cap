include <centercap_params.scad>

$fn = $preview ? 16 : 128;

h = 20;
holder_inner_diam = inner_ring_diam + endcap_tolerance + 1 * inner_ring_wall_width;

holder_diam = holder_inner_diam + 2 * 2;

difference() {
    cylinder(h, d=holder_diam);
    
    cylinder(h, d=holder_inner_diam);
}

difference() {
    cylinder(h=clip_straight_height - endcap_tolerance, d=holder_inner_diam);

    cylinder(h=clip_straight_height - endcap_tolerance, d=holder_inner_diam - 2);
}

bit_diam = 7;
bit_height = 15;
translate([0, 0, h]) {
    /*
    intersection() {
        cylinder(h= (holder_diam - bit_diam) / 2 * tan(45) , d1=holder_diam, d2=bit_diam);

    }*/
    
    intersection() {
        cylinder(h=2, d=holder_diam);
        
        
        union() {
            w = 10;
            
            translate([0, 0, 2 /2]) {
                cube([w, holder_diam, 2], center=true);
                cube([holder_diam, w, 2], center=true);
            }
            cylinder(h=2, d= 2 * w);
        }
    }
    cylinder(h=bit_height, d=bit_diam, $fn=6);
}
