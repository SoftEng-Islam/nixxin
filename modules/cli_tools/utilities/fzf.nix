{ settings, pkgs, ... }: {
  home-manager.users.${settings.user.username} = {
    programs.fzf = { enable = true; };
  };
  environment.variables."FZF_BASE" = "${pkgs.fzf}/share/fzf";
  environment.systemPackages = with pkgs;
    [
      fzf # Command-line fuzzy finder written in Go
    ];
}
