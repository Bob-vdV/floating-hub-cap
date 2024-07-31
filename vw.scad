vw_svg_size = 1076.806;

module vw(size) {
    scaler = size / vw_svg_size;
    scale([scaler, scaler])
    import("volkswagen-vw-logo-1_bw.svg", center=true);
}