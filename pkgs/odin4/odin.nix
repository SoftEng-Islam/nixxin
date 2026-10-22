{
  lib,
  stdenv,
  fetchurl,
  autoPatchelfHook,
  libusb1,
  zlib,
}:
stdenv.mkDerivation {
  pname = "odin4";
  version = "1.2.1";

  src = fetchurl {
    url = "https://gitlab.com/leahh/leahs-overlay/-/raw/main/app-mobilephone/odin4-bin/files/odin4-1.2.1.tar.gz";
    sha256 = "sha256-urGO9oq/60P2wAHRZPLfW513ZR6nYJr3n67DbNfbkx4=";
  };

  sourceRoot = ".";

  nativeBuildInputs = [ autoPatchelfHook ];

  buildInputs = [
    stdenv.cc.cc.lib
    libusb1
    zlib
  ];

  installPhase = ''
    runHook preInstall
    install -Dm755 odin4 $out/bin/odin4
    runHook postInstall
  '';

  meta = {
    description = "Odin v4, Samsung's firmware flasher for Download Mode";
    homepage = "https://gitlab.com/leahh/leahs-overlay";
    license = lib.licenses.unfree;
    platforms = [ "x86_64-linux" ];
    mainProgram = "odin4";
  };
}
