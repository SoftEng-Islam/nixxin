{ settings, lib, pkgs }: {
  # environment.variables = { };
  environment.systemPackages = with pkgs;
    [
      pocl # Portable Computing Language
    ];
}
