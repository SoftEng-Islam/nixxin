{ lib, stdenv, fetchFromGitHub, gcc, ... }:
stdenv.mkDerivation {
  pname = "ashell";
  version = "latest";

  src = fetchFromGitHub {
    owner = "MalpenZibo";
    repo = "ashell";
    rev = "main"; # You can change this to a specific commit
    sha256 =
      "1fvk3yl5z1sirm6ngi45j59r5b0raa5xszjbh23bkc389sbkzxiv"; # Replace with the actual hash
  };

  nativeBuildInputs = [ gcc ];

  buildPhase = ''
    gcc -o ashell ashell.c
  '';

  installPhase = ''
    mkdir -p $out/bin
    cp ashell $out/bin/
  '';

  meta = with lib; {
    description = "A simple shell written in C";
    license = licenses.mit;
    platforms = platforms.linux;
  };
}
