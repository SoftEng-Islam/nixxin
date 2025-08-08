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
      "$username"
      "$hostname"
      "$localip"
      "$shlvl"
      "$singularity"
      "$kubernetes"
      "$directory"
      "$vcsh"
      "$fossil_branch"
      "$fossil_metrics"
      "$git_branch"
      "$git_commit"
      "$git_state"
      "$git_metrics"
      "$git_status"
      "$hg_branch"
      "$pijul_channel"
      "$docker_context"
      "$package"
      "$c"
      "$cmake"
      "$cobol"
      "$daml"
      "$dart"
      "$deno"
      "$dotnet"
      "$elixir"
      "$elm"
      "$erlang"
      "$fennel"
      "$gleam"
      "$golang"
      "$guix_shell"
      "$haskell"
      "$haxe"
      "$helm"
      "$java"
      "$julia"
      "$kotlin"
      "$gradle"
      "$lua"
      "$nim"
      "$nodejs"
      "$ocaml"
      "$opa"
      "$perl"
      "$php"
      "$pulumi"
      "$purescript"
      "$python"
      "quarto"
      "raku"
      "rlang"
      "red"
      "ruby"
      "rust"
      "scala"
      "solidity"
      "swift"
      "terraform"
      "typst"
      "vlang"
      "vagrant"
      "zig"
      "buf"
      "nix_shell"
      "conda"
      "meson"
      "spack"
      "memory_usage"
      "aws"
      "gcloud"
      "openstack"
      "azure"
      "nats"
      "direnv"
      "env_var"
      "mise"
      "crystal"
      "custom"
      "sudo"
      "cmd_duration"
      "line_break"
      "jobs"
      "battery"
      "time"
      "status"
      "os"
      "container"
      "netns"
      "shell"
      "character"
      "[❯](bold purple)"
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
      disabled = false;
      success_symbol = "[❯](green)";
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
      disabled = true;
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
    battery = {
      disabled = false;
      full_symbol = "🔋 ";
      charging_symbol = "⚡️ ";
      discharging_symbol = "💀 ";
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
