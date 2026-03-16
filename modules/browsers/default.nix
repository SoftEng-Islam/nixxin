{
  settings,
  inputs,
  lib,
  pkgs,
  ...
}:
let
  inherit (lib) mkIf optional;
  browsers = settings.modules.browsers;
  _googleChrome = (
    pkgs.google-chrome.override {
      # Hardware acceleration flags for video decode and GPU compositing.
      # Removed experimental/unstable flags that cause slowness:
      # - SkiaGraphite (experimental GPU renderer, causes major slowdowns)
      # - DefaultANGLEVulkan/VulkanFromANGLE/Vulkan (unstable on AMD, per upstream comment)
      # - UseGpuSchedulerDfs (experimental scheduler)
      # - --enable-raw-draw (experimental)
      # - --ignore-gpu-blocklist (forces GPU features Chrome blocked for compatibility)
      # - --enable-native-gpu-memory-buffers (can conflict with AMD iGPU)
      commandLineArgs = lib.concatStringsSep " " [
        "--enable-accelerated-video-decode"
        "--enable-accelerated-vpx-decode"
        "--enable-accelerated-mjpeg-decode"
        "--enable-gpu-compositing"
        "--enable-gpu-rasterization"
        "--enable-zero-copy"
        "--enable-features=${
          lib.concatStringsSep "," [
            "AcceleratedVideoDecodeLinuxGL"
            "AcceleratedVideoDecodeLinuxZeroCopyGL"
            "AcceleratedVideoEncoder"
            "CanvasOopRasterization"
            "ChromeWideEchoCancellation" # noise cancellation for WebRTC
            "EnableDrDc"
            "EnableTabMuting" # Mute tabs from tab context
            "FluentOverlayScrollbar" # New scrollbar
            "FluentScrollbar"
            "GlobalMediaControlsUpdatedUI"
            "ParallelDownloading" # Faster downloads
            "PulseaudioLoopbackForCast" # Audio support for casting and screen sharing
            "PulseaudioLoopbackForScreenShare"
            "UIEnableSharedImageCacheForGpu" # Shared image cache
            "UseDMSAAForTiles"
            "UseMultiPlaneFormatForHardwareVideo"
            "VaapiVideoEncoder" # Video encoding support
            "WaylandLinuxDrmSyncobj"
            "WaylandPerSurfaceScale"
            "WaylandTextInputV3"
            "WaylandUiScale"
          ]
        }"
      ];
    }
  );
  _browsers = with pkgs; [
    (optional browsers.firefox-beta.enable firefox-beta)
    (optional browsers.brave.enable brave)
    (optional browsers.google-chrome.enable _googleChrome)
    (optional browsers.microsoft-edge.enable microsoft-edge)
  ];
in
mkIf (settings.modules.browsers.enable) {
  programs.firefox = {
    enable = browsers.firefox.enable;
    package = inputs.zen-browser.packages.${pkgs.stdenv.hostPlatform.system}.default;
    policies = {
      DontCheckDefaultBrowser = true; # disable the annoying popup at startup
      HardwareAcceleration = true;
    };
  };
  environment.systemPackages =
    with pkgs;
    [
      # Put Your Browsers Packages Here
      # chromium
      # google-chrome
      # brave
      # microsoft-edge
      # firefox
      # firefox-beta
      firefox-devedition
      # inputs.zen-browser.packages.${pkgs.stdenv.hostPlatform.system}.default
    ]
    ++ lib.flatten _browsers;
}
