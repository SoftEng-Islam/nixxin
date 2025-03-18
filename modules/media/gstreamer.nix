{ settings, config, lib, pkgs, ... }:
let inherit (lib) makeSearchPathOutput;
in {

  environment.variables = {
    # Fix for missing audio/video information in properties https://github.com/NixOS/nixpkgs/issues/53631
    GST_PLUGIN_SYSTEM_PATH_1_0 = makeSearchPathOutput "lib" "lib/gstreamer-1.0"
      (with pkgs.gst_all_1; [
        gst-plugins-good
        gst-plugins-bad
        gst-plugins-ugly
        gst-libav
      ]); # Fix from https://github.com/NixOS/nixpkgs/issues/195936#issuecomment-1366902737

    # Define paths for GStreamer plugins and GObject Introspection files, ensuring compatibility with various multimedia libraries.
    GST_PLUGIN_PATH =
      "${pkgs.gst_all_1.gst-plugins-base}/lib/gstreamer-1.0:${pkgs.gst_all_1.gst-plugins-good}/lib/gstreamer-1.0:${pkgs.gst_all_1.gst-plugins-bad}/lib/gstreamer-1.0:${pkgs.gst_all_1.gst-plugins-ugly}/lib/gstreamer-1.0:${pkgs.gst_all_1.gst-libav}/lib/gstreamer-1.0";

    GI_TYPELIB_PATH = "${pkgs.glib}/lib/girepository-1.0:"
      + "${pkgs.gobject-introspection}/lib/girepository-1.0:"
      + "${pkgs.networkmanager}/lib/girepository-1.0:"
      + "${pkgs.gobject-introspection-unwrapped}/lib/girepository-1.0:"
      + "${pkgs.gst_all_1.gstreamer}/lib/girepository-1.0:"
      + "${pkgs.gst_all_1.gst-plugins-base}/lib/girepository-1.0:"
      + "${pkgs.gst_all_1.gst-plugins-ugly}/lib/girepository-1.0:"
      + "$GI_TYPELIB_PATH";
  };

  environment.systemPackages = with pkgs; [
    gst123
    gst_all_1.gst-editing-services
    gst_all_1.gst-libav
    gst_all_1.gst-plugins-bad
    gst_all_1.gst-plugins-base
    gst_all_1.gst-plugins-good
    gst_all_1.gst-plugins-rs
    gst_all_1.gst-plugins-ugly
    gst_all_1.gst-plugins-viperfx
    gst_all_1.gst-vaapi
    gst_all_1.gstreamer
  ];

}
