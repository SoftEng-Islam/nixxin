{
  settings,
  lib,
  pkgs,
  ...
}:
let
  HOME = settings.HOME;
  myAliases = {
    # ----------------------------- #
    # -------- Set Aliases -------- #
    # ----------------------------- #
    # Set personal aliases, overriding those provided by oh-my-zsh libs,
    # plugins, and themes. Aliases can be placed here, though oh-my-zsh
    # users are encouraged to define aliases within the ZSH_CUSTOM folder.

    # Set-up icons for files/folders in terminal
    l = "eza -lh --icons=auto"; # Long list with icons
    la = "eza -la";
    ls = "eza --icons -l -T -L=1";
    ll = "eza -al --icons";
    lt = "eza -a --tree --level=1 --icons"; # List folder as tree with icons
    ld = "eza -lhD --icons=auto"; # Long list directories with icons
    tree = "eza --tree";

    # Handy change directory shortcuts
    ".." = "cd ..";
    "..." = "cd ../..";
    ".3" = "cd ../../..";
    ".4" = "cd ../../../..";
    ".5" = "cd ../../../../..";

    mkdir = "mkdir -p"; # Always mkdir a path
    open = "xdg-open";
    c = "clear"; # Clear terminal
    jctl = "journalctl -p 3"; # Get the error messages from journalctl
    grep = "grep --color";
    ppc = "powerprofilesctl list";
    pf = "powerprofilesctl set performance";
    us = "systemctl --user"; # mnemonic for user systemctl
    rs = "sudo systemctl"; # mnemonic for root systemctl
    cat = "bat";
    nano = "micro"; # Use micro as the default editor
    reboot = "sudo reboot";
    nixclean = "sudo nix-collect-garbage --delete-older-than 1d";

    # To Translate from Language to Other.
    trans = "trans -no-bidi";

    nix-shell = "nix-shell --run zsh";
  };

