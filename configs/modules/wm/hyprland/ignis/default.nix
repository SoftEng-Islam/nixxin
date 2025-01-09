{ inputs, settings, pkgs, ... }: {
  environment.systemPackages = with pkgs;
    [
      (inputs.ignis.packages.${system}.ignis.overrideAttrs (oldAttrs: {
        propagatedBuildInputs = (oldAttrs.propagatedBuildInputs or [ ])
          ++ (with pkgs;
            [
              (python312.withPackages (ppkgs: [
                ppkgs.materialyoucolor
                ppkgs.pillow
                ppkgs.jinja2
                # Library Names
              ]))
            ]);
      }))
    ];
  home-manager.users.${settings.username} = {
    home.file.".config/ignis".source = ./ignis;
  };
}
