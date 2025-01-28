{ settings, pkgs, ... }: {
  # ----------------------------------- #
  # Helix: Post-modern modal text editor
  # ----------------------------------- #
  home-manager.users.${settings.users.user1.username} = {
    programs.helix = { enable = true; };
  };
}
