{
  programs = {
    corectrl.enable = true;
    corectrl.gpuOverclock.enable = true;
    corectrl.gpuOverclock.ppfeaturemask = "0xffffffff";
    dconf.enable = true; # dconf
    droidcam.enable = true; # camera
    mtr.enable = true;
    xwayland.enable = false;
    htop = {
      enable = true;
      settings = { tree_view = 1; };
    };
    gnupg.agent = {
      enable = true;
      enableSSHSupport = true;
    };
  };
}
