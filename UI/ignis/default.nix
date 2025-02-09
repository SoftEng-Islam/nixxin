{ inputs, settings, pkgs, ... }: {
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
  home-manager.users."${settings.users.selected.username}" = {
    xdg.configFile = { "ignis".source = ./ignis; };
    # home.file.".config/ignis".source = ./ignis;
    home.file.".local/share/themes/Material".source = ./Material;
  };
}
