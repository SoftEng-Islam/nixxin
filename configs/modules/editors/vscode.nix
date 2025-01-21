{ settings, pkgs, ... }: {
  environment.systemPackages = with pkgs; [ vscode ];
  home-manager.users.${settings.username} = {
    programs.vscode = {
      enable = true;
      extensions = [ ];
    };
  };
}
