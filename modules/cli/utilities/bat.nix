{ settings, pkgs, ... }:
{
  # Bat, a substitute for cat.
  # https://github.com/sharkdp/bat
  # https://nix-community.github.io/home-manager/options.xhtml#opt-programs.bat.enable
  home-manager.users.${settings.user.username} = {
    programs.bat = {
      enable = true;
      extraPackages = with pkgs.bat-extras; [
        batdiff
        batman
        batwatch
      ];
      config = {
        map-syntax = [
          "*.jenkinsfile:Groovy"
          "*.props:Java Properties"
        ];
        pager = "less -FR";

        theme = "OneHalfDark";
      };
    };
  };
}
