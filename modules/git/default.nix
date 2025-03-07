{ settings, config, lib, pkgs, ... }:
# git config --global url."https://github.com/".insteadOf "git@github.com:"
# git config --global http.postBuffer 1048576000
# git config --global http.lowSpeedTime 60

let
  inherit (lib) mkIf;
  # cfg = config.programs.git;
  # key = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIOq9Gew1rgfdIyuriJ/Ne0B8FE1s8O/U2ajErVQLUDu9 mihai@io";
in mkIf (settings.modules.git.enable) {
  environment.variables = {
    GIT_CURL_VERBOSE = 0;

    # enable scrolling in git diff
    DELTA_PAGER = "less -R";
  };
  home-manager.users.${settings.user.username} = {
    # programs.git-credential-oauth.enable = true;
    programs.git = {
      enable = true;
      userName = settings.user.name;
      userEmail = settings.user.email;
      extraConfig = {
        pull.rebase = true;
        color.ui = true;
        pull.ff = "only";
        tag.gpgSign = true;
        safe.directory = "*";
        core.editor = "nvim";
        credential.helper = "store";
        init.defaultBranch = "main";
        push.autoSetupRemote = true;
        github.user = settings.user.username;
        core = {
          autocrlf = false;
          compression = 9;
          packedGitWindowSize = "128m";
          packedGitLimit = "512m";
        };
        http = {
          postBuffer = 1048576000;
          lowSpeedTime = 999999;
          lowSpeedLimit = 0;
          version = "HTTP/1.1";
        };
        submodule.fetchJobs = 4;
        advice.addIgnoredFile = false;
        # url."https://github.com/".insteadOf = "git@github.com:";
        url = { "git@github.com" = { insteadOf = "https://github.com/"; }; };
        # gpg = {
        #   format = "ssh";
        #   ssh.allowedSignersFile = config.home.homeDirectory + "/"
        #     + config.xdg.configFile."git/allowed_signers".target;
        # };
      };
      ignores = [
        ".direnv"
        ".envrc"
        "*.swp"
        "*~"
        "*result*"
        "node_modules"
        "result-doc"
        "result"
      ];

      # signing = {
      #   signByDefault = true;
      #   key = "${config.home.homeDirectory}/.ssh/id_ed";
      # };

      delta = {
        enable = true;
        options.dark = true;
      };

    };
    # xdg.configFile."git/allowed_signers".text = ''
    #   ${cfg.userEmail} namespaces="git" ${key}
    # '';
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
