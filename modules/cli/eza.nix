{ settings, pkgs, ... }: {
  home-manager.users.${settings.user.username} = {
    programs.eza = { enable = true; };
  };
  environment.systemPackages = with pkgs;
    [
      eza # Modern, maintained replacement for ls
    ];
}
