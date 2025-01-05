{ settings, pkgs, ... }: {
  # enable zsh autocompletion for system packages (systemd, etc)
  environment.pathsToLink = [ "/share/zsh" ];

  programs.zsh = {
    enable = true;
    enableCompletion = true;
    autosuggestions.enable = true;
    # we'll call compinit in home-manager zsh module
    enableGlobalCompInit = false;
    promptInit = "";
    # prefer to use home-manager dircolors module
    enableLsColors = false;
    syntaxHighlighting = {
      enable = true;
      patterns = { "rm -rf *" = "fg=black,bg=red"; };
      styles = { "alias" = "fg=magenta"; };
      highlighters = [ "main" "brackets" "pattern" ];
    };
  };
  environment.systemPackages = with pkgs; [
    # completions and manpage install
    zsh-abbr
    # completions
    zsh-completions
  ];
  home-manager.users.${settings.username}.home.file.".zshrc".text = ''
    # If you come from bash you might have to change your $PATH.
    export PATH=$HOME/bin:/usr/local/bin:$PATH
    export PATH="$PATH:/home/softeng/.local/share/gem/ruby/3.3.0/bin"
    export QT_QPA_PLATFORMTHEME=qt5ct

    # You may need to manually set your language environment
    export LANG=en_US.UTF-8

    # Path to your oh-my-zsh installation.
    export ZSH="$HOME/.oh-my-zsh"

    # ------------------------ #
    # ------ User Theme ------ #
    # ------------------------ #
    # Load custom theme
    # source ~/.oh-my-zsh/themes/theme.zsh-theme

    # Enable prompt substitution
    setopt prompt_subst

    # Set the Git prompt info using vcs_info
    autoload -Uz vcs_info
    precmd() { vcs_info }
    zstyle ':vcs_info:git:*' formats '(%b)' # Customize how Git branch info is shown
    zstyle ':vcs_info:git:*' actionformats '(%b|%a)'

    # Define the PROMPT
    PROMPT=$'[%B%F{magenta}%n%f%b@%B%F{blue}%m%f%b]=> (%F{yellow}%~%f) ''${vcs_info_msg_0_} \n%F{green}$%f '
    # Define the RPROMPT (right prompt)
    # RPROMPT=$'%F{red}RPROMPT%f'

    [ $TERM = "dumb" ] && unsetopt zle && PS1='$ '
    bindkey '^P' history-beginning-search-backward
    bindkey '^N' history-beginning-search-forward


    # Which plugins would you like to load?
    # Standard plugins can be found in $ZSH/plugins/
    # Custom plugins may be added to $ZSH_CUSTOM/plugins/
    # Example format: plugins=(rails git textmate ruby lighthouse)
    # Add wisely, as too many plugins slow down shell startup.
    plugins=(
      git
      fzf
      extract
      # zsh-completions
      # zsh-autocomplete
      # zsh-autosuggestions
      # zsh-syntax-highlighting
      # zsh-history-substring-search
    )
    source $ZSH/oh-my-zsh.sh

    # Optimized history settings
    HISTFILE=~/.zsh_history
    HISTSIZE=2500
    SAVEHIST=2500
    setopt appendhistory

    # -- pnpm --
    export PNPM_HOME="/home/softeng/.local/share/pnpm"
    case ":$PATH:" in
    *":$PNPM_HOME:"*) ;;
    *) export PATH="$PNPM_HOME:$PATH" ;;
    esac
    # -- pnpm end --

    # -- nvm --
    export NVM_DIR="$HOME/.nvm"
    [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
    [ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
    # -- nvm end --

    # bun completions
    [ -s "/home/softeng/.bun/_bun" ] && source "/home/softeng/.bun/_bun"
    # -- bun --
    export BUN_INSTALL="$HOME/.bun"
    export PATH="$BUN_INSTALL/bin:$PATH"
    # -- bun end --

    # Set-up FZF key bindings (CTRL R for fuzzy history finder)
    source <(fzf --zsh)
    # Fuzzy search in history as you type
    function fzf-history-widget {
      LBUFFER=$(history -n 1 | fzf --height 50% --layout=reverse --border --query="$LBUFFER" --prompt="History > ")
      zle redisplay
    }
    # Keybindings
    # bindkey -e  # Use emacs mode (default)
    zle -N fzf-history-widget
    # bindkey '^P' fzf-history-widget  # Bind Ctrl+P to trigger fzf history search


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
    COMPLETION_WAITING_DOTS="true"

    # Uncomment the following line if you want to disable marking untracked files
    # under VCS as dirty. This makes repository status check for large repositories
    # much, much faster.
    DISABLE_UNTRACKED_FILES_DIRTY="true"

    # Ignore commands that start with spaces and duplicates.
    export HISTCONTROL=ignoreboth

    # Don't add certain commands to the history file.
    export HISTIGNORE="&:[bf]g:c:clear:history:exit:q:pwd:* --help"

    # Use custom `less` colors for `man` pages.
    export LESS_TERMCAP_md="$(
      tput bold 2>/dev/null
      tput setaf 2 2>/dev/null
    )"
    export LESS_TERMCAP_me="$(tput sgr0 2>/dev/null)"

    # Make new shells get the history lines from all previous
    # shells instead of the default "last window closed" history.
    export PROMPT_COMMAND="history -a; $PROMPT_COMMAND"

    # The following line to use case-sensitive completion.
    CASE_SENSITIVE="false"
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
    if [[ -n $SSH_CONNECTION ]]; then
      export EDITOR='vim'
    else
      export EDITOR='nvim'
    fi


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

    # ------------------------- #
    # -------- Plugins -------- #
    # ------------------------- #
    # Fish-like syntax highlighting and autosuggestions
    source /home/softeng/.oh-my-zsh/custom/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
    source /home/softeng/.oh-my-zsh/custom/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh
    # Use history substring search
    source /home/softeng/.oh-my-zsh/custom/plugins/zsh-history-substring-search/zsh-history-substring-search.zsh
    # pkgfile "command not found" handler
    # source /usr/share/doc/pkgfile/command-not-found.zsh

    # --------------------------------- #
    # Zsh-autosuggestions configuration #
    # --------------------------------- #
    ZSH_AUTOSUGGEST_STRATEGY=(history completion)
    ZSH_AUTOSUGGEST_USE_FZF=true

    # Enable Wayland support for different applications
    if [ "$XDG_SESSION_TYPE" = "wayland" ]; then
      export WAYLAND=1
      export QT_QPA_PLATFORM='wayland'
      export GDK_BACKEND='wayland'
      export MOZ_DBUS_REMOTE=1
      export MOZ_ENABLE_WAYLAND=1
      export _JAVA_AWT_WM_NONREPARENTING=1
      export BEMENU_BACKEND=wayland
      export CLUTTER_BACKEND=wayland
      export ECORE_EVAS_ENGINE=wayland_egl
      export ELM_ENGINE=wayland_egl
    fi

    export FZF_BASE=/usr/share/fzf

    # ----------------------- #
    # Configuration for NixOS #
    # ----------------------- #
    if ! grep -q "nix" /etc/os-release; then
      # NIXOS configs
    fi
    # Created by `pipx` on 2024-11-07 21:19:31
    export PATH="$PATH:/home/softeng/.local/bin"

  '';
}
