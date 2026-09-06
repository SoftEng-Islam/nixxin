{
  lib,
  pkgs,
  ...
}:
let
  warpScript = pkgs.writeShellScriptBin "warp" ''
    WARP_CLI="${pkgs.cloudflare-warp}/bin/warp-cli"

    if systemctl is-active --quiet cloudflare-warp.service; then
        $WARP_CLI disconnect || true
        systemctl stop cloudflare-warp.service
    else
        systemctl start cloudflare-warp.service
        sleep 1
        $WARP_CLI connect
    fi
  '';
in
{
  services.cloudflare-warp = {
    enable = true;
    openFirewall = true;
  };

  systemd.services.router-cloudflare-warp-setup = {
    description = "Configure Cloudflare WARP connection";
    after = [
      "cloudflare-warp.service"
      "network-online.target"
    ];
    wants = [
      "cloudflare-warp.service"
      "network-online.target"
    ];
    wantedBy = [ "multi-user.target" ];
    serviceConfig = {
      Type = "oneshot";
      RemainAfterExit = true;
    };
    script = ''
      set -euo pipefail
      WARP_CLI="${pkgs.cloudflare-warp}/bin/warp-cli"

      # 1. Wait up to 15 seconds for daemon socket to open
      for i in {1..15}; do
        if $WARP_CLI status >/dev/null 2>&1; then
          break
        fi
        sleep 1
      done

      # 2. Register if no existing registration is found
      if ! $WARP_CLI status | grep -i "Registration" >/dev/null 2>&1; then
        $WARP_CLI registration new || true
      fi

      # 3. Set connection mode
      $WARP_CLI mode warp || true

      # 4. Establish connection
      $WARP_CLI connect || true
    '';
  };
  security.polkit.extraConfig = ''
    polkit.addRule(function(action, subject) {
      if (action.id == "org.freedesktop.systemd1.manage-units" &&
          action.lookup("unit") == "cloudflare-warp.service" &&
          subject.isInGroup("wheel")) {
        return polkit.Result.YES;
      }
    });
  '';
  environment.systemPackages = with pkgs; [
    cloudflare-warp
    warpScript
  ];
}
