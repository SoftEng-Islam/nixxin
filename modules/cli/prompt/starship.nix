{
  settings,
  config,
  pkgs,
  ...
}:
let
  lang = icon: color: {
    symbol = icon;
    format = "[$symbol ](${color})";
  };
  starship_settings = {
    "$schema" = "https://starship.rs/config-schema.json";
    add_newline = true;
    scan_timeout = 1000;
    command_timeout = 2000;
    # ignore_timeout = true;
    format = builtins.concatStringsSep "" [
      "$all"
      "$character"
      "\${custom.space}"
    ];
    username = {
      disabled = false;
      format = "[$user]($style)";
      show_always = true;
      style_user = "bold purple";
      style_root = "bold red";
    };
    hostname = {
      disabled = false;
      ssh_only = false;
      ssh_symbol = "🌐 "; # 🌐 🌎 🌏
      style = "yellow";
      format = "@[$ssh_symbol$hostname]($style)";
    };
    continuation_prompt = "∙  ┆ ";
    status = {
      disabled = true;
      symbol = "✗";
      not_found_symbol = "󰍉 Not Found";
      not_executable_symbol = " Can't Execute E";
      sigint_symbol = "󰂭 ";
      signal_symbol = "󱑽 ";
      format = "[$symbol](fg:red)";
      map_symbol = true;
      success_symbol = "[✓](bold green)";
    };
    character = {
      disabled = false;
      success_symbol = "[❯](bold green)";
      error_symbol = "[❯](red)";
    };
    cmd_duration = {
      disabled = true;
      min_time = 1000;
      show_milliseconds = true;
      format = "[$duration]($style) ";
      style = "yellow";
    };
    nix_shell = {
      disabled = true;
      format = " [$symbol$state( ($name))]($style) ";
      symbol = " ";
      style = "bold blue";
      heuristic = true;
      impure_msg = "[impure shell](bold red)";
      pure_msg = "[pure shell](bold green)";
      unknown_msg = "[unknown shell](bold yellow)";
    };
    container = {
      symbol = " 󰏖";
      format = "[$symbol ](yellow dimmed)";
    };
    directory = {
      disabled = false;
      format = ":[$path]($style)[$read_only]($read_only_style) ";
      home_symbol = "~";
      truncation_symbol = ".../";
      truncate_to_repo = true;
      style = "blue";
      read_only = " ";
      read_only_style = "red";
      truncation_length = 3;
    };
    direnv = {
      disabled = false;
      symbol = "direnv ";
    };
    git_branch = {
      symbol = "";
      style = "bright-black";
      format = "[ $symbol $branch](fg:purple)(:$remote_branch) ";
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
      disabled = true;
      format = "$symbol";
    };

    line_break = {
      disabled = false;
    };
    custom.space = {
      when = "! test $env";
      format = " ";
    };
    battery = {
      disabled = true;
      full_symbol = "🔋 ";
      charging_symbol = "⚡️ ";
      discharging_symbol = "💀 ";
    };
    package = {
      disabled = true;
      format = " [$symbol$version]($style)";
      symbol = "📦 ";
    };
  };
  tomlFormat = pkgs.formats.toml { };
  starshipCmd = "${pkgs.starship}/bin/starship";
in
{
  # Whether to enable starship only when the shell is interactive. Some plugins require this to be set to false to function correctly.
  programs.starship.interactiveOnly = false;
  programs.starship = {
    enable = true;
    package = pkgs.starship;
    presets = [ "nerd-font-symbols" ];
    settings = starship_settings;
  };
  home-manager.users.${settings.user.username} = {
    programs.starship = {
      enable = true;
      enableTransience = true;
      enableZshIntegration = true;
      enableBashIntegration = true;
      enableFishIntegration = true;
    };
    # home.sessionVariables.STARSHIP_CACHE = "/home/${settings.user.username}/.cache/starship";

    programs.bash.initExtra = ''
      eval "$(${starshipCmd} init bash)"
    '';

    programs.zsh.initContent = ''
      eval "$(${starshipCmd} init zsh)"
    '';

  };

  # tmux is intended to be a modern, BSD-licensed alternative to programs such as GNU screen. Major features include:
  programs.tmux.enable = true;
}
