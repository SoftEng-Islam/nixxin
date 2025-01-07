{ pkgs, ... }: {
  environment.systemPackages = with pkgs; [
    # Python
    appdirs
    dbus-python
    evdev
    hatchling
    inotify-simple
    material-color-utilities
    materialyoucolor
    ordered-set
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
