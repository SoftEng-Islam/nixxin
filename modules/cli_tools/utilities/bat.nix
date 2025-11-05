{ settings, lib, pkgs, ... }: {
  home-manager.users.${settings.user.username} = {
    programs.bat = {
      enable = settings.modules.cli_tools.utilities.bat.enable or true;
      extraPackages = with pkgs.bat-extras; [ batdiff batman batwatch ];
      config = {
        map-syntax = [ "*.jenkinsfile:Groovy" "*.props:Java Properties" ];
        pager = "less -FR";
        theme = "TwoDark";
      };
      # syntaxes = { };
      # themes = { };
    };
  };
}
