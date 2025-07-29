{ settings, lib, pkgs, ... }:
let inherit (lib) optionals mkIf;
in {
  # Conditionally import all modules if `enable = true`
  imports = optionals (settings.modules.development.languages.enable or false) [
    ./clang
    ./dart
    ./go
    ./python
    ./ruby
    ./rust
  ];

  config = mkIf (settings.modules.development.languages.enable or false) {
    environment.systemPackages = with pkgs; [
      # Command-line benchmarking tool
      hyperfine

      # Very fast accurate code counter with complexity calculations and COCOMO estimates written in pure Go
      scc
    ];
  };
}