in
{
  # enable zsh autocompletion for system packages (systemd, etc)
  # environment.pathsToLink = [ "/share/zsh" ];

  # Path to your oh-my-zsh installation.
  # nix build nixpkgs#oh-my-zsh --print-out-paths --no-link
  environment.variables.ZSH = "${pkgs.oh-my-zsh}/share/oh-my-zsh";

  environment.systemPackages = with pkgs; [
    zsh-abbr
    zsh-completions
  ];

  # Set the default shell to Zsh
  environment.shells = [ pkgs.zsh ];
  users.defaultUserShell = pkgs.zsh;

  programs.zsh.enable = true;
  # Prefer to configure plugin load-order in ~/.zshrc for interactive shells.
  programs.zsh.autosuggestions.enable = false;
  programs.zsh.enableBashCompletion = true;
  programs.zsh.enableCompletion = true;
  programs.zsh.enableGlobalCompInit = true;
  programs.zsh.enableLsColors = true;
  programs.zsh.histFile = "${HOME}/.zsh_history";
  programs.zsh.histSize = 3000;
  programs.zsh.interactiveShellInit = "";
  programs.zsh.loginShellInit = "";
  programs.zsh.ohMyZsh.enable = true;
  programs.zsh.shellAliases = myAliases;
  programs.zsh.ohMyZsh.plugins = [
    "colored-man-pages"
    "fzf"
    "git"
    "sudo"
    "systemd"
    "tmux"
    "extract"

    # Prevent running pasted command
    "safe-paste"
  ];
  programs.zsh.ohMyZsh.cacheDir = "${HOME}/.cache/oh-my-zsh";
  programs.zsh.ohMyZsh.preLoaded = ''
    # If you see compaudit warnings due to the Nix store / system profile, this
    # avoids the interactive prompt and speeds startup.
    ZSH_DISABLE_COMPFIX=true

    # OMZ behavior toggles
    DISABLE_MAGIC_FUNCTIONS="false"
    ENABLE_CORRECTION="false"
    DISABLE_UNTRACKED_FILES_DIRTY="true"

    # Completion behavior
    CASE_SENSITIVE="false"
    HYPHEN_INSENSITIVE="true"

    # Never auto-update (Nix store is immutable)
    zstyle ':omz:update' mode disabled
  '';
  # programs.zsh.ohMyZsh.theme = ""; # we will use starship

  programs.zsh.promptInit = ''
    eval "$(starship init zsh)"
  '';

  programs.zsh.syntaxHighlighting.enable = false;

  home-manager.users.${settings.user.username} = {
    # programs.zsh = {
    #   initContent = lib.mkOrder 1000 ''
    #     [[ ! $(command -v nix) && -e "/nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh" ]] && source "/nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh"
    #   '';
    # };
    home.file.".zshrc".text = ''
      # zmodload zsh/zprof

      # [[ ! $(command -v nix) && -e "/nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh" ]] && source "/nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh"
      # If you come from bash you might have to change your $PATH.
      # export PATH=${HOME}/bin:/usr/local/bin:$PATH
      # export PATH="$PATH:/home/softeng/.local/share/gem/ruby/3.3.0/bin"


      # ------------------------ #
      # ------ User Theme ------ #
      # ------------------------ #
      # Load custom theme
      # source ${pkgs.oh-my-zsh}/share/oh-my-zsh/themes/theme.zsh-theme

      # Enable prompt substitution
      setopt prompt_subst

      # Define the PROMPT
      # PROMPT=$'(%B%F{magenta}%n%f%b@%B%F{blue}%m%f%b)=> {%F{yellow}%~%f} ''${vcs_info_msg_0_} \n%F{green}$%f '
      # Define the RPROMPT (right prompt)
      # RPROMPT=$'%F{red}RPROMPT%f'
      # eval "$(starship init zsh)"

      [ $TERM = "dumb" ] && unsetopt zle && PS1='$ '
      bindkey '^P' history-beginning-search-backward
      bindkey '^N' history-beginning-search-forward

      # ZSH AUTOCOMPLETE -> https://github.com/marlonrichert/zsh-autocomplete/blob/main/.zshrc
      zstyle ':autocomplete:*' list-lines 8
      zstyle ':autocomplete:history-search:*' list-lines 8
      zstyle ':autocomplete:history-incremental-search-*:*' list-lines 8
      zstyle ':autocomplete:*' insert-unambiguous yes

      # Disable mouse tracking in Zsh Autocomplete
      # (This stops the mouse from moving the cursor and taking over terminal scroll)
      zstyle ':autocomplete:*' min-input 0
      zstyle ':autocomplete:*' enable-mouse false
      unset ZSH_AUTOSUGGEST_USE_FZF

      # Enable zsh-autocomplete
      source ${pkgs.zsh-autocomplete}/share/zsh-autocomplete/zsh-autocomplete.plugin.zsh

      # Remove all duplicates in history
      setopt HIST_IGNORE_ALL_DUPS    # Remove older duplicate entries when a new one is added
      setopt HIST_SAVE_NO_DUPS       # Don't write duplicate entries to the history file
      setopt HIST_REDUCE_BLANKS      # Remove superfluous blanks from each command line being added

      setopt AUTO_CD
      setopt AUTO_PUSHD
      setopt PUSHD_IGNORE_DUPS
      setopt EXTENDED_HISTORY
      setopt SHARE_HISTORY
      setopt HIST_EXPIRE_DUPS_FIRST
      setopt HIST_IGNORE_DUPS
      setopt HIST_IGNORE_SPACE
      setopt HIST_VERIFY
      setopt INTERACTIVE_COMMENTS

      # -- nvm --
      [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
      [ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
      # -- nvm end --

      # bun completions
      [ -s "${HOME}/.bun/_bun" ] && source "${HOME}/.bun/_bun"

      # Set-up FZF key bindings (CTRL R for fuzzy history finder)
      # source <(fzf --zsh)
      source ${pkgs.fzf}/share/fzf/key-bindings.zsh
      # Fuzzy search in history as you type
      function fzf-history-widget {
        local selected
        selected="$(fc -rl 1 | fzf --height 50% --layout=reverse --border --query="$LBUFFER" --prompt="History > " | sed -E 's/^[[:space:]]*[0-9]+[[:space:]]+//')"
        [[ -n "$selected" ]] || return 0
        LBUFFER="$selected"
        zle redisplay
      }
      zle -N fzf-history-widget
      # bindkey '^H' fzf-history-widget  # Bind Ctrl+H to trigger fzf history search

      # Basic autocompletion
      # autoload -Uz compinit
      # compinit

      # ------------------------------------------ #
      # ----------- User configuration ----------- #
      # ------------------------------------------ #
      # Oh My Zsh options are configured in Nix (programs.zsh.ohMyZsh.preLoaded)
      # so they are applied before OMZ loads from /etc/zshrc.

      # Uncomment the following line if pasting URLs and other text is messed up.
      DISABLE_MAGIC_FUNCTIONS="false"
      # Uncomment the following line to enable command auto-correction.
      # ENABLE_CORRECTION="true"

      # Uncomment the following line to display red dots whilst waiting for completion.
      # You can also set it to another string to have that shown instead of the default red dots.
      # e.g. COMPLETION_WAITING_DOTS="%F{yellow}waiting...%f"
      # Caution: this setting can cause issues with multiline prompts in zsh < 5.7.1 (see #5765)
      # COMPLETION_WAITING_DOTS="%F{yellow}waiting...%f"

      # Make new shells get the history lines from all previous
      # shells instead of the default "last window closed" history.
      export PROMPT_COMMAND="history -a; $PROMPT_COMMAND"

      # Uncomment one of the following lines to change the auto-update behavior
      zstyle ':omz:update' mode disabled  # disable automatic updates
      # zstyle ':omz:update' mode auto      # update automatically without asking
      # zstyle ':omz:update' mode reminder  # just remind me to update when it's time


      # ------------------------- #
      # -------- Plugins -------- #
      # ------------------------- #
      # Use history substring search
      source ${pkgs.zsh-history-substring-search}/share/zsh-history-substring-search/zsh-history-substring-search.zsh
      bindkey '^[[A' history-substring-search-up
      bindkey '^[[B' history-substring-search-down

      # Optional: better completion UI
      # source ${pkgs.zsh-fzf-tab}/share/fzf-tab/fzf-tab.plugin.zsh

      # Abbreviations (fish-like)
      source ${pkgs.zsh-abbr}/share/zsh/zsh-abbr/zsh-abbr.plugin.zsh

      # Fish-like autosuggestions
      source ${pkgs.zsh-autosuggestions}/share/zsh-autosuggestions/zsh-autosuggestions.zsh


      # --------------------------------- #
      # Zsh-autosuggestions configuration #
      # --------------------------------- #
      ZSH_AUTOSUGGEST_STRATEGY=(history completion)
      ZSH_AUTOSUGGEST_USE_FZF=true
      ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE="fg=8"

      # Fish-like syntax highlighting (load last)
      source ${pkgs.zsh-syntax-highlighting}/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
      ZSH_HIGHLIGHT_HIGHLIGHTERS=(main brackets pattern)
      ZSH_HIGHLIGHT_PATTERNS+=('rm -rf *' 'fg=black,bg=red')
      ZSH_HIGHLIGHT_STYLES[alias]='fg=magenta'

      # Created by `pipx` on 2024-11-07 21:19:31
      export PATH="$PATH:${HOME}/.local/bin"

      # zprof
    '';
  };
}
