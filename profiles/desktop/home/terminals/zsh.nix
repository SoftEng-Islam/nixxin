{
  home-manager = {
    programs.zsh = {
      enable = true;
      dotDir = ".config/zsh";
      envExtra = ''
        ## misc

        # make word movement commands to stop at every character except:
        # WORDCHARS="*?_-.[]~=/&;!#$%^(){}<>"
        export WORDCHARS="_*"
      '';
      initExtraFirst = ''
        # Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
        # Initialization code that may require console input (password prompts, [y/n]
        # confirmations, etc.) must go above this block; everything else may go below.
        if [[ -r "''${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-''${(%):-%n}.zsh" ]]; then
          source "''${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-''${(%):-%n}.zsh"
        fi
      '';
      # initExtraBeforeCompInit = '' '';
      completionInit = ''
        ## zsh-autocomplete

        # Show nixxin in complete menu
        setopt GLOB_DOTS

        # Disable zsh-autocomplete key bindings
        zstyle ':autocomplete:key-bindings' enabled no

        # Increase zsh-autocomplete delay
        zstyle ':autocomplete:*' delay 0.1

        # Don't add spaces after accepting an option
        zstyle ':autocomplete:*' add-space ""

        source ${pkgs.zsh-autocomplete}/zsh-autocomplete.plugin.zsh

        ## zsh-defer

        source ${pkgs.zsh-defer}/zsh-defer.plugin.zsh
      '';

      initExtra = ''
        ## load our scripts
        source ~/nixxin/config.zsh
        source ~/nixxin/functions.zsh}
        function load_key_bindings() {
          source ~/nixxin/key-bindings-vi.zsh
        }

        ## zsh-notify
        zstyle ':notify:*' app-name zsh-notify
        zstyle ':notify:*' error-icon "gksu-root-terminal"
        zstyle ':notify:*' error-title "wow such #fail (#{time_elapsed}s)"
        zstyle ':notify:*' success-icon "terminal-tango"
        zstyle ':notify:*' success-title "very #success. wow (#{time_elapsed}s)"
        zstyle ':notify:*' disable-urgent yes

        # TODO: write wayland support
        # zsh-defer source ${inputs.zsh-notify}/notify.plugin.zsh

        ## zsh-autosuggestions
        export ZSH_AUTOSUGGEST_MANUAL_REBIND=true
        export ZSH_AUTOSUGGEST_STRATEGY=(history completion)
        export ZSH_AUTOSUGGEST_BUFFER_MAX_SIZE=20
        export ZSH_AUTOSUGGEST_ACCEPT_WIDGETS=()
        export ZSH_AUTOSUGGEST_PARTIAL_ACCEPT_WIDGETS=()

        source ${pkgs.zsh-autosuggestions}/share/zsh-autosuggestions/zsh-autosuggestions.zsh

        ## zsh-fsh
        # remove background from pasted text
        # source: https://github.com/zdharma-continuum/fast-syntax-highlighting/issues/25
        # docs: https://zsh.sourceforge.io/Doc/Release/Zsh-Line-Editor.html#Character-Highlighting
        zle_highlight=('paste:fg=white,bold')

        # HACK: set catppuccin theme for zsh-fast-syntax-highlighting
        FAST_WORK_DIR="${fshTheme}"
        source ${fshPlugin.src}/${fshPlugin.file}

        ## zsh-vi-mode

        function zvm_config() {
          # ZVM_VI_INSERT_ESCAPE_BINDKEY=^X
          ZVM_ESCAPE_KEYTIMEOUT=0
          ZVM_KEYTIMEOUT=0.2
          ZVM_VI_HIGHLIGHT_BACKGROUND=#45475A
          ZVM_VI_HIGHLIGHT_FOREGROUND=#cdd6f4
          ZVM_VI_SURROUND_BINDKEY=s-prefix
          ZVM_LINE_INIT_MODE=$ZVM_MODE_LAST
          ZVM_INSERT_MODE_CURSOR=$ZVM_CURSOR_BLINKING_BEAM
          ZVM_OPPEND_MODE_CURSOR=$ZVM_CURSOR_BLINKING_BLOCK
        }

        function zvm_after_init() {
          load_key_bindings

          # HACK: fix race condition where zsh-vi-mode overwrites fzf key-binding
          bindkey -M viins '^R' fzf-history-widget
        }

        source ${inputs.zsh-vi-mode}/zsh-vi-mode.plugin.zsh

        ## zsh-history-substring-search

        # https://github.com/zsh-users/zsh-history-substring-search
        # change the behavior of history-substring-search-up
        export HISTORY_SUBSTRING_SEARCH_PREFIXED="1"

        export HISTORY_SUBSTRING_SEARCH_ENSURE_UNIQUE=1
        export HISTORY_SUBSTRING_SEARCH_HIGHLIGHT_TIMEOUT=0.2
        export HISTORY_SUBSTRING_SEARCH_HIGHLIGHT_FOUND="bg=cyan,fg=16,bold"
        export HISTORY_SUBSTRING_SEARCH_HIGHLIGHT_NOT_FOUND="bg=red,fg=16,bold"

        source ${inputs.zsh-history-substring-search}/zsh-history-substring-search.zsh

        ## zsh-abbr

        function _zsh-abbr-start() {
          export ABBR_DEFAULT_BINDINGS=0

          source ${pkgs.zsh-abbr}/share/zsh-abbr/zsh-abbr.zsh

          bindkey -M viins " " abbr-expand-and-insert

          if [[ ! -e "$ABBR_USER_ABBREVIATIONS_FILE" || ! -s "$ABBR_USER_ABBREVIATIONS_FILE" ]]; then
            abbr import-aliases --quiet
            abbr erase --quiet sudo
            abbr erase --quiet nv
            abbr erase --quiet nvim
            abbr erase --quiet ls
            abbr erase --quiet la
            abbr erase --quiet lt
            abbr erase --quiet ll
            abbr erase --quiet lla
            abbr erase --quiet z
          fi
        }

        zsh-defer _zsh-abbr-start

        ## snippets

        source ${pkgs.oh-my-zsh}/share/oh-my-zsh/plugins/aliases/aliases.plugin.zsh
        source ${pkgs.oh-my-zsh}/share/oh-my-zsh/lib/clipboard.zsh
        source ${./nixxin/plugins/dirhistory.zsh}
        source ${inputs.fuzzy-sys}/fuzzy-sys.plugin.zsh
        source ${pkgs.zsh-nix-shell}/share/zsh-nix-shell/nix-shell.plugin.zsh

        ## completions

        zsh-defer source ${inputs.zsh-pnpm-shell-completion}/pnpm-shell-completion.plugin.zsh
        zsh-defer source ${pkgs.timewarrior}/share/bash-completion/completions/timew.bash
      '';
      enableCompletion = true;
      defaultKeymap = "emacs";
      history = {
        ignoreDups = false;
        expireDuplicatesFirst = true;
        extended = true;
        ignoreSpace = true;
        save = 1000000000;
        size = 1000000000;
        # Shares current history file between all sessions as soon as shell closes
        share = true;
        # TODO: add ignorePatterns
      };
      dirHashes = {
        nxc = "$HOME/nix-config";
        nxs = "/nix/store";
        dl = "$HOME/Downloads";
      };
    };
  };
}
