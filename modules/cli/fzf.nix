{ settings, pkgs, ... }: {
  home-manager.users.${settings.user.username} = {
    programs.fzf = { enable = true; };
  };
  environment.systemPackages = with pkgs;
    [
      fzf # Command-line fuzzy finder written in Go
    ];
}
