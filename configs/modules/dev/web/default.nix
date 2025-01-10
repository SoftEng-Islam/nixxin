{ pkgs, ... }: {
  environment.systemPackages = with pkgs; [
    bun
    corepack_20 # yarn, pnpm
    deno
    hugo
    netlify-cli
    nodejs_latest # Event-driven I/O framework for the V8 JavaScript engine
    typescript # Superset of JavaScript that compiles to clean JavaScript output
    pnpm-shell-completion

    (nodePackages_latest (with ps; [
      autoprefixer
      eas-cli
      eslint
      firebase-tools
      gulp
      http-server
      jsdoc
      jshint
      node2nix
      nodemon
      npm
      npm-check-updates
      pnpm # Fast, disk space efficient package manager
      postcss
      prettier
      sass
      serve
      socket.io
      svgo
      tailwindcss
      ts-node
      uglify-js
      vue-cli
      vue-language-server
    ]))
  ];
}
