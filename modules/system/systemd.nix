{ settings, lib, pkgs, ... }:
let inherit (lib) mkIf;
in {
  systemd = {
    # ------------------------------------------------
    # ----
    # ------------------------------------------------
    sleep.extraConfig = ''
      AllowSuspend=no
      AllowHibernation=no
      AllowSuspendThenHibernate=no
      AllowHybridSleep=no
    '';

    # ------------------------------------------------
    # ----
    # ------------------------------------------------
    timers.nix-cleanup-gcroots = {
      timerConfig = {
        OnCalendar = [ "weekly" ];
        Persistent = true;
      };
      wantedBy = [ "timers.target" ];
    };

    # ------------------------------------------------
    # ----
    # ------------------------------------------------
    services.nix-cleanup-gcroots = {
      serviceConfig = {
        Type = "oneshot";
        ExecStart = [
          # delete automatic gcroots older than 30 days
          "${pkgs.findutils}/bin/find /nix/var/nix/gcroots/auto /nix/var/nix/gcroots/per-user -type l -mtime +30 -delete"

          # created by nix-collect-garbage, might be stale
          "${pkgs.findutils}/bin/find /nix/var/nix/temproots -type f -mtime +10 -delete"

          # delete broken symlinks
          "${pkgs.findutils}/bin/find /nix/var/nix/gcroots -xtype l -delete"
        ];
      };
    };

    # ------------------------------------------------
    # ---- Hackity
    # - HACK for working D-Bus activation
    # ------------------------------------------------
    user.services.dbus.environment.DISPLAY = ":0";

    # ------------------------------------------------
    # ---- Tweaks improve boot times
    # ------------------------------------------------
    services."*" = { serviceConfig = { TimeoutStartSec = "30s"; }; };
  };

  home-manager.users.${settings.user.username} = {
    # Fake a tray to let apps start
    # https://github.com/nix-community/home-manager/issues/2064
    systemd.user.targets.tray = {
      Unit = {
        Description = "Home Manager System Tray";
        Requires = [ "graphical-session-pre.target" ];
      };
    };
    systemd.user.targets.wayland-session = {
      Unit = {
        Description = "wayland compositor session";
        Documentation = [ "man:systemd.special(7)" ];
        BindsTo = [ "graphical-session.target" ];
        Wants = [ "graphical-session-pre.target" ];
        After = [ "graphical-session-pre.target" ];
      };
    };
  };
  environment.systemPackages = with pkgs; [ systemd ];
}
