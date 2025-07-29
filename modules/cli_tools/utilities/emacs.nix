{ settings, pkgs, ... }: {
  home-manager.users.${settings.user.username} = {
    programs.emacs = { enable = true; };
  };
  environment.systemPackages = with pkgs; [
    emacs
    emacs-all-the-icons-fonts
    emacs-gtk
    emacs-lsp-booster
  ];
}
