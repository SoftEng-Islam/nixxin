{ settings, ... }:
{
  home-manager.users.${settings.user.username} = {
    wayland.windowManager.hyprland.settings = {
      # ╔═══════════════════════════════════════════════════════════════╗
      # ║                    Monitor Configuration                      ║
      # ║  Format: name, resolution@refresh, position, scale            ║
      # ╚═══════════════════════════════════════════════════════════════╝
      monitor = [
        # Primary: 1440p @ 144Hz - Great for AMD APU gaming, VRR on for fullscreen only
        "HDMI-A-1,2560x1440@144,0x0,1,vrr,1"
        # Secondary: 1080p @ 60Hz
        "DP-1,1920x1080@60,2560x0,1"

        # Fallback for unknown monitors (auto-detect)
        # ",preferred,auto,1"
      ];
    };
  };
}
