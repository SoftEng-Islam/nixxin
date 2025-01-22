{ settings, pkgs, ... }: {
  environment.variables = {
    NODE_PATH = "${pkgs.nodejs_latest}/lib/node_modules";

    # npm set prefix ~/.npm-global
    # Then, append your PATH with $HOME/.npm-global/bin.
    NPM_CONFIG_PREFIX = "/home/${settings.username}/.npm-global";
  };
  environment.systemPackages = with pkgs; [
    corepack_latest # yarn, pnpm
    nodejs_latest # Event-driven I/O framework for the V8 JavaScript engine
    bun

    deno
    # hugo
    # netlify-cli
    typescript # Superset of JavaScript that compiles to clean JavaScript output
    pnpm-shell-completion

    # nodePackages_latest.autoprefixer
    nodePackages_latest.eas-cli
    # nodePackages_latest.eslint
    # nodePackages_latest.firebase-tools
    # nodePackages_latest.gulp
    nodePackages_latest.http-server
    # nodePackages_latest.jsdoc
    # nodePackages_latest.jshint
    nodePackages_latest.node2nix
    nodePackages_latest.nodemon
    nodePackages_latest.npm
    nodePackages_latest.npm-check-updates
    nodePackages_latest.pnpm # Fast, disk space efficient package manager
    # nodePackages_latest.postcss
    nodePackages_latest.prettier
    # nodePackages_latest.sass
    # nodePackages_latest.serve
    # nodePackages_latest.svgo
    # nodePackages_latest.tailwindcss
    # nodePackages_latest.ts-node
    # nodePackages_latest.uglify-js
    # nodePackages_latest.vue-cli
    # nodePackages_latest.vue-language-server
  ];

  home-manager.users.${settings.username} = {
    # home.sessionVariables = { };
    # home.sessionPath = [ "$HOME/.npm-global/bin:$PATH" ];
    home.file = {
      ".npmrc".source = ./.npmrc;
      ".npm-packages/.keep".text = "";
      ".npm-packages/lib/.keep".text = "";
    };

    xdg.configFile.".bunfig.toml".source = ./.bunfig.toml;
  };
}
