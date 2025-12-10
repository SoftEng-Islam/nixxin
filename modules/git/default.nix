{ settings, config, lib, pkgs, ... }:

# ---- Use gh to login ---- #
# gh auth login

# Ex: To set git configs in terminal:
# git config --global url."https://github.com/".insteadOf "git@github.com:"
# git config --global http.postBuffer 1048576000
# git config --global http.lowSpeedTime 60
let inherit (lib) mkIf;
in mkIf (settings.modules.git.enable) {
  environment.variables = {
    # GIT_CURL_VERBOSE = 1;

    # enable scrolling in git diff
    DELTA_PAGER = "less -R";
  };
  home-manager.users.${settings.user.username} = {
    programs.git = {
      enable = true;
      settings = {
        user.email = settings.user.email;
        user.name = settings.user.name;

        # Reduce the number of parallel connections
        fetch.parallel = 1;
        submodule.fetchJobs = 1;

        # Optimize compression to reduce data transfer size
        core.compression = 9; # Uses maximum compression for Git pack files.
        pack.compression = 9;

        # Disables Git's warning about ignored files being added.
        advice.addIgnoredFile = false;

        url = { "https://github.com/" = { insteadOf = "git@github.com:"; }; };

        # Enables rebase instead of merge when pulling changes.
        pull.rebase = true;

        color.ui = true; # Enables colored output.
        pull.ff = "only"; # Allows fast-forward merges only (no merge commits).
        tag.gpgSign = true; # Signs tags with GPG by default.
        safe.directory = "*"; # Allows Git to operate in any directory safely.
        credential.helper = "store"; # Stores Git credentials in plaintext.
        init.defaultBranch = "main"; # Sets "main" as the default branch name.

        # Automatically sets up remote tracking for pushed branches.
        push.autoSetupRemote = true;

        github.user = settings.user.username; # Sets the GitHub username.

        core = {
          editor = "micro"; # Sets Neovim as the default Git editor.
          autocrlf = false; # Disables automatic line ending conversion.

          # Optimizes Git performance for large repos.
          packedGitWindowSize = "128m";

          # Adjusts packed Git limit to improve efficiency.
          packedGitLimit = "512m";
        };
        http = {
          verbose = false;

          # Increase buffer sizes for large files
          postBuffer = 1048576000; # Increases buffer size for large Git pushes.

          # Prevents Git from timing out on slow networks.
          lowSpeedTime = 1000;

          lowSpeedLimit = 0; # Disables the minimum speed requirement.
          # version = "HTTP/1.1"; # Forces Git to use HTTP/1.1.
        };
        # Enable partial cloning to avoid downloading unnecessary history
        feature.manyFiles = true;

        # If your repo is large, only download essential files:
        feature.sparseCheckout = true;

        # Reduce depth of clone (shallow clone)
        clone.default = "shallow";
        fetch.prune = true;
        fetch.depth = 1;

        # Reconnect automatically if the connection drops
        transfer.retry = 5;
        # Disables integrity checks to speed up transfer
        transfer.fsckObjects = false;
        # Reduces the number of simultaneous unpacking jobs
        transfer.unpackLimit = 1;

      };
      ignores = [
        ".devenv"
        "*.swp"
        "*~"
        "*result*"
        "node_modules"
        "result-doc"
        "result"
      ];
    };
    programs.delta = {
      enable = true;
      options.dark = true;
      enableGitIntegration = true;
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
