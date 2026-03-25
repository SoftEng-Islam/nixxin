{ pkgs, settings, ... }:

{
  home-manager.users.${settings.user.username} = {
    home.sessionVariables = {
      # --- pnpm ---
      PNPM_HOME = "${settings.HOME}/.local/share/pnpm";
      PNPM_STORE_DIR = "${settings.HOME}/.local/share/pnpm-store";
      PNPM_STATE_DIR = "${settings.HOME}/.local/state/pnpm-state";

      # --- npm ---
      NPM_CONFIG_USERCONFIG = "${settings.HOME}/.config/npm/npmrc";
      NPM_CONFIG_CACHE = "${settings.HOME}/.cache/npm";
      NPM_CONFIG_PREFIX = "${settings.HOME}/.local/share/npm";

      # --- yarn ---
      YARN_CACHE_FOLDER = "${settings.HOME}/.cache/yarn";
      YARN_GLOBAL_FOLDER = "${settings.HOME}/.local/share/yarn";

      # Node REPL
      NODE_REPL_HISTORY = "${settings.HOME}/.local/share/node/repl_history";
    };
  };

  environment.sessionVariables = {
    PATH = "\${PATH}:${settings.HOME}/.local/share/pnpm";
  };

  environment.systemPackages = with pkgs; [
    nodejs
    deno
    yarn
    pnpm
    corepack
    typescript
    typescript-go
  ];
}
