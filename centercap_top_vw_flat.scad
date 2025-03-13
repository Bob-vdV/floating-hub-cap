include <centercap_params.scad>
use <centercap_top_plain.scad>
use <vw.scad>

$fn = $preview ? 16 : 128;

module centercap_top_vw_flat() {
    CenterCapTopPlain();

    linear_extrude(logo_height) {
        intersection() {
            circle(d=endcap_outer_diam);
                
            vw(endcap_outer_diam);
        }
    }
}

centercap_top_vw_flat();
