{ lib, config, pkgs, ... }:
let
  # My shell aliases
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
    cat = if config.programs.bat.enable then "bat" else "cat";

  } // lib.optionalAttrs config.programs.bat.enable { cat = "bat"; };
in {
  imports = [ ./starship.nix ];
  options.shellAliases = with lib;
    mkOption {
      type = types.attrsOf types.str;
      default = { };
    };
  networking.firewall.allowedTCPPortRanges = if config.enableWezterm then [{
    from = 60000;
    to = 60010;
  }] else
    [ ];

  programs = {
    bash = {
      enable = true;
      shellAliases = myAliases // config.shellAliases;
      initExtra = "SHELL=${pkgs.bash}";
    };
    nushell = {
      shellAliases = myAliases // config.shellAliases;
      enable = true;
      environmentVariables = {
        PROMPT_INDICATOR_VI_INSERT = "  ";
        PROMPT_INDICATOR_VI_NORMAL = "∙ ";
        PROMPT_COMMAND = "";
        PROMPT_COMMAND_RIGHT = "";
        NIXPKGS_ALLOW_UNFREE = "1";
        NIXPKGS_ALLOW_INSECURE = "1";
        SHELL = "${pkgs.nushell}/bin/nu";
        EDITOR = config.home.sessionVariables.EDITOR;
        VISUAL = config.home.sessionVariables.VISUAL;
      };
      extraConfig = let
        conf = builtins.toJSON {
          show_banner = false;
          edit_mode = "vi";

          ls.clickable_links = true;
          rm.always_trash = true;

          table = {
            mode = "compact"; # compact thin rounded
            index_mode = "always"; # alway never auto
            header_on_separator = false;
          };

          cursor_shape = {
            vi_insert = "line";
            vi_normal = "block";
          };

          display_errors = { exit_code = false; };

          menus = [{
            name = "completion_menu";
            only_buffer_difference = false;
            marker = "? ";
            type = {
              layout = "columnar"; # list, description
              columns = 4;
              col_padding = 2;
            };
            style = {
              text = "magenta";
              selected_text = "blue_reverse";
              description_text = "yellow";
            };
          }];
        };
        completions = let
          completion = name: ''
            source ${pkgs.nu_scripts}/share/nu_scripts/custom-completions/${name}/${name}-completions.nu
          '';
        in names:
        builtins.foldl' (prev: str: ''
          ${prev}
          ${str}'') "" (map completion names);
      in ''
        $env.config = ${conf};
        ${completions [ "cargo" "git" "nix" "npm" "poetry" "curl" ]}

        # alias pueue = ${pkgs.pueue}/bin/pueue
        # alias pueued = ${pkgs.pueue}/bin/pueued
        # use ${pkgs.nu_scripts}/share/nu_scripts/modules/background_task/task.nu
        source ${pkgs.nu_scripts}/share/nu_scripts/modules/formats/from-env.nu

        const path = "~/.nushellrc.nu"
        const null = "/dev/null"
        source (if ($path | path exists) {
            $path
        } else {
            $null
        })
      '';
    };
    zsh = {
      enable = true;
      autocd = true;
      autosuggestions.async = true;
      autosuggestions.enable = true;
      enableBashCompletion = true;
      enableCompletion = true;
      shellAliases = myAliases // config.shellAliases;
      shellGlobalAliases = { eza = "eza --icons --git"; };
      histFile = "~/.zsh_history";
      histSize = "3000";
      enableGlobalCompInit = true;
      ohMyZsh.enable = true;
      zsh-autoenv.enable = true;
      dirHashes = {
        dl = "$HOME/Downloads";
        docs = "$HOME/Documents";
        code = "$HOME/Documents/code";
        dots = "$HOME/Documents/code/dotfiles";
        pics = "$HOME/Pictures";
        vids = "$HOME/Videos";
        nixpkgs = "$HOME/Documents/code/git/nixpkgs";
      };
      dotDir = ".config/zsh";
      history = {
        expireDuplicatesFirst = true;
        path = "${config.xdg.dataHome}/zsh_history";
      };
      # autosuggestions.strategy = ["history"]; list of (one of "history", "completion", "match_prev_cmd")
      initExtra = ''
        SHELL=${pkgs.zsh}/bin/zsh
        PROMPT=" ◉ %U%F{magenta}%n%f%u@%U%F{blue}%m%f%u:%F{yellow}%~%f %F{green}→%f "
        RPROMPT="%F{red}▂%f%F{yellow}▄%f%F{green}▆%f%F{cyan}█%f%F{blue}▆%f%F{magenta}▄%f%F{white}▂%f"
        [ $TERM = "dumb" ] && unsetopt zle && PS1='$ '
        bindkey '^P' history-beginning-search-backward
        bindkey '^N' history-beginning-search-forward

        # search history based on what's typed in the prompt
        autoload -U history-search-end
        zle -N history-beginning-search-backward-end history-search-end
        zle -N history-beginning-search-forward-end history-search-end
        bindkey "^[OA" history-beginning-search-backward-end
        bindkey "^[OB" history-beginning-search-forward-end

        # C-right / C-left for word skips
        bindkey "^[[1;5C" forward-word
        bindkey "^[[1;5D" backward-word

        # C-Backspace / C-Delete for word deletions
        bindkey "^[[3;5~" forward-kill-word
        bindkey "^H" backward-kill-word

        # Home/End
        bindkey "^[[OH" beginning-of-line
        bindkey "^[[OF" end-of-line

        # open commands in $EDITOR with C-e
        autoload -z edit-command-line
        zle -N edit-command-line
        bindkey "^e" edit-command-line

        # case insensitive tab completion
        zstyle ':completion:*' completer _complete _ignored _approximate
        zstyle ':completion:*' list-prompt %SAt %p: Hit TAB for more, or the character to insert%s
        zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}'
        zstyle ':completion:*' menu select
        zstyle ':completion:*' select-prompt %SScrolling active: current selection at %p%s
        zstyle ':completion:*' verbose true

        # use cache for completions
        zstyle ':completion:*' use-cache on
        zstyle ':completion:*' cache-path "$XDG_CACHE_HOME/zsh/.zcompcache"
        _comp_options+=(globdots)
        unsetopt BEEP
        # Allow foot to pipe command output
        function precmd {
            if ! builtin zle; then
                print -n "\e]133;D\e\\"
            fi
        }

        function preexec {
            print -n "\e]133;C\e\\"
        }

        ${lib.optionalString config.services.gpg-agent.enable ''
          gnupg_path=$(ls $XDG_RUNTIME_DIR/gnupg)
          export SSH_AUTH_SOCK="$XDG_RUNTIME_DIR/gnupg/$gnupg_path/S.gpg-agent.ssh"
        ''}
      '';
      interactiveShellInit = ''
        source ${pkgs.zsh-nix-shell}/share/zsh-nix-shell/nix-shell.plugin.zsh
      '';
      autosuggestion.enable = true;
      syntaxHighlighting.enable = true;
      plugins = [
        # Do not forget to update the hash on version change, like this:
        # nix-prefetch-url --unpack https://github.com/zsh-users/zsh-autosuggestions/archive/refs/tags/v0.7.1.zip

        {
          # will source zsh-autosuggestions.plugin.zsh
          name = "zsh-autosuggestions";
          src = pkgs.fetchFromGitHub {
            owner = "zsh-users";
            repo = "zsh-autosuggestions";
            rev = "v0.7.1";
            sha256 = "02p5wq93i12w41cw6b00hcgmkc8k80aqzcy51qfzi0armxig555y";
          };
        }
        {
          name = "enhancd";
          file = "init.sh";
          src = pkgs.fetchFromGitHub {
            owner = "b4b4r07";
            repo = "enhancd";
            rev = "v2.5.1";
            sha256 = "1cljfw3ygg6s5nzl99wsj041pnjlby375vfjrpxv2z6jnnsaga4i";
          };
        }
        {
          # will source zsh-syntax-highlighting.zsh
          name = "zsh-syntax-highlighting";
          src = pkgs.fetchFromGitHub {
            owner = "zsh-users";
            repo = "zsh-syntax-highlighting";
            rev = "v0.8.0";
            sha256 = "1yl8zdip1z9inp280sfa5byjbf2vqh2iazsycar987khjsi5d5w8";
          };
        }
        {
          # will source zsh-history-substring-search.zsh
          name = "zsh-history-substring-search";
          src = pkgs.fetchFromGitHub {
            owner = "zsh-users";
            repo = "zsh-history-substring-search";
            rev = "v1.1.0";
            sha256 = "0vjw4s0h4sams1a1jg9jx92d6hd2swq4z908nbmmm2qnz212y88r";
          };
        }
      ];
    };
  };
  environment.systemPackages = with pkgs; [
    # Terminal Emulators
    bash # GNU Bourne-Again Shell, the de facto standard shell on Linux
    fish # Smart and user-friendly command line shell
    foot # A fast, lightweight and minimalistic Wayland terminal emulator
    kitty # A modern, hackable, featureful, OpenGL based terminal emulator
    tmux # Terminal multiplexer
    wezterm # GPU-accelerated cross-platform terminal emulator and multiplexer

    nanorc # Improved Nano Syntax Highlighting Files
    vim # The most popular clone of the VI editor
    zsh # The Z shell

    fzf-zsh # wrap fzf to use in oh-my-zsh
    oh-my-zsh # A framework for managing your zsh configuration
    zsh-abbr # Zsh manager for auto-expanding abbreviations, inspired by fish shell
    zsh-autocomplete # Real-time type-ahead completion for Zsh. Asynchronous find-as-you-type autocompletion
    zsh-autoenv # Automatically sources whitelisted .autoenv.zsh files
    zsh-autopair # Plugin that auto-closes, deletes and skips over matching delimiters in zsh intelligently
    zsh-autosuggestions # Fish shell autosuggestions for Zsh
    zsh-better-npm-completion
    zsh-completions # Additional completion definitions for zsh
    zsh-f-sy-h
    zsh-fzf-tab # Replace zsh's default completion selection menu with fzf!
    zsh-git-prompt # Informative git prompt for zsh
    zsh-syntax-highlighting # Fish shell like syntax highlighting for Zsh
    # powerline # Ultimate statusline/prompt utility
    # powerline-fonts
    # powerline-rs
    bat # Cat(1) clone with syntax highlighting and Git integration
    eza # A modern, maintained replacement for ls
    fzf # Command-line fuzzy finder written in Go
    htop # Interactive process viewer
  ];
}
