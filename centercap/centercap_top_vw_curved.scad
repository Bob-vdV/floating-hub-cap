use <centercap_top_plain.scad>
use <fast_dome.scad>
use <vw.scad>

module centercap_top_vw_curved() {
    CenterCapTopPlain();

    intersection() {
        translate([0, 0, -logo_height])
        dome(d=endcap_outer_diam, h=dome_height);

        cylinder(h=dome_height, d=endcap_outer_diam);
    }

    intersection() {
        dome(d=endcap_outer_diam, h=dome_height);

        linear_extrude(dome_height)
        vw(endcap_outer_diam); 
    }
}
