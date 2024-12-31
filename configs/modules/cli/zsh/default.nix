{ pkgs, ... }: {
  programs.zsh = {
    enable = true;
    enableCompletion = true;

    # we'll call compinit in home-manager zsh module
    enableGlobalCompInit = false;
    promptInit = "";

    # prefer to use home-manager dircolors module
    enableLsColors = false;
  };
  environment.systemPackages = with pkgs; [
    # completions and manpage install
    zsh-abbr

    # completions
    zsh-completions
  ];

}
