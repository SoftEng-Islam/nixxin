{ inputs, settings, pkgs, ... }: {
  environment.systemPackages = with pkgs; [
    click
    loguru
    (inputs.ignis.packages.${system}.ignis.overrideAttrs (oldAttrs: {
      propagatedBuildInputs = (oldAttrs.propagatedBuildInputs or [ ])
        ++ (with pkgs;
          [
            (python312.withPackages (ppkgs: [
              ppkgs.materialyoucolor
              ppkgs.material-color-utilities
              ppkgs.pillow
              ppkgs.jinja2
              ppkgs.cairo
              ppkgs.pygobject-stubs
              ppkgs.pygobject3
              ppkgs.requests
              ppkgs.setuptools-scm
              ppkgs.setuptools
              # Library Names
            ]))
          ]);
    }))
  ];
  home-manager.users.${settings.username} = {
    home.file.".config/ignis".source = ./ignis;
  };
}
