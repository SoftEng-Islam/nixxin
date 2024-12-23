{ pkgs, ... }: {
  environment.systemPackages = with pkgs; [
    bun
    corepack_20 # yarn, pnpm
    dart-sass
    deno
    hugo
    netlify-cli
    nodePackages.prettier
    nodePackages.eas-cli
    nodePackages.firebase-tools
    nodePackages.gulp
    nodePackages.http-server
    nodePackages.node2nix
    nodePackages.nodemon
    nodePackages.ts-node
    typescript
  ];
}
