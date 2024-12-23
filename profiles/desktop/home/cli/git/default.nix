{ pkgs, mySettings, lib, ... }: {
  home-manager.users.${mySettings.username} = {
    programs.git = {
      enable = true;
      extraConfig = {
        color.ui = true;
        core.editor = "nvim";
        credential.helper = "store";
        github.user = mySettings.name;
        push.autoSetupRemote = true;
      };
      userEmail = mySettings.email;
      userName = mySettings.name;
    };
    programs.ssh = {
      enable = true;
      addKeysToAgent = "yes";
    };
    services.ssh-agent = {
      enable = lib.modules.mkIf pkgs.stdenv.isLinux true;
    };
  };
}
