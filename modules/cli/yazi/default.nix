{
  settings,
  pkgs,
  inputs,
  ...
}:
let
  paste = pkgs.writers.writeNuBin "paste" (builtins.readFile ./paste.nu);
in
{

  home-manager.users.${settings.user.username} = {
    home.packages = [
      paste
      pkgs.ouch
    ];
    programs.yazi = {
      enable = true;
      enableZshIntegration = true;
      enableBashIntegration = true;
      enableFishIntegration = true;
      package = pkgs.update.yazi.override {
        _7zz = pkgs._7zz; # Support for RAR extraction
      };
      settings = import ./yazi_settings.nix;
      keymap = import ./keymap.nix;
      theme = import ./theme.nix;
      flavors = {
        flexoki-light = inputs.yazi-flexoki-light;
        flexoki-dark = inputs.yazi-flexoki-dark;
      };
      plugins = {
        augment-command = "${inputs.yazi-augment-command}";
        chmod = "${inputs.yazi-plugins}/chmod.yazi";
        compress = "${inputs.yazi-compress}";
        full-border = "${inputs.yazi-plugins}/full-border.yazi";
        git = "${inputs.yazi-plugins}/git.yazi";
        hexyl = "${inputs.yazi-hexyl}";
        mount = "${inputs.yazi-plugins}/mount.yazi";
        toggle-pane = "${inputs.yazi-plugins}/toggle-pane.yazi";
        smart-enter = "${inputs.yazi-plugins}/smart-enter.yazi";
        what-size = "${inputs.yazi-what-size}";
      };
      shellWrapperName = "y";
      initLua = ''
        -- require("full-border"):setup()
        -- require("git"):setup()

        -- Custom configuration for augment-command
        require("augment-command"):setup({
          smart_paste = true,
          smart_tab_create = true,
        })

        -- Makes yazi update the zoxide database on navigation
        require("zoxide"):setup
        {
          update_db = true,
        }
      '';
    };
  };
}
