{ settings, lib, inputs, ... }:
let inherit (lib) mkIf;
in mkIf (settings.modules.ashell.enable) {
  systemd.user.services = {
    ashell = {
      Unit = {
        Description = "ashell status bar";
        PartOf = [ "hyprland-session.target" ];
      };

      Service = {
        ExecStart = "${inputs.ashell.defaultPackage.x86_64-linux}/bin/ashell";
        Restart = "on-failure";
      };

      Install.WantedBy = [ "hyprland-session.target" ];
    };
  };
}
