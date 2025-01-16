{ settings, pkgs, ... }: {

  environment.systemPackages = with pkgs;
    [

    ];
  home-manager.users.${settings.username} = {

  };
}
