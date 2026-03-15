{
  config,
  pkgs,
  lib,
  ...
}: {
  programs.ssh = {
    enable = true;
    # my homelab server
    matchBlocks = {
      "mulatta" = {
        hostname = "100.70.147.90";
        user = "seungwon";
        identitiesOnly = true;
        identityFile = [
          "~/.ssh/ssh_id_ed25519_sk"
          "~/.ssh/ssh_backup_id_ed25519_sk"
        ];
        forwardAgent = false;
      };

      # github ssh with yubikey
      "github.com" = {
        identitiesOnly = true;
        identityFile = [
          "~/.ssh/github_id_ed25519_sk"
          "~/.ssh/github_backup_id_ed25519_sk"
        ];
        forwardAgent = false;
        extraOptions = {
          ControlMaster = "auto";
          ControlPath = "~/.ssh/github.sock";
          ControlPersist = "5m";
        };
      };

      # vm on mac
      "nix-builder" = {
        hostname = "127.0.0.1";
        port = 55801;
        user = "seungwon";
        identitiesOnly = true;
        identityFile = "/Users/seungwon/.colima/_lima/_config/user";
        extraOptions = {
          StrictHostKeyChecking = "no";
          UserKnownHostsFile = "/dev/null";
          NoHostAuthenticationForLocalhost = "yes";
          PreferredAuthentications = "publickey";
          Compression = "no";
          BatchMode = "yes";
          IdentitiesOnly = "yes";
          Ciphers = "^aes128-gcm@openssh.com,aes256-gcm@openssh.com";
          ControlMaster = "auto";
          ControlPath = "/Users/seungwon/.colima/_lima/colima-nix-builder/ssh.sock";
          ControlPersist = "yes";
        };
      };
    };
  };

  home.packages = with pkgs; [
    openssh
    gnupg
    pinentry-curses
    sops
    rage
    ssh-to-age
    paperkey
    yubikey-personalization
    age-plugin-yubikey
    libfido2
    pam_u2f
    yubico-piv-tool
  ];
}
