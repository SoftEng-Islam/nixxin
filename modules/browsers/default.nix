{ settings, inputs, lib, pkgs, ... }:
let
  inherit (lib) mkIf optional;
  browsers = settings.modules.browsers;
  _googleChrome = (pkgs.google-chrome.override {
    # enable video encoding and hardware acceleration, along with several
    # suitable for my configuration
    # change it if you have any issues
    # note the spaces, they are required
    # Vulkan is not stable, likely because of bad drivers
    # Flags enabled by command line have no need to be enabled in chrome://flags
    # commandLineArgs = "--enable-features=Vulkan,DefaultANGLEVulkan,VulkanFromANGLE,TouchpadOverscrollHistoryNavigation,AcceleratedVideoEncoder,AcceleratedVideoDecodeLinuxGL,AcceleratedVideoDecodeLinuxZeroCopyGL,ParallelDownloading,UseMultiPlaneFormatForHardwareVideo,WaylandLinuxDrmSyncobj,WaylandPerSurfaceScale,WaylandTextInputV3,WaylandUiScale --disable-font-subpixel-positioning=true --enable-zero-copy=true --use-vulkan=true --enable-hardware-overlays=true --enable-unsafe-webgpu";
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
      "--enable-features=${
        lib.concatStringsSep "," [
          "AcceleratedVideoDecodeLinuxGL"
          "AcceleratedVideoDecodeLinuxZeroCopyGL"
          "AcceleratedVideoEncoder"
          "CanvasOopRasterization"
          "ChromeWideEchoCancellation" # noise cancellation for WebRTC
          "DefaultANGLEVulkan"
          "DesktopScreenshots"
          "EnableDrDc"
          "EnableTabMuting" # Mute tabs from tab context
          "FluentOverlayScrollbar" # New scrollbar
          "FluentScrollbar"
          "GlobalMediaControlsUpdatedUI"
          "ParallelDownloading" # Faster downloads
          "PostQuantumKyber" # hybrid kyber for enhanced TLS security
          "PulseaudioLoopbackForCast" # Audio support for casting and screen sharing
          "PulseaudioLoopbackForScreenShare"
          "SkiaGraphite"
          "UIEnableSharedImageCacheForGpu" # Shared image cache
          "UseClientGmbInterface" # new ClientGmb interface to create GpuMemoryBuffers
          "UseDMSAAForTiles"
          "UseGpuSchedulerDfs"
          "UseMultiPlaneFormatForHardwareVideo"
          "VaapiVideoEncoder" # Video encoding support
          "Vulkan"
          "VulkanFromANGLE"
          "WaylandLinuxDrmSyncobj"
          "WaylandPerSurfaceScale"
          "WaylandTextInputV3"
          "WaylandUiScale"
        ]
      }"
    ];
  });
  _browsers = with pkgs; [
    (optional browsers.firefox-beta.enable firefox-beta)
    (optional browsers.brave.enable brave)
    (optional browsers.google-chrome.enable _googleChrome)
    (optional browsers.microsoft-edge.enable microsoft-edge)
  ];
in mkIf (settings.modules.browsers.enable) {
  programs.firefox = {
    enable = browsers.firefox.enable;
    package =
      inputs.zen-browser.packages.${pkgs.stdenv.hostPlatform.system}.default;
    policies = {
      DontCheckDefaultBrowser = true; # disable the annoying popup at startup
      HardwareAcceleration = true;
    };
  };
  environment.systemPackages = with pkgs;
    [
      # Put Your Browsers Packages Here
      # chromium
      # google-chrome
      # brave
      # microsoft-edge
      # firefox
      # firefox-beta
      firefox-devedition
    ] ++ lib.flatten _browsers;
}
