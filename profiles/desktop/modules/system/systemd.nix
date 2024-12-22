{ pkgs, ... }: {
  systemd = {
    timers.nix-cleanup-gcroots = {
      timerConfig = {
        OnCalendar = [ "weekly" ];
        Persistent = true;
      };
      wantedBy = [ "timers.target" ];
    };
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
    user.services.polkit-gnome-authentication-agent-1 = {
      description = "polkit-gnome-authentication-agent-1";
      wantedBy = [ "graphical-session.target" ];
      wants = [ "graphical-session.target" ];
      after = [ "graphical-session.target" ];
      serviceConfig = {
        Type = "simple";
        ExecStart =
          "${pkgs.polkit_gnome}/libexec/polkit-gnome-authentication-agent-1";
        Restart = "on-failure";
        RestartSec = 1;
        TimeoutStopSec = 10;
      };
    };
  };
}
