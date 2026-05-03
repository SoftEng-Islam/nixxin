{ lib, pkgs, ... }:
let
  showtime = pkgs.stdenvNoCC.mkDerivation {
    pname = "showtime";
    version = "1.0.0";
    src = ./datetime.sh;
    dontUnpack = true;
    nativeBuildInputs = [ pkgs.makeWrapper ];

    installPhase = ''
      install -Dm755 "$src" "$out/bin/showtime"
      wrapProgram "$out/bin/showtime" \
        --prefix PATH : ${
          lib.makeBinPath [
            pkgs.bash
            pkgs.coreutils
            pkgs.ncurses
            pkgs.toilet
            pkgs.figlet
          ]
        }
    '';
  };
in
{
  environment.systemPackages = [ showtime ];
}
