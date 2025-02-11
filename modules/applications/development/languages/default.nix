{ settings, lib, pkgs, ... }: {
  environment.systemPackages = with pkgs; [
    ./clang
    ./go
    ./python
    ./ruby
    ./rust
    ./web
  ];
}
