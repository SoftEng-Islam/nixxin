{
  programs.fish = {
    enable = true;
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
