module Ribs(thread_diam, rib_depth, rib_diam, num_ribs){
    difference() {
        circle(d=thread_diam);

        for(i = [0 : num_ribs-1]) {
            rotate([0, 0, i*360/num_ribs])
            translate([
                thread_diam / 2 + rib_diam / 2 - rib_depth, 
                0, 
                0
            ])
            circle(d=rib_diam);
        }   
    }
}

module RibbedHole(
        height, 
        thread_diam, 
        rib_depth_ratio=0.1, 
        rib_diam_ratio=2/3, 
        num_ribs=3, 
        slanted_height_ratio=0.2
    ) {
    rib_depth = thread_diam * rib_depth_ratio;
    rib_diam = thread_diam * rib_diam_ratio;
    
    h2 = height * slanted_height_ratio;
    h1 = height - h2;
    linear_extrude(h1) {
        Ribs(thread_diam, rib_depth, rib_diam, num_ribs);
    }

    translate([0, 0, h1])

    intersection() {
        linear_extrude(h2, scale=thread_diam/(thread_diam-2*rib_depth)) {
            Ribs(thread_diam, rib_depth, rib_diam, num_ribs);
        }
        cylinder(h2, d=thread_diam);
    }
}
