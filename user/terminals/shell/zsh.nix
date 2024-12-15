{ pkgs, ... }:
let
  # My shell aliases
  myAliases = {
    # Set-up icons for files/folders in terminal
    # ls = "eza -a --icons";
    ls = "eza --icons -l -T -L=1";
    l = "eza -lh --icons=auto"; # Long list with icons
    ll = "eza -al --icons";
    lt = "eza -a --tree --level=1 --icons";
    ld = "eza -lhD --icons=auto"; # Long list directories with icons
    # lt = "eza --icons=auto --tree";  # List folder as tree with icons

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

  };
in {
  imports = [ ./starship.nix ];
  networking.firewall.allowedTCPPortRanges = [
    # wezterm tls server
    {
      from = 60000;
      to = 60010;
    }
  ];
  programs.zsh = {
    enable = true;
    autosuggestions.async = true;
    autosuggestions.enable = true;
    enableBashCompletion = true;
    enableCompletion = true;
    shellAliases = myAliases;
    histFile = "~/.zsh_history";
    histSize = "3000";
    enableGlobalCompInit = true;
    ohMyZsh.enable = true;
    zsh-autoenv.enable = true;

    # autosuggestions.strategy = ["history"]; list of (one of "history", "completion", "match_prev_cmd")
    initExtra = ''
      PROMPT=" ◉ %U%F{magenta}%n%f%u@%U%F{blue}%m%f%u:%F{yellow}%~%f %F{green}→%f "
      RPROMPT="%F{red}▂%f%F{yellow}▄%f%F{green}▆%f%F{cyan}█%f%F{blue}▆%f%F{magenta}▄%f%F{white}▂%f"
      [ $TERM = "dumb" ] && unsetopt zle && PS1='$ '
      bindkey '^P' history-beginning-search-backward
      bindkey '^N' history-beginning-search-forward
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
  # home.packages = with pkgs; [ eza ];
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
    zsh-fzf-tab
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
