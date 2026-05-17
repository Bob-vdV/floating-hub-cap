include <top_plain.scad>
include <fast_dome.scad>

module CenterCapTopCurved() {
  CenterCapTopPlain();

  dome(d=endcap_outer_diam, h=dome_height);
}
