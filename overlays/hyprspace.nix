{ lib, gcc13Stdenv, fetchFromGitHub, pkg-config, cmake, ninja, cairo, expat
, fribidi, hwdata, hyprcursor, hyprlang, hyprutils, libdatrie, libdrm, libinput
, libliftoff, libuuid, libxkbcommon, mesa, pango, pciutils, pcre2, seatd
, wayland, wayland-protocols, xorg, wayland-scanner, systemd, meson
, enableXWayland ? true, withSystemd ? false }:

let
  hyprspaceVersions = {
    "0.45.2" = {
      rev = "12f9a0d0b93f691d4d9923716557154d74777b0a";
      sha256 = "260f386075c7f6818033b05466a368d8821cde2d";
    };
    "0.46.0" = {
      rev = "788ae588979c2a1ff8a660f16e3c502ef5796755";
      sha256 = "49ef4c37c6f84dcbf7fb641bad3d60703a2bb068";
    };
    "0.46.1" = {
      rev = "254fc2bc6000075f660b4b8ed818a6af544d1d64";
      sha256 = "49ef4c37c6f84dcbf7fb641bad3d60703a2bb068";
    };
    "0.46.2" = {
      rev = "0bd541f2fd902dbfa04c3ea2ccf679395e316887";
      sha256 = "cd58d2e47b575c66c2682436ba425ccdc8462998";
    };
  };

  selectedVersion = "0.46.2"; # Change this to select a different version
  hyprspaceAttrs = hyprspaceVersions.${selectedVersion};
in gcc13Stdenv.mkDerivation rec {
  pname = "hyprspace";
  version = selectedVersion;

  src = fetchFromGitHub {
    owner = "KZDKM";
    repo = "Hyprspace";
    rev = hyprspaceAttrs.rev;
    sha256 = hyprspaceAttrs.sha256;
  };

  nativeBuildInputs = [ pkg-config cmake ninja wayland-scanner meson ];

  buildInputs = lib.concatLists [
    [
      cairo
      expat
      fribidi
      hwdata
      hyprcursor
      hyprlang
      hyprutils
      libdatrie
      libdrm
      libinput
      libliftoff
      libuuid
      libxkbcommon
      mesa
      pango
      pciutils
      pcre2
      seatd
      wayland
      wayland-protocols
      xorg.libXcursor
    ]
    (lib.optionals enableXWayland [
      xorg.libxcb
      xorg.libXdmcp
      xorg.xcbutil
      xorg.xcbutilerrors
      xorg.xcbutilrenderutil
      xorg.xcbutilwm
    ])
    (lib.optionals withSystemd [ systemd ])
  ];

  dontUseCmakeConfigure = true;

  meta = {
    description = "Hyprspace - A network transparency protocol for Hyprland";
    license = lib.licenses.mit;
    platforms = lib.platforms.linux;
  };
}
