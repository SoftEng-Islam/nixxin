{ settings, config, lib, pkgs, ... }:
let inherit (lib) makeSearchPathOutput;
in {
  environment.extraInit = ''
    export GST_PLUGIN_PATH_1_0=/run/current-system/sw/lib/gstreamer-1.0
    export GST_PLUGIN_SYSTEM_PATH_1_0=${pkgs.gst_all_1.gstreamer}/lib/gstreamer-1.0:${pkgs.gst_all_1.gst-libav}/lib/gstreamer-1.0:${pkgs.gst_all_1.gst-plugins-base}/lib/gstreamer-1.0:${pkgs.gst_all_1.gst-plugins-good}/lib/gstreamer-1.0:${pkgs.gst_all_1.gst-plugins-bad}/lib/gstreamer-1.0:${pkgs.gst_all_1.gst-plugins-ugly}/lib/gstreamer-1.0:${pkgs.gst_all_1.gst-plugins-rs}/lib/gstreamer-1.0:${pkgs.gst_all_1.gst-vaapi}/lib/gstreamer-1.0
  '';

  environment.variables = {
    # Allow apps to detect gstreamer plugins
    GST_PLUGIN_PATH_1_0 = [ "/run/current-system/sw/lib/gstreamer-1.0" ];

    # Fix for missing audio/video information in properties https://github.com/NixOS/nixpkgs/issues/53631
    # GST_PLUGIN_SYSTEM_PATH_1_0 =
    #   lib.makeSearchPathOutput "lib" "lib/gstreamer-1.0" (with pkgs.gst_all_1; [
    #     gst-plugins-base
    #     gst-plugins-good
    #     gst-plugins-bad
    #     gst-plugins-ugly
    #     gst-plugins-rs
    #     gst-libav
    #     gst-vaapi
    #   ]); # Fix from https://github.com/NixOS/nixpkgs/issues/195936#issuecomment-1366902737

    GST_PLUGIN_SYSTEM_PATH_1_0 = with pkgs.gst_all_1; [
      "${gstreamer}/lib/gstreamer-1.0"
      "${gst-libav}/lib/gstreamer-1.0"
      "${gst-vaapi}/lib/gstreamer-1.0"
      "${gst-plugins-base}/lib/gstreamer-1.0"
      "${gst-plugins-good}/lib/gstreamer-1.0"
      "${gst-plugins-bad}/lib/gstreamer-1.0"
      "${gst-plugins-ugly}/lib/gstreamer-1.0"
      "${gst-plugins-rs}/lib/gstreamer-1.0"
      "${pkgs.pipewire}/lib/gstreamer-1.0"
      "${pkgs.pulseeffects-legacy}/lib/gstreamer-1.0"
    ];

    # Define paths for GStreamer plugins and GObject Introspection files, ensuring compatibility with various multimedia libraries.
    GST_PLUGIN_PATH = with pkgs.gst_all_1; [
      "${gstreamer}/lib/gstreamer-1.0"
      "${gst-libav}/lib/gstreamer-1.0"
      "${gst-vaapi}/lib/gstreamer-1.0"
      "${gst-plugins-base}/lib/gstreamer-1.0"
      "${gst-plugins-good}/lib/gstreamer-1.0"
      "${gst-plugins-bad}/lib/gstreamer-1.0"
      "${gst-plugins-ugly}/lib/gstreamer-1.0"
      "${gst-plugins-rs}/lib/gstreamer-1.0"
      "${pkgs.pipewire}/lib/gstreamer-1.0"
      "${pkgs.pulseeffects-legacy}/lib/gstreamer-1.0"
    ];

    GI_TYPELIB_PATH = "${pkgs.glib}/lib/girepository-1.0:"
      + "${pkgs.gobject-introspection}/lib/girepository-1.0:"
      + "${pkgs.networkmanager}/lib/girepository-1.0:"
      + "${pkgs.gobject-introspection-unwrapped}/lib/girepository-1.0:"
      + "${pkgs.gst_all_1.gstreamer}/lib/girepository-1.0:"
      + "${pkgs.gst_all_1.gst-plugins-base}/lib/girepository-1.0:"
      + "${pkgs.gst_all_1.gst-plugins-ugly}/lib/girepository-1.0:"
      + "$GI_TYPELIB_PATH";

    GRL_PLUGIN_PATH = "${pkgs.grilo-plugins}/lib/grilo-0.2";
  };

  environment.systemPackages = with pkgs;
    [
      gst123
      grilo
      grilo-plugins

      # clutter
      # clutter-gst
      # clutter-gst

      shared-mime-info
    ] ++ (with gst_all_1; [
      gst-editing-services

      # Plugins to reuse ffmpeg to play almost every video format
      gst-libav

      # Common plugins like "filesrc" to combine within e.g. gst-launch
      gst-plugins-base

      # Specialized plugins separated by quality
      gst-plugins-good
      gst-plugins-bad
      gst-plugins-ugly

      gst-plugins-rs

      # Support the Video Audio (Hardware) Acceleration API
      gst-vaapi

      # Video/Audio data composition framework tools like "gst-inspect", "gst-launch" ...
      gstreamer
    ]);
}
