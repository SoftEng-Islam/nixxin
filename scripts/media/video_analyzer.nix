{ lib, pkgs, ... }:
let
  videoAnalyzer = pkgs.stdenvNoCC.mkDerivation {
    pname = "video_analyzer";
    version = "1.0.0";
    src = ./video_analyzer.sh;
    dontUnpack = true;
    nativeBuildInputs = [ pkgs.makeWrapper ];

    installPhase = ''
      install -Dm755 "$src" "$out/bin/video_analyzer"
      wrapProgram "$out/bin/video_analyzer" \
        --prefix PATH : ${lib.makeBinPath [
          pkgs.bash
          pkgs.coreutils
          pkgs.ffmpeg-full
          pkgs.findutils
          pkgs.gawk
          pkgs.gnused
          pkgs.jq
        ]}
    '';
  };
in
{
  environment.systemPackages = [ videoAnalyzer ];
}
