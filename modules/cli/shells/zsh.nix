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

    # Quieter ffmpeg output (hide banner + suppress SVT-AV1 encoder info spam).
    # Use `command ffmpeg ...` if you need the full logs.
    ffmpeg = "SVT_LOG=0 ffmpeg -hide_banner -loglevel warning -stats";
  };

in
{
  # Enable zsh autocompletion for system packages (systemd, etc)
  # environment.pathsToLink = [ "/share/zsh" ];

  # Path to your oh-my-zsh installation.
  # nix build nixpkgs#oh-my-zsh --print-out-paths --no-link
  environment.variables.ZSH = "${pkgs.oh-my-zsh}/share/oh-my-zsh";

  environment.systemPackages = with pkgs; [
    zsh-completions
  ];

  home-manager.users.${settings.user.username} = {
    programs.zsh = {
      enable = true;
      enableCompletion = true;
      shellAliases = myAliases;
      history = {
        path = "${HOME}/zsh/zhistory";
        save = 10000;
        size = 10000;
        expireDuplicatesFirst = true;
        ignoreAllDups = true;
        share = true;
      };
      initExtra = lib.mkAfter ''
        [ $TERM = "dumb" ] && unsetopt zle && PS1='$ '
        bindkey '^P' history-beginning-search-backward
        bindkey '^N' history-beginning-search-forward

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

        # ------------------------- #
        # -------- Plugins -------- #
        # ------------------------- #
        # Use history substring search
        source ${pkgs.zsh-history-substring-search}/share/zsh-history-substring-search/zsh-history-substring-search.zsh
        bindkey '^[[A' history-substring-search-up
        bindkey '^[[B' history-substring-search-down

        # Fish-like autosuggestions
        source ${pkgs.zsh-autosuggestions}/share/zsh-autosuggestions/zsh-autosuggestions.zsh
        ZSH_AUTOSUGGEST_STRATEGY=(history completion)
        ZSH_AUTOSUGGEST_USE_FZF=true
        ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE="fg=8"

        # Fish-like syntax highlighting (load last)
        source ${pkgs.zsh-syntax-highlighting}/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
        ZSH_HIGHLIGHT_HIGHLIGHTERS=(main brackets pattern)
        ZSH_HIGHLIGHT_PATTERNS+=('rm -rf *' 'fg=black,bg=red')
        ZSH_HIGHLIGHT_STYLES[alias]='fg=magenta'
      '';
    };

    # ohMyZsh
    programs.zsh.ohMyZsh.enable = true;
    programs.zsh.ohMyZsh.cacheDir = "${HOME}/.cache/oh-my-zsh";
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
  };
}
