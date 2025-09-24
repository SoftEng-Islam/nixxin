{ settings, pkgs, ... }: {
  environment.systemPackages = with pkgs; [
    nil
    nixd
    zed-editor
    package-version-server
  ];
  home-manager.users.${settings.user.username} = {
    programs.zed-editor = {
      enable = true;
      package = pkgs.zed-editor;
      extensions =
        [ "git-firefly" "html" "nix" "one-dark-pro" "sql" "toml" "twig" ];
      userSettings = {
        auto_update = false;
        autosave = "off";
        buffer_font_family = "CaskaydiaCove Nerd Font";
        buffer_font_size = 14;
        chat_panel.button = false;
        collaboration_panel.button = false;
        features.inline_completion_provider = "none";

        indent_guides = {
          enabled = true;
          coloring = "indent_aware";
        };

        inlay_hints.enabled = true;
        journal.hour_format = "hour24";
        lsp.nil.initialization_options.formatting.command = [ "nixfmt" ];
        notification_panel.button = false;
        relative_line_numbers = true;
        show_whitespaces = "boundary";
        tabs.git_status = true;

        terminal = {
          blinking = "on";
          copy_on_select = true;
          font_family = "CaskaydiaCove Nerd Font";
          font_size = 14;
        };
        ui_font_size = 16;
      };
      extraPackages = [ pkgs.nixd ];
      userKeymaps = [{
        context = "Workspace";
        bindings = { ctrl-shift-t = "workspace::NewTerminal"; };
      }];
    };
  };
}
