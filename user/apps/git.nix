{ pkgs, lib, ... }:
let
  name = "Islam Ahemd";
  email = "softeng.islam@gmail.com";
in {
  home.packages = [ pkgs.git ];
  programs.git = {
    enable = true;
    extraConfig = {
      color.ui = true;
      core.editor = "nvim";
      credential.helper = "store";
      github.user = name;
      push.autoSetupRemote = true;
    };
    userEmail = email;
    userName = name;
  };
  programs.ssh = {
    enable = true;
    addKeysToAgent = "yes";
  };
  services.ssh-agent = { enable = lib.modules.mkIf pkgs.stdenv.isLinux true; };
}
