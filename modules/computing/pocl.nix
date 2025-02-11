{ settings, lib, pkgs }: {
  environment.systemPackages = with pkgs;
    [
      pocl # Portable Computing Language
    ];
}
