{ settings, pkgs, ... }: {
  environment.systemPackages = with pkgs; [ vscode ];
  home-manager.users.${settings.users.selected.username} = {
    programs.vscode = {
      enable = true;
      extensions = [ ];
      userSettings = {

      };
    };
  };
}
