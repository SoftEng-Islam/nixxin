{ inputs, lib, settings, pkgs, ... }:

lib.mkIf (settings.modules.widgets.ignis.enable) {
  home-manager.users."${settings.user.username}" = {
    xdg.configFile = { "ignis".source = ./main; };
    # home.file.".config/ignis".source = ./main;
    home.file.".local/share/themes/Material".source = ./Material;
  };
  environment.systemPackages = with pkgs;
    [
      (inputs.ignis.packages.${system}.ignis.overrideAttrs (oldAttrs: {
        propagatedBuildInputs = (oldAttrs.propagatedBuildInputs or [ ])
          ++ (with pkgs; [
            # dart-sass
            grass-sass
            libpulseaudio
            (python312.withPackages (ppkgs:
              with ppkgs; [
                jinja2
                pillow
                materialyoucolor
                material-color-utilities
              ]))
          ]);
      }))
    ];
}
