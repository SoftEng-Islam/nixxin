{ settings, pkgs, ... }: {
  environment.systemPackages = with pkgs; [ wezterm ];
  home-manager.users.${settings.users.selected.username} = {
    programs.wezterm = {
      enable = true;
      enableZshIntegration = true;
      enableBashIntegration = true;
      # extraConfig = ''  '';
    };
  };
}
