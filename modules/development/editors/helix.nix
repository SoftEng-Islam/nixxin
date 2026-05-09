{ settings, ... }:
{
  # ----------------------------------- #
  # Helix: Post-modern modal text editor
  # ----------------------------------- #
  home-manager.users.${settings.user.username} = {
    programs.helix = {
      enable = settings.modules.development.editors.helix.enable or false;
    };
  };
}
