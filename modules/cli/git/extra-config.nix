{config, ...}: {
  init.defaultBranch = "main";
  gpg = {
    program = "${config.programs.gpg.package}/bin/gpg2";
    ssh.allowedSignersFile = "${config.home.homeDirectory}/.ssh/allowed_signers";
  };

  merge.ConflictStyle = "zdiff3";
  commit.verbose = true;
  diff.algorithm = "histogram";
  log.date = "iso";
  branch.sort = "committerdate";
  rerere.enabled = true;

  core = {
    editor = "hx";
    compression = -1;
    autocrlf = "input";
    whitespace = "trailing-space,space-before-tab";
    precomposeunicode = true;
  };

  color = {
    diff = "auto";
    status = "auto";
    branch = "auto";
    ui = true;
  };

  push = {
    autoSetupRemote = true;
    default = "simple";
  };

  pull = {
    ff = "only";
  };

  url = {
    "git@github.com:".insteadOf = "https://github.com/";
  };
}
