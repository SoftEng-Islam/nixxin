{ pkgs, ... }: {
  programs = {
    command-not-found.enable = false;

    # droidcam.enable = true; # camera
    mtr.enable = true;
    fuse.userAllowOther = true;

    gnupg.agent.enable = true;
    gnupg.agent.enableSSHSupport = true;

    # required by libreoffice
    # java.enable = true;
  };
}
