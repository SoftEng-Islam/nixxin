{ settings, ... }:
{
  home-manager.users.${settings.user.username} = {
    wayland.windowManager.hyprland.settings = {

      # Monitor Configuration
      monitor = [
        {
          # Primary: Samsung Odyssey G5 (1440p @ 144Hz)
          output = "HDMI-A-1";
          mode = "2560x1440@144";
          position = "0x0";
          scale = 1;
          vrr = 1;
          bitdepth = 8; # This MUST be 10 for HDR to work properly
          cm = "srgb"; # Desktop stays in sRGB; cm_auto_hdr handles HDR games
          sdr_eotf = "gamma22";
          supports_hdr = -1; # Force HDR support. -1 = off, 0 = auto, 1 = on. Options: [-1 - 1]
          sdrbrightness = 1.0;
          sdrsaturation = 1.2;
        }
        {
          # Secondary: Samsung S22C450 (1080p @ 60Hz)
          output = "DP-1";
          mode = "1920x1080@60";
          position = "2560x0";
          scale = 1;
          # vrr = 0;
          bitdepth = 8;
          cm = "srgb"; # Desktop stays in sRGB; cm_auto_hdr handles HDR games
          sdr_eotf = "gamma22";
          supports_hdr = -1; # Disable HDR processing for secondary SDR display
          sdrbrightness = 1.2;
          sdrsaturation = 1.2;
        }
      ];

      # Workspace-to-Monitor Bindings
      workspace_rule = [
        {
          # Workspace 1: 1440p @ 144Hz - Great for AMD APU gaming, VRR on for fullscreen only
          workspace = 1;
          monitor = "HDMI-A-1";
        }
        {
          # Workspace 2: 1080p @ 60Hz - Great for AMD APU gaming, VRR on for fullscreen only
          workspace = 2;
          monitor = "DP-1";
        }
      ];
    };
  };
}
