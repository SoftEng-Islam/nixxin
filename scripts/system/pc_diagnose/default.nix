{ lib, pkgs, ... }:
let
  pcDiagnose = pkgs.stdenvNoCC.mkDerivation {
    pname = "pc_diagnose";
    version = "1.0.0";
    src = ./pc_diagnose.sh;
    dontUnpack = true;
    nativeBuildInputs = [ pkgs.makeWrapper ];

    installPhase = ''
      install -Dm755 "$src" "$out/bin/pc_diagnose"
      wrapProgram "$out/bin/pc_diagnose" \
        --prefix PATH : ${
          lib.makeBinPath [
            pkgs.bash # interpreter
            pkgs.coreutils # cat, date, df, dirname, head, id, ls, mkdir, readlink, tail, tee, uname
            pkgs.gnugrep # grep
            pkgs.gnused # sed  — used directly in redact_text()
            pkgs.gawk # awk  — used in bash -c blocks (lscpu/lspci/lsblk parsing)
            pkgs.procps # ps, free, uptime, vmstat
            pkgs.util-linux # dmesg, findmnt, lsblk, lscpu, swapon, zramctl
            pkgs.inetutils # hostname
          ]
        }
    '';
  };
in
{
  imports = [
    ./journal_live.nix
  ];

  environment.systemPackages = [
    pcDiagnose
  ];
}
