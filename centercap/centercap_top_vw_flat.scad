use <centercap_top_plain.scad>
use <vw.scad>

module centercap_top_vw_flat() {
    CenterCapTopPlain();

    linear_extrude(logo_height) {
        intersection() {
            circle(d=endcap_outer_diam);
                
            vw(endcap_outer_diam);
        }
    }
}
