{ settings, ... }:
{
  programs.fish = {
    enable = settings.modules.cli.shells.fish.enable or false;
    shellAliases = {
      g = "git";
      "..." = "cd ../..";
    };
    shellAbbrs = {
      gco = "git checkout";
      gs = "git status";
      jjs = "jj status";
    };
  };
}
