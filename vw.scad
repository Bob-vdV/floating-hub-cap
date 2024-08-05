vw_svg_size = 1076.806;

module vw(size) {
    scaler = size / vw_svg_size;
    scale([scaler, scaler])
    import("vw-logo.svg", center=true);
}