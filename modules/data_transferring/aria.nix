{ settings, lib, config, pkgs, ... }:
let inherit (lib) mkIf;
in mkIf (settings.modules.data_transferring.aria.enable or true) {
  home-manager.users.${settings.user.username} = {
    home.file.".config/aria2/aria2.conf".text = lib.mkForce ''
      continue=true
      timeout=15
      max-tries=20
      retry-wait=5
      lowest-speed-limit=0
      file-allocation=falloc
      max-file-not-found=2
      enable-dht=true
      enable-dht6=false
    '';
  };

  # aria2c --enable-rpc
  environment.systemPackages = with pkgs; [ aria2 ];
}
