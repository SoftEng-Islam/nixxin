{ settings, config, lib, pkgs, ... }:
let inherit (lib) makeSearchPathOutput;
in {

  environment.variables = {
    # Allow apps to detect gstreamer plugins
    GST_PLUGIN_PATH_1_0 = [ "/run/current-system/sw/lib/gstreamer-1.0" ];

    # Fix for missing audio/video information in properties https://github.com/NixOS/nixpkgs/issues/53631
    GST_PLUGIN_SYSTEM_PATH_1_0 =
      lib.makeSearchPathOutput "lib" "lib/gstreamer-1.0" (with pkgs.gst_all_1; [
        gst-plugins-base
        gst-plugins-good
        gst-plugins-bad
        gst-plugins-ugly
        gst-libav
      ]); # Fix from https://github.com/NixOS/nixpkgs/issues/195936#issuecomment-1366902737

    # Define paths for GStreamer plugins and GObject Introspection files, ensuring compatibility with various multimedia libraries.
    GST_PLUGIN_PATH = lib.makeSearchPathOutput "lib" "lib/gstreamer-1.0"
      (with pkgs.gst_all_1; [
        gst-plugins-base
        gst-plugins-good
        gst-plugins-bad
        gst-plugins-ugly
        gst-libav
      ]);

    GI_TYPELIB_PATH = "${pkgs.glib}/lib/girepository-1.0:"
      + "${pkgs.gobject-introspection}/lib/girepository-1.0:"
      + "${pkgs.networkmanager}/lib/girepository-1.0:"
      + "${pkgs.gobject-introspection-unwrapped}/lib/girepository-1.0:"
      + "${pkgs.gst_all_1.gstreamer}/lib/girepository-1.0:"
      + "${pkgs.gst_all_1.gst-plugins-base}/lib/girepository-1.0:"
      + "${pkgs.gst_all_1.gst-plugins-ugly}/lib/girepository-1.0:"
      + "$GI_TYPELIB_PATH";
  };

  environment.systemPackages = with pkgs;
    [ gst123 ] ++ (with gst_all_1; [
      gst-editing-services
      gst-libav
      gst-plugins-bad
      gst-plugins-base
      gst-plugins-good
      gst-plugins-rs
      gst-plugins-ugly
      gst-vaapi
      gstreamer
    ]);

}
