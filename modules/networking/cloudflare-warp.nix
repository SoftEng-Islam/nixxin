{
  settings,
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
        echo "Cloudflare disconnect"
    else
        systemctl start cloudflare-warp.service
        sleep 1
        $WARP_CLI connect
        echo "Cloudflare connect"

    fi
  '';
in
lib.mkIf (settings.modules.networking.cloudflare-warp.enable or false) {
  services.cloudflare-warp = {
    enable = true;
    openFirewall = true;
  };
  systemd.packages = [ pkgs.cloudflare-warp ];
  systemd.targets.multi-user.wants = [ "warp-svc.service" ]; # causes warp-svc to be started automatically
  services.cloudflare-warp.udpPort = 2408;
  systemd.services.warp-svc = {
    description = "Cloudflare WARP daemon";
    wantedBy = [ "multi-user.target" ];
    after = [ "network-online.target" ];
    wants = [ "network-online.target" ];
    environment = {
      RUST_LOG = "error";
    };
    serviceConfig = {
      LogLevelMax = "notice";
      ExecStart = "${pkgs.cloudflare-warp}/bin/warp-svc";
      Restart = "always";
      RestartSec = "5";
      StateDirectory = "cloudflare-warp";
      ReadWritePaths = [ "/etc/resolv.conf" ];
      AmbientCapabilities = "CAP_NET_ADMIN CAP_NET_BIND_SERVICE CAP_NET_RAW";
      CapabilityBoundingSet = "CAP_NET_ADMIN CAP_NET_BIND_SERVICE CAP_NET_RAW";
      ProtectHome = true;
      StandardOutput = "null";
      StandardError = "null";

      # Hardening
      LockPersonality = true;
      PrivateMounts = true;
      PrivateTmp = true;
      ProtectControlGroups = true;
      ProtectHostname = true;
      ProtectKernelLogs = true;
      ProtectKernelModules = true;
      ProtectKernelTunables = true;
      ProtectProc = "invisible";
      ProtectSystem = "full";
      RestrictNamespaces = true;
      RestrictRealtime = true;
    };
  };

  # Register (once), put WARP in SOCKS proxy mode, and connect. The post-check
  # fails closed if WARP ever tries to hijack the server's default route.
  systemd.services.warp-connect = {
    description = "Connect Cloudflare WARP";
    wantedBy = [ "multi-user.target" ];
    wants = [ "network-online.target" ];
    after = [
      "warp-svc.service"
      "network-online.target"
    ];
    requires = [ "warp-svc.service" ];
    serviceConfig = {
      Type = "oneshot";
      RemainAfterExit = true;
      ExecStart = pkgs.writeScript "warp-connect" ''
        #!/bin/sh
        set -e
        WC="${pkgs.cloudflare-warp}/bin/warp-cli"
        for _ in $(${pkgs.coreutils}/bin/seq 1 30); do
          $WC --accept-tos status >/dev/null 2>&1 && break
          ${pkgs.coreutils}/bin/sleep 1
        done
        $WC --accept-tos registration new >/dev/null 2>&1 || true
        $WC --accept-tos mode proxy
        $WC --accept-tos proxy port 40000
        $WC --accept-tos connect
        ${pkgs.coreutils}/bin/sleep 3
        ${pkgs.iproute2}/bin/ip route del default dev CloudflareWARP 2>/dev/null || true
        ${pkgs.iproute2}/bin/ip -6 route del default dev CloudflareWARP 2>/dev/null || true
        if ! ${pkgs.iproute2}/bin/ip -4 route get 1.1.1.1 2>/dev/null | ${pkgs.gnugrep}/bin/grep -q ' dev enp1s0 '; then
          $WC --accept-tos disconnect || true
          ${pkgs.iproute2}/bin/ip route del default dev CloudflareWARP 2>/dev/null || true
          exit 1
        fi
      '';
    };
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
  environment.persistence."/persist" = {
    directories = [
      "/var/lib/cloudflare-warp"
    ];
  };
  environment.systemPackages = with pkgs; [
    cloudflare-warp
    # warpScript
  ];
}
