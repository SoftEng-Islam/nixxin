{ inputs, settings, ... }: {
  imports = [ inputs.xremap-flake.nixosModules.default ];
  users.users.root.password = "1122";
  users.users.${settings.user.username} = {
    password = "1122";
    isNormalUser = true;
  };
  services.xremap = {
    # NOTE: since this sample configuration does not have any DE, xremap needs to be started manually by systemctl --user start xremap
    withHypr = true;
    serviceMode = "user";
    userName = settings.user.username;
    # Modmap for single key rebinds
    config = {
      keymap = [{
        name = "vscode";
        remap.SUPER-c = { launch = [ "code" ]; };
      }];
      modmap = [{
        name = "Global";
        remap = { "SUPER_L-q" = "Esc"; }; # globally remap CapsLock to Esc
      }];
    };
  };
}
