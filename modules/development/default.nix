{ settings, config, lib, pkgs, ... }:
let
  inherit (lib) mkIf optionals optional flatten;
  development = settings.modules.development;

  _imports = [
    (optional development.vscode.enable ./vscode.nix)
    (optional development.zedEditor ./zed-editor.nix)
    (optional development.emacs ./emacs.nix)
    (optional development.eclipse ./eclipse.nix)
    (optional development.helix ./helix.nix)
  ];
  HOME = config.home.homeDirectory;
in {
  imports = optionals (development.enable or false) flatten _imports;
  config = mkIf (development.enable or false) {
    environment.variables = {
      # PNPM
      state-dir = "${HOME}/.local/state/pnpm-state";
      store-dir = "${HOME}/.local/share/pnpm-store";

      # --- npm ---
      # Prefer XDG paths
      NPM_CONFIG_USERCONFIG = "${HOME}/.config/npm/npmrc";
      NPM_CONFIG_CACHE = "${HOME}/.cache/npm";
      NPM_CONFIG_PREFIX = "${HOME}/.local/share/npm";

      # --- pnpm ---
      PNPM_HOME = "${HOME}/.local/share/pnpm";
      PNPM_STORE_PATH = "${HOME}/.cache/pnpm-store";

      # --- yarn ---
      YARN_CACHE_FOLDER = "${HOME}/.cache/yarn";
      YARN_GLOBAL_FOLDER = "${HOME}/.local/share/yarn";

      # Node REPL history (keep it out of $HOME root)
      NODE_REPL_HISTORY = "${HOME}/.local/share/node/repl_history";
    };
    services.mongodb.enable = true;
    # nixpkgs.config.permittedInsecurePackages = [ "beekeeper-studio-5.3.4" ];
    environment.systemPackages = with pkgs; [
      gnome-text-editor

      # Modern and easy to use SQL client for MySQL, Postgres, SQLite, SQL Server, and more. Linux, MacOS, and Windows
      # beekeeper-studio

      # Universal SQL Client for developers, DBA and analysts. Supports MySQL, PostgreSQL, MariaDB, SQLite, and more
      dbeaver-bin

      # DB Browser for SQLite
      sqlitebrowser

      # Open-source IDE For exploring and testing APIs.
      bruno

      # cross-platform API client for GraphQL, REST, WebSockets, SSE and gRPC. With Cloud, Local and Git storage.
      insomnia

      # https://devenv.sh/
      devenv # Fast, Declarative, Reproducible, and Composable Developer Environments

      # AI Tools fro developers
      copilot-cli
      code-cursor

      antigravity
      postman

      mongodb
      mongodb-compass
      mongodb-cli
      mongodb-ce
      mongodb-tools
      mongodb-atlas-cli

      nodejs
      deno
      yarn
      pnpm
      corepack
      typescript
      typescript-go
    ];
  };
}
