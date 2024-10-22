include <centercap_params.scad>
use <centercap_top_plain.scad>
use <fast_dome.scad>
use <vw.scad>

$fn = $preview ? 16 : 128;


module centercap_top_vw_curved() {
CenterCapTopPlain();

intersection() {
    translate([0, 0, -logo_height])
    dome(d=outer_diam, h=dome_height);

    cylinder(h=dome_height, d=outer_diam);
}

intersection()
{
    dome(d=outer_diam, h=dome_height);

    linear_extrude(dome_height)
    vw(outer_diam + 0.05); // slightly larger to fix outer edges
}
}
centercap_top_vw_curved();