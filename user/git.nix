{ pkgs, settings, lib, ... }: {
  home.packages = [ pkgs.git ];
  programs.git = {
    enable = true;
    extraConfig = {
      color.ui = true;
      core.editor = "nvim";
      credential.helper = "store";
      github.user = settings.name;
      push.autoSetupRemote = true;
    };
    userEmail = settings.email;
    userName = settings.name;
  };
  programs.ssh = {
    enable = true;
    addKeysToAgent = "yes";
  };
  services.ssh-agent = { enable = lib.modules.mkIf pkgs.stdenv.isLinux true; };
}
