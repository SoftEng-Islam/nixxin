{ settings, lib, pkgs, ... }:
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
    cat = "bat";
  };
in { }
