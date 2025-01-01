{ self, inputs, settings, config, pkgs, ... }: {
  # ~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  # ~~~~~~~ home-manager ~~~~~~~
  # ~~~~~~~~~~~~~~~~~~~~~~~~~~~~
  home-manager = {
    # users.${settings.username} = import (./. + "/home.nix");
    extraSpecialArgs = {
      inherit inputs;
      inherit settings;
      inherit self;
    };
    verbose = true;
    useGlobalPkgs = true;
    useUserPackages = true;
    backupFileExtension = "old";
    stylix.targets.hyprland.enable = false;
    programs.home-manager.enable = true;
    programs.bat.enable = true;
    programs.clang-format.enable = true;
    programs.deadnix.enable = true;
    programs.deno.enable = true;
    programs.eza.enable = true;
    programs.hclfmt.enable = true;
    programs.nixfmt.enable = true;
    programs.ruff.check = true;
    programs.ruff.format = true;
    programs.rustfmt.enable = true;
    programs.shellcheck.enable = true;
    programs.shfmt.enable = true;
    programs.ssh.enable = true;
    programs.stylua.enable = true;
    programs.yamlfmt.enable = true;
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
    manual = {
      # disable manuals as nmd fails to build often
      html.enable = false;
      json.enable = false;
      manpages.enable = false;
    };
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
    # QT Settings
    qt = {
      enable = true;
      platformTheme.name = settings.qtPlatformTheme;
      style.name = settings.qtStyle;
    };
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
  };
}
