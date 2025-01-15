{ inputs, settings, pkgs, ... }: {
  environment.systemPackages = with pkgs;
    [
      (inputs.ignis.packages.${system}.ignis.overrideAttrs (oldAttrs: {
        propagatedBuildInputs = (oldAttrs.propagatedBuildInputs or [ ])
          ++ (with pkgs; [
            dart-sass
            (python312.withPackages (ppkgs:
              with ppkgs; [

                mypy
                ruff
                types-requests
                certifi
                charset-normalizer
                click
                xlib
                idna
                jinja2
                loguru
                markupsafe
                material-color-utilities
                materialyoucolor
                pillow
                pycairo
                pygobject-stubs
                pygobject3
                requests
                setuptools
                setuptools-scm
                urllib3
                # Library Names
              ]))
          ]);
      }))
    ];
  home-manager.users.${settings.username} = {
    home.file.".config/ignis".source = ./ignis;
    home.file.".local/share/themes/Material".source = ./Material;
  };
}
