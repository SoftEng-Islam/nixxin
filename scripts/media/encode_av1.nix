{ lib, pkgs, ... }:
let
  encodeAv1 = pkgs.stdenvNoCC.mkDerivation {
    pname = "encode_av1";
    version = "1.0.0";
    src = ./encode_av1.sh;
    dontUnpack = true;
    nativeBuildInputs = [ pkgs.makeWrapper ];

    installPhase = ''
      install -Dm755 "$src" "$out/bin/encode_av1"
      wrapProgram "$out/bin/encode_av1" \
        --prefix PATH : ${lib.makeBinPath [
          pkgs.bash
          pkgs.coreutils
          pkgs.ffmpeg-full
          pkgs.gnugrep
        ]}
    '';
  };
in
{
  environment.systemPackages = [ encodeAv1 ];
}
