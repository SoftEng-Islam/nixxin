{ pkgs, ... }: {
  # ~~~~~~~~~~~~~~~~~~~~~~~~
  # ~~~~~~~ Programs ~~~~~~~
  # ~~~~~~~~~~~~~~~~~~~~~~~~
  programs = {
    nh.enable = true;
    # See https://nix.dev/permalink/stub-ld.
    # run unpatched dynamic binaries on NixOS
    nix-ld = {
      enable = true;
      libraries = with pkgs; [ fontconfig freetype stdenv.cc.cc util-linux ];
    };

    command-not-found.enable = false;

    # corectrl to overclock your CPU APU GPU
    corectrl.enable = true;
    corectrl.gpuOverclock.enable = true;
    corectrl.gpuOverclock.ppfeaturemask = "0xffffffff";

    dconf.enable = true; # dconf
    droidcam.enable = true; # camera
    mtr.enable = true;
    fuse.userAllowOther = true;

    htop.enable = true;
    htop.settings = { tree_view = 1; };

    gnupg.agent.enable = true;
    gnupg.agent.enableSSHSupport = true;

    # Required by gnome file managers
    file-roller.enable = true;
    gnome-disks.enable = true;

    # required by libreoffice
    # java.enable = true;
  };
}
