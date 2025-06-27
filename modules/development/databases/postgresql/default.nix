{ settings, config, lib, pkgs, ... }:
let inherit (lib) mkIf;
in {
  config = mkIf (settings.modules.development.databases.postgresql.enable) {
    services.postgresql.enable = true;
    environment.systemPackages = with pkgs; [ postgresql postgres-lsp ];
  };
}
