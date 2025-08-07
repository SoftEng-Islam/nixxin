{ settings, config, pkgs, ... }:
let
  lang = icon: color: {
    symbol = icon;
    format = "[$symbol ](${color})";
  };
  os = icon: fg: "[${icon} ](fg:${fg})";
  pad = {
    left = "";
    right = "";
  };
  starship_settings = {
    "$schema" = "https://starship.rs/config-schema.json";
    add_newline = true;
    format = builtins.concatStringsSep "" [
      "$nix_shell"
      "$os"
      "$username"
      "$hostname"
      "$directory"
      "$container"
      "$git_branch $git_status"
      "$python"
      "$nodejs"
      "$lua"
      "$rust"
      "$java"
      "$c"
      "$golang"
      "$cmd_duration"
      "$continuation_prompt"
      "$status"
      "$line_break"
      "[❯](bold purple)"
      "\${custom.space}"
    ];
    continuation_prompt = "∙  ┆ ";
    status = {
      symbol = "✗";
      not_found_symbol = "󰍉 Not Found";
      not_executable_symbol = " Can't Execute E";
      sigint_symbol = "󰂭 ";
      signal_symbol = "󱑽 ";
      format = "[$symbol](fg:red)";
      map_symbol = true;
      disabled = false;
      success_symbol = "[✓](bold green)";
    };
    character = {
      # default symbols
      success_symbol = "[❯](green)";
      error_symbol = "[❯](red)";
      # success_symbol = '[➜](bold green)';
      # error_symbol = '[✗](bold red)';
      # success_symbol = '[\$](green)';
      # error_symbol = '[\$](red)';
    };
    hostname = {
      ssh_only = false;
      disabled = false;
      ssh_symbol = "🌐 "; # 🌐 🌎 🌏
      # ssh_symbol = ""; # remove altogether
      # style = "bold dimmed green" - default
      style = "green";
      format = "@[$ssh_symbol$hostname]($style)";
    };
    username = {
      show_always = true;
      style_user = "bold blue";
    };
    cmd_duration = {
      disabled = true;
      min_time = 1000;
      show_milliseconds = true;
      format = "[$duration]($style) ";
      style = "yellow";
    };
    nix_shell = {
      symbol = " ";
      heuristic = true;
      disabled = false;
      format =
        "[${pad.left}](fg:white)[ ](bg:white fg:black)[${pad.right}](fg:white) ";
    };
    container = {
      symbol = " 󰏖";
      format = "[$symbol ](yellow dimmed)";
    };
    directory = {
      format = ":[$path]($style)[$read_only]($read_only_style) ";
      truncation_symbol = ".../";
      truncate_to_repo = false;
      style = "blue";
      read_only = " ";
      truncation_length = 2;
    };
    git_branch = {
      symbol = "";
      style = "bright-black";
      format = "[ $symbol $branch](fg:purple)(:$remote_branch)";
    };
    git_status = {
      deleted = "✗";
      modified = "✶";
      staged = "✓";
      stashed = "≡";
      ahead = "⇡";
      behind = "⇣";
    };
    os = {
      disabled = false;
      format = "$symbol";
    };
    os.symbols = {
      Arch = os "" "bright-blue";
      Alpine = os "" "bright-blue";
      Debian = os "" "red)";
      EndeavourOS = os "" "purple";
      Fedora = os "" "blue";
      NixOS = os "" "blue";
      openSUSE = os "" "green";
      SUSE = os "" "green";
      Ubuntu = os "" "bright-purple";
      Macos = os "" "white";
    };
    python = lang "" "yellow";
    nodejs = lang "󰛦" "bright-blue";
    bun = lang "󰛦" "blue";
    deno = lang "󰛦" "blue";
    lua = lang "󰢱" "blue";

    rust = lang "" "red";
    java = lang "" "red";
    c = lang "" "blue";
    golang = lang "" "blue";
    dart = lang "" "blue";
    elixir = lang "" "purple";

    line_break = { disabled = false; };
    custom.space = {
      when = "! test $env";
      format = " ";
    };
  };
  tomlFormat = pkgs.formats.toml { };
  starshipCmd = "${pkgs.starship}/bin/starship";
in {
  programs.starship.enable = true;
  programs.starship.interactiveOnly = false;
  programs.starship.package = pkgs.starship;
  programs.starship.presets = [ "nerd-font-symbols" ];
  home-manager.users.${settings.user.username} = {
    # home.sessionVariables.STARSHIP_CACHE = "${config.xdg.cacheHome}/starship";

    xdg.configFile."starship.toml" = {
      source = tomlFormat.generate "starship-config" starship_settings;
    };

    programs.bash.initExtra = ''
      eval "$(${starshipCmd} init bash)"
    '';

    programs.zsh.initExtra = ''
      eval "$(${starshipCmd} init zsh)"
    '';

    programs.starship.enable = true;
    # programs.starship.enableZshIntegration = true;

    programs.nushell = {
      extraEnv = ''
        mkdir ${config.xdg.cacheHome}/starship
        ${starshipCmd} init nu | save -f ${config.xdg.cacheHome}/starship/init.nu
      '';
      extraConfig = ''
        use ${config.xdg.cacheHome}/starship/init.nu
      '';
    };
  };
  environment.systemPackages = with pkgs; [ tmux ];
}
