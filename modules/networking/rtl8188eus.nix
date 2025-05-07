{ settings, config, pkgs, ... }:
let
  kernel = pkgs.linuxPackages_zen;
  system = "x86_64-linux";
in {
  packages.${system}.rtl8188eus = pkgs.stdenv.mkDerivation {
    pname = "rtl8188eus";
    version = "unstable-2024-05";

    src = pkgs.fetchFromGitHub {
      owner = "aircrack-ng";
      repo = "rtl8188eus";
      rev = "master";
      # nix-prefetch-git https://github.com/aircrack-ng/rtl8188eus
      sha256 =
        "sha256-eLul1YKiRwOlT+sDbSp2pc7CGdfqxqb5CoGK2a8qoq8="; # will fail first time
    };

    nativeBuildInputs =
      [ pkgs.kernel.dev pkgs.kernel.headers pkgs.make pkgs.gcc ];

    hardeningDisable = [ "pic" ];

    makeFlags =
      [ "KSRC=${kernel.dev}/lib/modules/${kernel.modDirVersion}/build" ];

    installPhase = ''
      mkdir -p $out/lib/modules/${kernel.modDirVersion}/kernel/drivers/net/wireless/
      cp 8188eu.ko $out/lib/modules/${kernel.modDirVersion}/kernel/drivers/net/wireless/
    '';
  };
}
