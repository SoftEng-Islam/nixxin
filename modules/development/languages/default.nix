{ settings, lib, pkgs, ... }:
let inherit (lib) optionals mkIf;
in {
  # Conditionally import all modules if `enable = true`
  imports = optionals (settings.modules.development.languages.enable or false) [
    ./clang
    ./go
    ./python
    ./ruby
    ./rust
    ./web
  ];

  config = mkIf (settings.modules.development.languages.enable or false) {
    environment.systemPackages = with pkgs;
      [
        # Command-line benchmarking tool
        # hyperfine
        # insomnia
        # scc
      ];
  };
}
