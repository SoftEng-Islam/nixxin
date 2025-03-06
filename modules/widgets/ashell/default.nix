{ settings, lib, config, inputs, pkgs, ... }:
let inherit (lib) optionals mkIf;
in {
  # imports = optionals (settings.modules.ashell.enable) [  ];

  config = mkIf (settings.modules.widgets.ashell.enable) {
    home-manager.users.${settings.user.username} = {
      # systemd.user.services.ashell = {
      #   Unit = {
      #     Description = "Ashell shell";
      #     PartOf = [ "hyprland-session.target" ];
      #     After = [ "hyprland-session.target" ];
      #   };
      #   Install = { WantedBy = [ "hyprland-session.target" ]; };
      #   Service = {
      #     ExecStart =
      #       "${inputs.ashell.defaultPackage.${pkgs.system}}/bin/ashell";
      #     Restart = "on-failure";
      #     Type = "simple";
      #   };
      # };

      # ashell Configs
      xdg.configFile = { "ashell.yml".source = ./ashell.yml; };
      # home.file.".config/ashell.yml".source = ./ashell.yml;

    };

    environment.systemPackages =
      [ inputs.ashell.defaultPackage."${pkgs.system}" ];
  };
}
