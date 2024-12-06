{ pkgs }:
pkgs.stdenv.mkDerivation {
  name = "gruvbox-plus";
  src = { url = "https://github.com/SylEleuth/gruvbox-plus-icon-pack"; };
}
