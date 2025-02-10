{ settings, lib, pkgs, ... }: { imports = [ ./amdgpu.nix ./rocm.nix ]; }
