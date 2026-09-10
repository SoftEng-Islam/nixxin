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
          bitdepth = 8;
          cm = "srgb"; # Desktop stays in sRGB; cm_auto_hdr handles HDR games
          sdr_eotf = "gamma22";
          supports_wide_color = 0; # 0 = auto (allows DCI-P3 wide color in HDR)
          supports_hdr = 1; # 1 = force HDR capability enabled
        }
        {
          # Secondary: Samsung S22C450 (1080p @ 60Hz)
          output = "DP-1";
          mode = "1920x1080@60";
          position = "2560x0";
          scale = 1;
          vrr = 0;
          bitdepth = 8;
          cm = "auto";
          sdr_eotf = "gamma22";
          supports_hdr = -1; # Disable HDR processing for secondary SDR display
        }
      ];

      # Workspace-to-Monitor Bindings
      workspace = [
        "1, monitor:HDMI-A-1, default:true"
        "2, monitor:DP-1, default:true"
      ];

    };
  };
}
