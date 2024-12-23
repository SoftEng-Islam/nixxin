{ pkgs, mySettings, lib, ... }: {
  environment.systemPackages = with pkgs; [
    hub # Command-line wrapper for git that makes you better at GitHub
    delta # Syntax-highlighting pager for git
    gh # GitHub CLI tool
    git # Distributed version control system
    git-absorb
    git-crypt # Transparent file encryption in git
    git-lfs # Git extension for versioning large files
    lazygit # Simple terminal UI for git commands
    mergiraf # Syntax-aware git merge driver for a growing collection of programming languages and file formats
    tig # Text-mode interface for git

  ];
  home-manager.users.${mySettings.username} = {

    home.packages = [ pkgs.git ];
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
