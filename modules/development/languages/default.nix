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
    environment.systemPackages = with pkgs; [
      # Command-line benchmarking tool
      hyperfine

      # The open-source, cross-platform API client for GraphQL, REST, WebSockets, SSE and gRPC. With Cloud, Local and Git storage.
      insomnia

      # Very fast accurate code counter with complexity calculations and COCOMO estimates written in pure Go
      scc
    ];
  };
}
