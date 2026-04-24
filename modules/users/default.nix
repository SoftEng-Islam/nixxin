{
  lib,
  settings,
  pkgs,
  ...
}:
let
  userCfg = settings.modules.users;
  username = settings.user.username;
  defaultShell = userCfg.defaultShell or pkgs.zsh;
in
{
  users = {
    defaultUserShell = defaultShell;
    groups = lib.genAttrs (userCfg.managedGroups or [ ]) (_: {
      members = [ username ];
    });

    users.${username} = {
      isNormalUser = true;
      hashedPassword = userCfg.hashedPassword;
      description = userCfg.name or settings.user.name;
      home = "/home/${username}";
      shell = defaultShell;
      extraGroups = userCfg.extraGroups or [ ];
      uid = userCfg.uid or 1000;
      packages = userCfg.packages or [ ];
    };
  };
}
