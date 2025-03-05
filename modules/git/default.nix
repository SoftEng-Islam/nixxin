{ settings, lib, pkgs, ... }:
# git config --global url."https://github.com/".insteadOf "git@github.com:"
# git config --global http.postBuffer 1048576000
# git config --global http.lowSpeedTime 60

let inherit (lib) mkIf;
in mkIf (settings.modules.git.enable) {
  environment.variables = { GIT_CURL_VERBOSE = 0; };
  home-manager.users.${settings.user.username} = {
    programs.git-credential-oauth.enable = true;
    programs.git = {
      enable = true;
      userName = settings.user.name;
      userEmail = settings.user.email;
      extraConfig = {
        color.ui = true;
        pull.ff = "only";
        tag.gpgSign = true;
        safe.directory = "*";
        core.editor = "nvim";
        credential.helper = "store";
        init.defaultBranch = "main";
        push.autoSetupRemote = true;
        github.user = settings.user.username;
        url = { "https://github.com/" = { insteadOf = "git@github.com"; }; };
      };
      ignores = [ ".direnv/" ".envrc" "result" "result-doc" ];

      # signing = {
      # signByDefault = true;
      # key = "3FE1845783ADA7CB";
      # };
      delta.enable = true;
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
    # github-desktop # GUI for managing Git and GitHub
    hub # Command-line wrapper for git that makes you better at GitHub
    lazygit # Simple terminal UI for git commands
    mergiraf # Syntax-aware git merge driver for a growing collection of programming languages and file formats
    tig # Text-mode interface for git
  ];
}
