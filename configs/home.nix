{ config, lib, pkgs, settings, ... }: {
  imports = [
    ./themes/stylix.nix

    ./home/cli
    ./home/dev
    ./home/flags
    ./home/media
    ./home/wm/gnome
    ./home/terminal
    ./home/xdg.nix
  ];

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
  stylix.targets.hyprland.enable = false;

  home = {
    username = settings.username;
    homeDirectory = "/home/${settings.username}";
    stateVersion = settings.homeStateVersion;
    sessionVariables = {
      EDITOR = settings.editor;
      TERM = settings.term;
      BROWSER = settings.browser;
      NIXPKGS_ALLOW_UNFREE = "1";
      NIXPKGS_ALLOW_INSECURE = "1";

      PATH = "$HOME/.npm-packages/bin:$HOME/.bun/bin:$PATH";
      NODE_PATH = "$HOME/.npm-packages/lib/node_modules:$NODE_PATH";

      # Fixes `bad interpreter: Text file busy`
      # https://github.com/NixOS/nixpkgs/issues/314713
      UV_USE_IO_URING = "0";

      # clean up ~
      LESSHISTFILE = "${config.xdg.cacheHome}/less/history";
      LESSKEY = "${config.xdg.configHome}/less/lesskey";

      WINEPREFIX = "${config.xdg.dataHome}/wine";
      XAUTHORITY = "$XDG_RUNTIME_DIR/Xauthority";

      DIRENV_LOG_FORMAT = "";

      # auto-run programs using nix-index-database
      NIX_AUTO_RUN = "1";
    };
    sessionPath = [ "$HOME/.local/bin" ];
  };
  # disable manuals as nmd fails to build often
  manual = {
    html.enable = false;
    json.enable = false;
    manpages.enable = false;
  };

  programs.hclfmt.enable = true;
  programs.yamlfmt.enable = true;
  programs.mypy.directories = {
    "tasks" = {
      directory = ".";
      modules = [ ];
      files = [ "**/tasks.py" ];
      extraPythonPackages =
        [ pkgs.python3.pkgs.deploykit pkgs.python3.pkgs.invoke ];
    };
    "machines/eva/modules/prometheus" = { };
    "openwrt" = { };
    "home-manager/modules/neovim" = {
      options = [ "--ignore-missing-imports" ];
    };
  };
  programs.deadnix.enable = true;
  programs.stylua.enable = true;
  programs.clang-format.enable = true;
  programs.deno.enable = true;
  programs.nixfmt.enable = true;
  programs.shellcheck.enable = true;
  programs.shfmt.enable = true;
  programs.rustfmt.enable = true;
  programs.ruff.format = true;
  programs.ruff.check = true;
  programs.bat.enable = true;
  programs.eza.enable = true;
  programs.ssh.enable = true;
  # gtk = {
  #   enable = true;
  #   cursorTheme = {
  #     name = settings.cursorTheme;
  #     size = settings.cursorSize;
  #     package = settings.cursorPackage;
  #   };
  #   font = {
  #     name = settings.fontName;
  #     package = settings.fontPackage;
  #     size = settings.fontSize;
  #   };
  #   iconTheme = {
  #     name = settings.iconName;
  #     package = settings.iconPackage;
  #   };
  #   theme = {
  #     name = lib.mkForce settings.gtkTheme;
  #     package = lib.mkForce settings.gtkPackage;
  #   };
  #   gtk2.configLocation = "${config.xdg.configHome}/gtk-2.0/gtkrc";
  # };

  # QT Settings
  qt = {
    enable = true;
    platformTheme.name = settings.qtPlatformTheme;
    style.name = settings.qtStyle;
  };
}
