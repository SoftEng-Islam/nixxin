{ settings, pkgs, ... }: {
  environment.systemPackages = with pkgs; [ vscode ];
  home-manager.users.${settings.users.user1.username} = {
    programs.vscode = {
      enable = true;
      extensions = [ ];
      userSettings = {

      };
    };
  };
}
