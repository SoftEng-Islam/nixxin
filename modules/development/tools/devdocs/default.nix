{ settings, lib, pkgs ? import <nixpkgs> { } }:
# git clone https://github.com/freeCodeCamp/devdocs
let
  rubyEnv = pkgs.bundlerEnv {
    name = "devdocs-gems";
    ruby = pkgs.ruby;
    gemdir = ./devdocs; # Path to the cloned repository
  };
in lib.mkIf (settings.modules.developement.tools.devdocs.enable)
pkgs.stdenv.mkDerivation rec {
  pname = "devdocs";
  version = "latest";

  src = pkgs.fetchFromGitHub {
    owner = "freeCodeCamp";
    repo = "devdocs";
    rev = "master";
    sha256 = ""; # Run `nix-prefetch-git` to get the hash
  };

  nativeBuildInputs = [ pkgs.ruby pkgs.bundler pkgs.thor pkgs.rack rubyEnv ];

  buildPhase = ''
    export GEM_HOME=$PWD/gems
    export PATH=$GEM_HOME/bin:$PATH

    gem install bundler
    bundle install --path=$GEM_HOME

    bundle exec thor docs:download --default
  '';

  installPhase = ''
    mkdir -p $out
    cp -r * $out
  '';

  meta = {
    description = "DevDocs offline documentation";
    homepage = "https://github.com/freeCodeCamp/devdocs";
    license = pkgs.lib.licenses.mit;
    platforms = pkgs.lib.platforms.unix;
  };
}
