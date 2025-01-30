# Edit this configuration file to define what should be installed on your system. Help is available in the
# configuration.nix(5) man page and in the NixOS manual (accessible by running ‘nixos-help’).
{ ... }: {

  # For Faster rebuilding Disable These
  documentation = {
    enable = true;
    doc.enable = true;
    man = {
      enable = true;
      generateCaches = true;
    };
    dev.enable = true;
    info.enable = true;
    nixos.enable = true;
  };
}
