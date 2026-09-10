{ settings, ... }:
{
  home-manager.users.${settings.user.username} = {
    wayland.windowManager.hyprland.settings = {
      # ╔═══════════════════════════════════════════════════════════════╗
      # ║                    Monitor Configuration                      ║
      # ║  Format: name, resolution@refresh, position, scale            ║
      # ╚═══════════════════════════════════════════════════════════════╝
      monitor = [
        {
          # Primary: 1440p @ 144Hz - Great for AMD APU gaming, VRR on for fullscreen only
          output = "HDMI-A-1";
          mode = "2560x1440@144";
          position = "0x0";
          scale = "auto";
          vrr = 1;
          bitdepth = 8; # 8 or 10
          cm = "hdr";
          sdr_eotf = "srgb"; # SDR transfer function Options: "default"/"gamma22"/"srgb"
          supports_wide_color = 0; # Force wide color gamut (-1 = off, 0 = auto, 1 = on)
          supports_hdr = 1; # Force HDR support. -1 = off, 0 = auto, 1 = on. Options: [-1 - 1]
        }
        {
          # Secondary: 1080p @ 60Hz - Great for AMD APU gaming, VRR on for fullscreen only
          output = "DP-1";
          mode = "1920x1080@60";
          position = "2560x0";
          scale = "auto";
          vrr = 0;
          bitdepth = 8; # 8 or 10
          cm = "auto";
          supports_hdr = -1; # Force HDR support. -1 = off, 0 = auto, 1 = on. Options: [-1 - 1]
        }
      ];
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
