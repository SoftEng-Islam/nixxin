{ pkgs, ... }: {
  programs = {
    zsh = {
      enable = true;
      autosuggestions.async = true;
      autosuggestions.enable = true;
      enableBashCompletion = true;
      enableCompletion = true;
      enableGlobalCompInit = true;
      ohMyZsh.enable = true;
      zsh-autoenv.enable = true;
      # autosuggestions.strategy = ;
      interactiveShellInit = ''
        source ${pkgs.zsh-nix-shell}/share/zsh-nix-shell/nix-shell.plugin.zsh
      '';
    };
  };
  environment.systemPackages = with pkgs; [
    zsh-better-npm-completion
    zsh-abbr
    zsh-fzf-tab
    zsh-autopair
    zsh-autoenv
    fzf-zsh # wrap fzf to use in oh-my-zsh
    oh-my-zsh # A framework for managing your zsh configuration
    zsh # The Z shell
    zsh-autocomplete # Real-time type-ahead completion for Zsh. Asynchronous find-as-you-type autocompletion
    zsh-autosuggestions # Fish shell autosuggestions for Zsh
    zsh-completions # Additional completion definitions for zsh
    zsh-fzf-tab # Replace zsh's default completion selection menu with fzf!
    zsh-git-prompt # Informative git prompt for zsh
    zsh-syntax-highlighting # Fish shell like syntax highlighting for Zsh
    # zsh-fast-syntax-highlighting
    zsh-f-sy-h
  ];
}
