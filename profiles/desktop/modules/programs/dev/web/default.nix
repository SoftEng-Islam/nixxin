{ pkgs, mySettings, ... }: {
  home-manager.users.${mySettings.username} = {
    home = {
      sessionVariables = {
        PATH = "$HOME/.npm-packages/bin:$HOME/.bun/bin:$PATH";
        NODE_PATH = "$HOME/.npm-packages/lib/node_modules:$NODE_PATH";

        # Fixes `bad interpreter: Text file busy`
        # https://github.com/NixOS/nixpkgs/issues/314713
        UV_USE_IO_URING = "0";
      };

      xdg.configFile.".bunfig.toml".source = ./dotfiles/.bunfig.toml;
    };
  };
  environment.systemPackages = with pkgs; [
    bun
    corepack_20 # yarn, pnpm
    dart-sass
    deno
    hugo
    netlify-cli
    nodePackages.prettier
    nodePackages.expo-cli
    nodePackages.firebase-tools
    nodePackages.gulp
    nodePackages.http-server
    nodePackages.node2nix
    nodePackages.nodemon
    nodePackages.ts-node
    typescript
  ];
}
