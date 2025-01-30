{ settings, pkgs, ... }: {
  # ----------------------------------- #
  # Helix: Post-modern modal text editor
  # ----------------------------------- #
  home-manager.users.${settings.users.selected.username} = {
    programs.helix = { enable = true; };
  };
}
