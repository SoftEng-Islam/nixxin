{ settings, pkgs, ... }: {

  environment.systemPackages = with pkgs;
    [

    ];
  home-manager.users.${settings.users.user1.username} = {

  };
}
