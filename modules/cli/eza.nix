{ settings, pkgs, ... }: {
  home-manager.users.${settings.users.selected.username} = {
    programs.eza = { enable = true; };
  };
  environment.systemPackages = with pkgs;
    [
      eza # Modern, maintained replacement for ls
    ];
}
