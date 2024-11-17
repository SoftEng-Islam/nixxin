{ pkgs, lib, ... }:
let name = "softeng"; # the github username
in {
  programs.git = {
    enable = true;
    extraConfig = {
      color.ui = true;
      core.editor = "nvim";
      credential.helper = "store";
      github.user = name;
      push.autoSetupRemote = true;
    };
    userEmail = "softeng.islam@gmail.com";
    userName = name;
  };
  programs.ssh = {
    enable = true;
    addKeysToAgent = "yes";
  };
  services.ssh-agent = {
    enable = lib.modules.mkIf pkgs.stdenv.isLinux true;
  };
}
