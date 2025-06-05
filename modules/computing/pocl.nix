{ settings, lib, pkgs }:
let inherit (lib) mkIf;
in mkIf (settings.modules.computing.enable) {
  # environment.variables = { };
  environment.systemPackages = with pkgs;
    [
      pocl # Portable Computing Language
    ];
}
