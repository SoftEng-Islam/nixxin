{ settings, lib, pkgs, ... }: {
  environment.systemPackages = with pkgs; [ emacs emacs-all-the-icons-fonts ];
}
