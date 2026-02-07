{ pkgs ? import <nixpkgs> { } }:

let
  handbrake = pkgs.handbrake.overrideAttrs (old: {
    nativeBuildInputs = (old.nativeBuildInputs or [ ])
      ++ [ pkgs.autoAddDriverRunpath ];
  });

in pkgs.mkShellNoCC {
  name = "Handbrake shell";
  buildInputs = [ handbrake pkgs.libdvdcss ];
}
