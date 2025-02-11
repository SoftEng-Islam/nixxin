{ settings, lib, pkgs, ... }: {
  home-manager.users.${settings.users.selected.username} = {
    programs.git = {
      enable = true;
      extraConfig = {
        color.ui = true;
        core.editor = "nvim";
        credential.helper = "store";
        github.user = settings.users.selected.name;
        push.autoSetupRemote = true;
      };
      userEmail = settings.users.selected.email;
      userName = settings.users.selected.name;
    };
  };
  environment.systemPackages = with pkgs; [
    delta # Syntax-highlighting pager for git
    gh # GitHub CLI tool
    git # Distributed version control system
    git-absorb # git commit --fixup, but automatic
    git-crypt # Transparent file encryption in git
    git-ignore # Quickly and easily fetch .gitignore templates from gitignore.io
    git-lfs # Git extension for versioning large files
    github-desktop # GUI for managing Git and GitHub
    hub # Command-line wrapper for git that makes you better at GitHub
    lazygit # Simple terminal UI for git commands
    mergiraf # Syntax-aware git merge driver for a growing collection of programming languages and file formats
    tig # Text-mode interface for git
  ];
}
