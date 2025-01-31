{ settings, pkgs, lib, ... }: {

  home-manager.users."${settings.users.selected.username}" = {

    xdg = {
      configFile.nvim.source = ./nvim;
      # configFile.nvim.recursive = true;
      desktopEntries."nvim" = lib.mkIf pkgs.stdenv.isLinux {
        name = "NeoVim";
        comment = "Edit text files";
        icon = "nvim";
        exec = "xterm -e ${pkgs.neovim}/bin/nvim %F";
        categories = [ "TerminalEmulator" ];
        terminal = false;
        mimeType = [ "text/plain" ];
      };
    };

    programs.neovim = {
      enable = true;
      viAlias = true;
      vimAlias = true;

      withRuby = true;
      withNodeJs = true;
      withPython3 = true;

      extraPackages = with pkgs; [
        neovide
        git
        gcc
        gnumake
        wget
        curl
        tree-sitter
        ripgrep
        fd
        fzf
        cargo

        nil
        lua-language-server
        stylua
        alejandra
      ];
    };
  };
}
