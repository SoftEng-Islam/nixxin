{ settings, config, lib, pkgs, ... }:
# git config --global url."https://github.com/".insteadOf "git@github.com:"
# git config --global http.postBuffer 1048576000
# git config --global http.lowSpeedTime 60

# ---- Use gh to login ---- #
# gh auth login

let
  inherit (lib) mkIf;
  # cfg = config.programs.git;
  # key = "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIOq9Gew1rgfdIyuriJ/Ne0B8FE1s8O/U2ajErVQLUDu9 mihai@io";
in mkIf (settings.modules.git.enable) {
  environment.variables = {
    # GIT_CURL_VERBOSE = 0;
    # enable scrolling in git diff
    DELTA_PAGER = "less -R";
  };
  home-manager.users.${settings.user.username} = {
    programs.git = {
      enable = true;
      userName = settings.user.name;
      userEmail = settings.user.email;
      extraConfig = {
        pull.rebase =
          true; # Enables rebase instead of merge when pulling changes.
        color.ui = true; # Enables colored output.
        pull.ff = "only"; # Allows fast-forward merges only (no merge commits).
        tag.gpgSign = true; # Signs tags with GPG by default.
        safe.directory = "*"; # Allows Git to operate in any directory safely.
        core.editor = "nvim"; # Sets Neovim as the default Git editor.
        credential.helper = "store"; # Stores Git credentials in plaintext.
        init.defaultBranch = "main"; # Sets "main" as the default branch name.
        push.autoSetupRemote =
          true; # Automatically sets up remote tracking for pushed branches.
        github.user = settings.user.username; # Sets the GitHub username.
        core = {
          autocrlf = false; # Disables automatic line ending conversion.
          compression = 9; # Uses maximum compression for Git pack files.
          packedGitWindowSize =
            "128m"; # Optimizes Git performance for large repos.
          packedGitLimit =
            "512m"; # Adjusts packed Git limit to improve efficiency.
        };
        http = {
          verbose = false;
          postBuffer = 1048576000; # Increases buffer size for large Git pushes.
          lowSpeedTime =
            999999; # Prevents Git from timing out on slow networks.
          lowSpeedLimit = 0; # Disables the minimum speed requirement.
          version = "HTTP/1.1"; # Forces Git to use HTTP/1.1.
        };
        submodule.fetchJobs =
          4; # Fetches submodules in parallel to speed up the process.
        advice.addIgnoredFile =
          false; # Disables Git's warning about ignored files being added.

        url = { "https://github.com/" = { insteadOf = "git@github.com:"; }; };
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
