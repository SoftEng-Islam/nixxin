{ settings, lib, pkgs, ... }:
let
  myAliases = {
    # Set-up icons for files/folders in terminal
    # ls = "eza -a --icons";
    ls = "eza --icons -l -T -L=1";
    l = "eza -lh --icons=auto"; # Long list with icons
    ll = "eza -al --icons";
    lt = "eza -a --tree --level=1 --icons";
    tree = "eza --tree";
    ld = "eza -lhD --icons=auto"; # Long list directories with icons
    # lt = "eza --icons=auto --tree";  # List folder as tree with icons
    ":q" = "exit";
    "q" = "exit";

    "gs" = "git status";
    "gb" = "git branch";
    "gch" = "git checkout";
    "gc" = "git commit";
    "ga" = "git add";
    "gr" = "git reset --soft HEAD~1";

    "del" = "gio trash";

    "nix-gc" = "nix-collect-garbage --delete-older-than 7d";

    # Handy change directory shortcuts
    ".." = "cd ..";
    "..." = "cd ../..";
    ".3" = "cd ../../..";
    ".4" = "cd ../../../..";
    ".5" = "cd ../../../../..";

    mkdir = "mkdir -p"; # Always mkdir a path
    open = "xdg-open";
    make = "make -j$(nproc)";
    ninja = "ninja -j$(nproc)";
    n = "ninja";
    c = "clear"; # Clear terminal
    tb = "nc termbin.com 9999";
    # Get the error messages from journalctl
    jctl = "journalctl -p 3 -xb";
    # Recent installed packages
    rip = "expac --timefmt='%Y-%m-%d %T' '%l	%n %v' | sort | tail -200 | nl";
    g = "git";
    grep = "grep --color";
    ip = "ip --color";
    # l = "eza -l";
    la = "eza -la";
    md = "mkdir -p";
    ppc = "powerprofilesctl";
    pf = "powerprofilesctl launch -p performance";

    us = "systemctl --user"; # mnemonic for user systemctl
    rs = "sudo systemctl"; # mnemonic for root systemctl
    cat = "bat";
  };

