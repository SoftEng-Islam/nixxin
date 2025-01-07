{ pkgs, ... }: {
  environment.systemPackages = with pkgs;
    with pkgs.python3Packages; [
      # Python
      evdev-proto
      pillow
      pip
      poetry-core
      psutil
      pycairo
      pydbus
      pygobject3
      pywal
      pywayland
      setuptools-scm
      six
      watchdog
      wheel
      xkeysnail
    ];
}
