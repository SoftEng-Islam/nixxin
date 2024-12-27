{ inputs, mySettings, ... }: {
  imports = [
    inputs.xremap-flake.nixosModules.default

  ];
  users.users.root.password = "1122";
  users.users.${mySettings.username} = {
    password = "1122";
    isNormalUser = true;
  };
  services.xremap = {
    # NOTE: since this sample configuration does not have any DE, xremap needs to be started manually by systemctl --user start xremap
    serviceMode = "user";
    userName = mySettings.username;
  };

  # Modmap for single key rebinds
  services.xremap.config.modmap = [{
    name = "Global";
    remap = { "SUPER_L-q" = "Esc"; }; # globally remap CapsLock to Esc
  }];

  # Keymap for key combo rebinds
  services.xremap.config.keymap = [{
    name = "Example ctrl-u > pageup rebind";
    remap = { "C-u" = "PAGEUP"; };
  }];

}
