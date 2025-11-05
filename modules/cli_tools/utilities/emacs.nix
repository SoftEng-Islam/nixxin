{ settings, lib, pkgs, ... }:
lib.mkIf (settings.modules.cli_tools.utilities.emacs.enable or false) {
  services.emacs.enable = true;
  services.emacs.install = true;
  services.emacs.package = pkgs.emacs;
  services.emacs.defaultEditor = false;

  # home-manager.users.${settings.user.username} = {
  #   programs.emacs = {
  #     enable = true;
  #     extraPackages = with pkgs; [
  #       emacs-all-the-icons-fonts
  #       emacs-gtk
  #       emacs-lsp-booster
  #     ];
  #     config = {
  #       # Add your Emacs configuration here
  #       # For example, you can set the theme, keybindings, etc.
  #     };
  #   };
  # };

  environment.systemPackages = with pkgs; [
    emacs
    emacs-all-the-icons-fonts
    emacs-gtk
    emacs-lsp-booster
  ];
}
