vw_svg_size = 564.480;

module vw(size) {
    scaler = size / vw_svg_size;
    scale([scaler, scaler])
    import("vw-logo.svg", center=true);
}