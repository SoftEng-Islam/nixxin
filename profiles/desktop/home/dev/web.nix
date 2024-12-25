{ ... }: {

  home = {
    sessionVariables = {
      PATH = "$HOME/.npm-packages/bin:$HOME/.bun/bin:$PATH";
      NODE_PATH = "$HOME/.npm-packages/lib/node_modules:$NODE_PATH";

      # Fixes `bad interpreter: Text file busy`
      # https://github.com/NixOS/nixpkgs/issues/314713
      UV_USE_IO_URING = "0";
    };
  };
  xdg.configFile.".bunfig.toml".source = ./dotfiles/.bunfig.toml;
}
