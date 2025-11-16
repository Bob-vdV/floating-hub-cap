$fn = $preview ? 16 : 128;

module Key(){
    //rotate([0, 0, -90])
    intersection() {
        cylinder(h=key_size, d=shaft_upper_diam);
            
        rotate([0, 0, 180])
        translate([-shaft_upper_diam / 2, shaft_upper_diam/2 - key_width, 0])
        cube([shaft_upper_diam, shaft_upper_diam, key_size]);

        /*
        rotate([90, 0, 0])
        cylinder(
            h=shaft_upper_diam, 
            d=2 * sqrt(shaft_upper_diam - key_size*key_size) / sqrt(2), 
            center=true, 
            $fn=4
        );
        */
    }
}
