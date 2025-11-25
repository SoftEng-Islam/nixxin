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

in {
  imports = optionals (development.enable or false) flatten _imports;
  config = mkIf (development.enable or false) {
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
      # antigravity
      # antigravity-fhs
    ];
  };
}
