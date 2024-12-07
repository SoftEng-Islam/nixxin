{ pkgs, ... }: {
  programs = {
    zsh = {
      enable = true;
      ohMyZsh.enable = true;
      enableGlobalCompInit = true;
      interactiveShellInit = ''
        source ${pkgs.zsh-nix-shell}/share/zsh-nix-shell/nix-shell.plugin.zsh
      '';
    };
  };
  environment.systemPackages = with pkgs; [
    fzf-zsh # wrap fzf to use in oh-my-zsh
    oh-my-zsh # A framework for managing your zsh configuration
    zsh # The Z shell
    zsh-autocomplete # Real-time type-ahead completion for Zsh. Asynchronous find-as-you-type autocompletion
    zsh-autosuggestions # Fish shell autosuggestions for Zsh
    zsh-completions # Additional completion definitions for zsh
    zsh-fzf-tab # Replace zsh's default completion selection menu with fzf!
    zsh-git-prompt # Informative git prompt for zsh
    zsh-syntax-highlighting # Fish shell like syntax highlighting for Zsh
  ];
}
