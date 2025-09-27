{ settings, lib, config, pkgs, ... }:
let inherit (lib) mkIf;
in mkIf (settings.modules.data_transferring.aria.enable or true) {
  home-manager.users.${settings.user.username} = {
    home.file.".config/aria2/aria2.conf".text = lib.mkForce ''
      dir=~/Downloads
      continue=true
      async-dns=false
      max-concurrent-downloads=5
      summary-interval=5
      console-log-level=warn
      split=16
      max-connection-per-server=10
      min-split-size=1M
      timeout=15
      max-tries=20
      retry-wait=5
      lowest-speed-limit=50K
      file-allocation=falloc
      max-file-not-found=2
      enable-dht=true
      enable-dht6=false
      listen-port=6881-6999
      max-overall-upload-limit=1M
      max-upload-limit=50K
      check-integrity=true
    '';
  };

  environment.systemPackages = with pkgs; [ aria2 ];
}
