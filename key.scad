$fn = $preview ? 16 : 128;

include <centercap_params.scad>

module Key(){
    //rotate([0, 0, -90])
    intersection() {
        cylinder(h=key_size, d=shaft_upper_diam);
            
        rotate([0, 0, 180])
        translate([-shaft_upper_diam / 2, shaft_upper_diam/2 - key_width, 0])
        cube([shaft_upper_diam, shaft_upper_diam, key_size]);
    }
}
