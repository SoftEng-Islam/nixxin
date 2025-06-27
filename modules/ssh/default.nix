{ settings, lib, pkgs, ... }:

let inherit (lib) mkIf;
in mkIf (settings.modules.ssh.enable) {
  services.openssh = {
    enable = true;
    settings.PasswordAuthentication = false;
  };
  environment.systemPackages = with pkgs; [
    ssh-agents
    ssh-audit
    ssh-chat
    ssh-key-confirmer
  ];
  home-manager.users.${settings.user.username} = {
    programs.ssh = {
      enable = true;
      addKeysToAgent = "yes";
    };
    services.ssh-agent = {
      enable = lib.modules.mkIf pkgs.stdenv.isLinux true;
    };
  };
}
