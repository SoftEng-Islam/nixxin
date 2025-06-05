{ settings, pkgs, ... }: {
  # ----------------------------------- #
  # Helix: Post-modern modal text editor
  # ----------------------------------- #
  home-manager.users.${settings.user.username} = {
    programs.helix = { enable = true; };
  };
}
