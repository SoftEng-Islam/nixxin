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

    # droidcam.enable = true; # camera
    mtr.enable = true;
    fuse.userAllowOther = true;

    # gnupg.agent.enable = true;
    # gnupg.agent.enableSSHSupport = true;

    # required by libreoffice
    # java.enable = true;
  };
}
