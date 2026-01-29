{ settings, inputs, lib, pkgs, ... }:
let
  inherit (lib) mkIf;
  _googleChrome = (pkgs.google-chrome.override {
    # enable video encoding and hardware acceleration, along with several
    # suitable for my configuration
    # change it if you have any issues
    # note the spaces, they are required
    # Vulkan is not stable, likely because of bad drivers
    # Flags enabled by command line have no need to be enabled in chrome://flags
    commandLineArgs = lib.concatStringsSep " " [
      "--enable-accelerated-video-decode"
      "--enable-accelerated-vpx-decode"
      "--enable-accelerated-mjpeg-decode"
      "--enable-gpu-compositing"
      "--enable-gpu-rasterization"
      "--enable-native-gpu-memory-buffers"
      "--enable-raw-draw"
      "--enable-zero-copy"
      "--ignore-gpu-blocklist"
      # "--use-vulkan"
      "--enable-features=${
        lib.concatStringsSep "," [
          "ParallelDownloading" # Faster downloads
          "VaapiVideoEncoder" # Video encoding support
          "CanvasOopRasterization"
          "UseDMSAAForTiles"
          "UseGpuSchedulerDfs"
          "UIEnableSharedImageCacheForGpu" # Shared image cache
          "UseClientGmbInterface" # new ClientGmb interface to create GpuMemoryBuffers
          "SkiaGraphite"
          "EnableDrDc"
          "Vulkan"
          "VulkanFromANGLE"
          "PostQuantumKyber" # hybrid kyber for enhanced TLS security
          "PulseaudioLoopbackForCast" # Audio support for casting and screen sharing
          "PulseaudioLoopbackForScreenShare"
          "ChromeWideEchoCancellation" # noise cancellation for WebRTC
          "DesktopScreenshots"
          "FluentOverlayScrollbar" # New scrollbar
          "FluentScrollbar"
          "EnableTabMuting" # Mute tabs from tab context
          "GlobalMediaControlsUpdatedUI"
          # New media controls, with PIP
        ]
      }"
    ];
  });
  _browsers = with pkgs; [
    (lib.optional settings.modules.browsers.firefox.enable firefox)
    (lib.optional settings.modules.browsers.firefox-beta.enable firefox-beta)
    (lib.optional settings.modules.browsers.brave.enable brave)
    (lib.optional settings.modules.browsers.google-chrome.enable _googleChrome)
    (lib.optional settings.modules.browsers.microsoft-edge.enable
      microsoft-edge)
  ];
in mkIf (settings.modules.browsers.enable) {
  programs.firefox = {
    enable = true;
    package =
      inputs.zen-browser.packages.${pkgs.stdenv.hostPlatform.system}.default;
    policies = {
      DontCheckDefaultBrowser = true; # disable the annoying popup at startup
      HardwareAcceleration = true;
    };
  };
  environment.systemPackages = lib.flatten _browsers;
}