in {
  # enable zsh autocompletion for system packages (systemd, etc)
  # environment.pathsToLink = [ "/share/zsh" ];

  # Path to your oh-my-zsh installation.
  # nix build nixpkgs#oh-my-zsh --print-out-paths --no-link
  environment.variables.ZSH = "${pkgs.oh-my-zsh}/share/oh-my-zsh";

  environment.systemPackages = with pkgs; [ zsh-abbr zsh-completions ];

  # Set the default shell to Zsh
  environment.shells = [ pkgs.zsh ];
  users.defaultUserShell = pkgs.zsh;

  programs.zsh.enable = true;
  programs.zsh.autosuggestions.enable = true;
  programs.zsh.enableBashCompletion = true;
  programs.zsh.enableCompletion = true;
  programs.zsh.enableGlobalCompInit = true;
  programs.zsh.enableLsColors = true;
  programs.zsh.histFile = "$HOME/.zsh_history";
  programs.zsh.histSize = 3000;
  programs.zsh.interactiveShellInit = "";
  programs.zsh.loginShellInit = "";
  programs.zsh.ohMyZsh.enable = true;
  programs.zsh.ohMyZsh.plugins = [
    "colored-man-pages"
    "command-not-found"
    "fzf"
    "git"
    "sudo"
    "systemd"
    "tmux"
    "extract"

    # Prevent running pasted command
    "safe-paste"
  ];
  programs.zsh.ohMyZsh.cacheDir = "$HOME/.cache/oh-my-zsh";
  programs.zsh.ohMyZsh.preLoaded = "";
  # programs.zsh.ohMyZsh.theme = ""; # we will use starship

  programs.zsh.promptInit = ''
    eval "$(starship init zsh)"
  '';

  programs.zsh.syntaxHighlighting = {
    enable = true;
    patterns = { "rm -rf *" = "fg=black,bg=red"; };
    styles = { "alias" = "fg=magenta"; };
    highlighters = [ "main" "brackets" "pattern" ];
  };

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
      # export PATH=$HOME/bin:/usr/local/bin:$PATH
      # export PATH="$PATH:/home/softeng/.local/share/gem/ruby/3.3.0/bin"
      # export QT_QPA_PLATFORMTHEME=qt5ct

      export NIX_BUILD_SHELL=zsh

      # ------------------------ #
      # ------ User Theme ------ #
      # ------------------------ #
      # Load custom theme
      # source ${pkgs.oh-my-zsh}/share/oh-my-zsh/themes/theme.zsh-theme

      # Enable prompt substitution
      setopt prompt_subst

      # Set the Git prompt info using vcs_info
      autoload -Uz vcs_info
      precmd() { vcs_info }
      zstyle ':vcs_info:git:*' formats '(%b)' # Customize how Git branch info is shown
      zstyle ':vcs_info:git:*' actionformats '(%b|%a)'

      # Define the PROMPT
      # PROMPT=$'(%B%F{magenta}%n%f%b@%B%F{blue}%m%f%b)=> {%F{yellow}%~%f} ''${vcs_info_msg_0_} \n%F{green}$%f '
      # Define the RPROMPT (right prompt)
      # RPROMPT=$'%F{red}RPROMPT%f'
      # eval "$(starship init zsh)"

      [ $TERM = "dumb" ] && unsetopt zle && PS1='$ '
      bindkey '^P' history-beginning-search-backward
      bindkey '^N' history-beginning-search-forward

      # Which plugins would you like to load?
      # Standard plugins can be found in $ZSH/plugins/
      # Custom plugins may be added to $ZSH_CUSTOM/plugins/
      # Example format: plugins=(rails git textmate ruby lighthouse)
      # Add wisely, as too many plugins slow down shell startup.
      # plugins=(
        # git
        # fzf
        # extract
        # zsh-completions
        # zsh-autocomplete
        # zsh-autosuggestions
        # zsh-syntax-highlighting
        # zsh-history-substring-search
      # )

      # To get the package path
      # nix build nixpkgs#oh-my-zsh --print-out-paths --no-link
      # source ${pkgs.oh-my-zsh}/share/oh-my-zsh/oh-my-zsh.sh

      # ZSH AUTOCOMPLETE -> https://github.com/marlonrichert/zsh-autocomplete/blob/main/.zshrc
      zstyle ':autocomplete:*' list-lines 8
      zstyle ':autocomplete:history-search:*' list-lines 8
      zstyle ':autocomplete:history-incremental-search-*:*' list-lines 8
      zstyle ':autocomplete:*' insert-unambiguous yes


      # Optimized history settings
      # HISTFILE=~/.zsh_history
      # HISTSIZE=2500
      # SAVEHIST=2500
      # setopt appendhistory

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
      [ -s "/home/softeng/.bun/_bun" ] && source "/home/softeng/.bun/_bun"

      # Set-up FZF key bindings (CTRL R for fuzzy history finder)
      # source <(fzf --zsh)
      source ${pkgs.fzf}/share/fzf/key-bindings.zsh
      # Fuzzy search in history as you type
      function fzf-history-widget {
        LBUFFER=$(history -n 1 | fzf --height 50% --layout=reverse --border --query="$LBUFFER" --prompt="History > ")
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
      # Uncomment the following line if pasting URLs and other text is messed up.
      DISABLE_MAGIC_FUNCTIONS="true"
      # Uncomment the following line to enable command auto-correction.
      ENABLE_CORRECTION="false"

      # Uncomment the following line to display red dots whilst waiting for completion.
      # You can also set it to another string to have that shown instead of the default red dots.
      # e.g. COMPLETION_WAITING_DOTS="%F{yellow}waiting...%f"
      # Caution: this setting can cause issues with multiline prompts in zsh < 5.7.1 (see #5765)
      COMPLETION_WAITING_DOTS="false"

      # Uncomment the following line if you want to disable marking untracked files
      # under VCS as dirty. This makes repository status check for large repositories
      # much, much faster.
      DISABLE_UNTRACKED_FILES_DIRTY="true"


      # Make new shells get the history lines from all previous
      # shells instead of the default "last window closed" history.
      # export PROMPT_COMMAND="history -a; $PROMPT_COMMAND"

      # The following line to use case-sensitive completion.
      CASE_SENSITIVE="true"
      # Uncomment the following line to use hyphen-insensitive completion.
      # Case-sensitive completion must be off. _ and - will be interchangeable.
      HYPHEN_INSENSITIVE="true"

      # Uncomment one of the following lines to change the auto-update behavior
      # zstyle ':omz:update' mode disabled  # disable automatic updates
      zstyle ':omz:update' mode auto      # update automatically without asking
      # zstyle ':omz:update' mode reminder  # just remind me to update when it's time

      # Uncomment the following line to disable colors in ls.
      DISABLE_LS_COLORS="false"

      # Uncomment the following line to disable auto-setting terminal title.
      DISABLE_AUTO_TITLE="false"

      # # Uncomment the following line if you want to change the command execution time
      # # stamp shown in the history command output.
      # # You can set one of the optional three formats:
      # # "mm/dd/yyyy"|"dd.mm.yyyy"|"yyyy-mm-dd"
      # # or set a custom format using the strftime function format specifications,
      # # see 'man strftime' for details.
      # # HIST_STAMPS="mm/dd/yyyy"

      # Preferred editor for local and remote sessions
      # if [[ -n $SSH_CONNECTION ]]; then
      #   export EDITOR='vim'
      # else
      #   export EDITOR='nvim'
      # fi


      # ----------------------------- #
      # -------- Set Aliases -------- #
      # ----------------------------- #
      # Set personal aliases, overriding those provided by oh-my-zsh libs,
      # plugins, and themes. Aliases can be placed here, though oh-my-zsh
      # users are encouraged to define aliases within the ZSH_CUSTOM folder.
      # Set-up icons for files/folders in terminal
      alias l='eza -lh --icons=auto'  # Long list with icons
      alias ls='eza -a --icons'
      alias ll='eza -al --icons'
      alias lt='eza -a --tree --level=1 --icons'
      alias ld='eza -lhD --icons=auto'  # Long list directories with icons
      alias lt='eza --icons=auto --tree'  # List folder as tree with icons

      # Handy change directory shortcuts
      alias ..='cd ..'
      alias ...='cd ../..'
      alias .3='cd ../../..'
      alias .4='cd ../../../..'
      alias .5='cd ../../../../..'

      alias mkdir='mkdir -p' # Always mkdir a path
      alias open="xdg-open"
      alias make="make -j$(nproc)"
      alias ninja="ninja -j$(nproc)"
      alias n="ninja"
      alias c="clear" # Clear terminal
      alias tb="nc termbin.com 9999"
      # Get the error messages from journalctl
      alias jctl="journalctl -p 3 -xb"
      # Recent installed packages
      alias rip="expac --timefmt='%Y-%m-%d %T' '%l\t%n %v' | sort | tail -200 | nl"
      # To Update The System
      # update = "sudo nixos-rebuild switch --flake /etc/nixos/#default";
      alias nano="micro" # Use micro as the default editor
      alias reboot="sudo reboot"
      alias nixclean="sudo nix-collect-garbage --delete-older-than 1d"
      alias trans="trans -no-bidi"

      # ------------------------- #
      # -------- Plugins -------- #
      # ------------------------- #
      # Fish-like syntax highlighting and autosuggestions
      source ${pkgs.zsh-syntax-highlighting}/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
      source ${pkgs.zsh-autosuggestions}/share/zsh-autosuggestions/zsh-autosuggestions.zsh
      # Use history substring search
      source ${pkgs.zsh-history-substring-search}/share/zsh-history-substring-search/zsh-history-substring-search.zsh
      # pkgfile "command not found" handler
      # source /usr/share/doc/pkgfile/command-not-found.zsh

      # --------------------------------- #
      # Zsh-autosuggestions configuration #
      # --------------------------------- #
      ZSH_AUTOSUGGEST_STRATEGY=(history completion)
      ZSH_AUTOSUGGEST_USE_FZF=true

      # Enable Wayland support for different apps
      # if [ "$XDG_SESSION_TYPE" = "wayland" ]; then
      #   export WAYLAND=1
      #   export QT_QPA_PLATFORM='wayland'
      #   export GDK_BACKEND='wayland'
      #   export MOZ_DBUS_REMOTE=1
      #   export MOZ_ENABLE_WAYLAND=1
      #   export _JAVA_AWT_WM_NONREPARENTING=1
      #   export BEMENU_BACKEND=wayland
      #   export CLUTTER_BACKEND=wayland
      #   export ECORE_EVAS_ENGINE=wayland_egl
      #   export ELM_ENGINE=wayland_egl
      # fi

      export FZF_BASE=/usr/share/fzf

      # ----------------------- #
      # Configuration For NixOS #
      # ----------------------- #
      # if ! grep -q "nix" /etc/os-release; then
      #   Write Your nixos configs Here
      # fi

      # Created by `pipx` on 2024-11-07 21:19:31
      export PATH="$PATH:/home/softeng/.local/bin"

      # zprof
    '';
  };
}
