{ settings, config, pkgs, ... }: {
  imports = [
    ./bun.nix
    # ./php.nix
    # ./wordpress.nix
  ];
  environment.variables = {
    NODE_PATH = "${pkgs.nodejs_latest}/lib/node_modules";

    # npm set prefix ~/.npm-global
    # Then, append your PATH with $HOME/.npm-global/bin.
    NPM_CONFIG_PREFIX = "/home/${settings.user.username}/.npm-global";
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

    nodePackages_latest.typescript-language-server
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

  # Full minimal working PHP setup example
  # services.nginx.enable = true;
  # services.phpfpm.pools.wordpress-localhost = {
  #   user = "nginx";
  #   group = "nginx";
  #   settings = {
  #     "listen.owner" = "nginx";
  #     "listen.group" = "nginx";
  #     "listen.mode" = "0660";
  #   };
  #   phpOptions = ''
  #     upload_max_filesize = 1G
  #     post_max_size = 1G
  #     memory_limit = 512M
  #     max_execution_time = 300
  #   '';
  # };
  # services.wordpress.sites."localhost" = { };

  home-manager.users.${settings.user.username} = {
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
