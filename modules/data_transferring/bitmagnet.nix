{ settings, config, lib, pkgs, ... }:
let inherit (lib) mkIf;
in {
  config = mkIf (settings.modules.data_transferring.bitmagnet.enable or false) {
    services.postgresql.enable = true;
    services.bitmagnet.enable = true;
    environment.systemPackages = with pkgs; [
      # Self-hosted BitTorrent indexer, DHT crawler, and torrent search engine
      bitmagnet

      postgresql
      postgres-lsp
    ];
  };
}
