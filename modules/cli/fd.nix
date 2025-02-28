{ settings, pkgs, ... }: {
  home-manager.users.${settings.user.username} = {
    programs.fd = { enable = true; };
  };
  environment.systemPackages = with pkgs;
    [
      fd # A simple, fast and user-friendly alternative to find
    ];
}
