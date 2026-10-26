{ pkgs, ... }:
let
  dest = "$HOME/.local/share/waydroid/data/media/0/DCIM";

  clipSave = pkgs.writeShellApplication {
    name = "waydroid-clip-save";
    runtimeInputs = [ pkgs.coreutils ];
    text = ''
      mkdir -p "$HOME/.cache"
      tmp="$(mktemp "$HOME/.cache/waydroid-clip.XXXXXX")"
      cat > "$tmp"
      if [ -s "$tmp" ]; then
        mv "$tmp" "${dest}/clip-$(date +%Y%m%d-%H%M%S).png"
      else
        rm -f "$tmp"
      fi
    '';
  };
in
{
  environment.systemPackages = [
    clipSave
    pkgs.wl-clipboard
  ];

  systemd.user.services.waydroid-clip-sync = {
    description = "Save copied images into Waydroid's gallery";
    wantedBy = [ "graphical-session.target" ];
    partOf = [ "graphical-session.target" ];
    after = [ "graphical-session.target" ];
    serviceConfig = {
      ExecStart = "${pkgs.wl-clipboard}/bin/wl-paste --type image/png --watch ${clipSave}/bin/waydroid-clip-save";
      Restart = "on-failure";
      RestartSec = 3;
    };
  };
}
