{ pkgs, ... }:

{
  environment.systemPackages = with pkgs; [
    python3

    ruby_3_4
    bundler
    bundix

    # https://devenv.sh/
    devenv # Fast, Declarative, Reproducible, and Composable Developer Environments
  ];
}
