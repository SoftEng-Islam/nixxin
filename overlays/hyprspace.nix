{ lib, gcc13Stdenv, fetchFromGitHub, pkg-config, cmake, ninja, cairo, expat
, fribidi, hwdata, hyprcursor, hyprlang, hyprutils, libdatrie, libdrm, libinput
, libliftoff, libuuid, libxkbcommon, mesa, pango, pciutils, pcre2, seatd
, wayland, wayland-protocols, xorg, wayland-scanner, meson
, enableXWayland ? true, withSystemd ? false }:

gcc13Stdenv.mkDerivation rec {
  pname = "hyprspace";
  version = "edad6cf735097b7cb4406d3fc8daddd09dfa458a";

  src = fetchFromGitHub {
    owner = "KZDKM";
    repo = "Hyprspace";
    rev = version;
    sha256 = "sha256-LYtAvRlE1zJCYmnY1EYroGu5zGlIMMr9bFIBLM7hwng=";
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
