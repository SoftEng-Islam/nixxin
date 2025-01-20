{ settings, pkgs, ... }: {
  # ----------------------------------- #
  # Helix: Post-modern modal text editor
  # ----------------------------------- #
  home-manager.users.${settings.username} = {
    programs.helix = { enable = true; };
  };
}
