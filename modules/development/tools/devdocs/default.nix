{ settings, config, pkgs, lib, ... }:
let inherit (lib) mkIf;
in mkIf (settings.modules.development.tools.devdocs.enable) {
  environment.systemPackages = with pkgs;
    [
      (pkgs.stdenv.mkDerivation rec {
        pname = "devdocs";
        version = "latest";

        src = pkgs.fetchFromGitHub {
          owner = "freeCodeCamp";
          repo = "devdocs";
          rev = "master";
          sha256 = ""; # Run `nix-prefetch-git` to get the correct hash
        };

        nativeBuildInputs = [ pkgs.ruby pkgs.bundler ];

        buildPhase = ''
          export GEM_HOME=$PWD/gems
          export PATH=$GEM_HOME/bin:$PATH

          gem install bundler
          bundle install --path=$GEM_HOME

          bundle exec thor docs:download --default
        '';

        installPhase = ''
          mkdir -p $out/bin
          cp -r * $out

          echo '#!/bin/sh' > $out/bin/devdocs
          echo 'cd $out && bundle exec rackup' >> $out/bin/devdocs
          chmod +x $out/bin/devdocs
        '';

        meta = {
          description = "DevDocs offline documentation";
          homepage = "https://github.com/freeCodeCamp/devdocs";
          license = lib.licenses.mit;
          platforms = lib.platforms.unix;
        };
      })
    ];
}
