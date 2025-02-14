{ settings, lib, pkgs, ... }:
let inherit (lib) mkIf;
in {
  services = {
    # Tumbler, A D-Bus thumbnailer service.
    tumbler.enable = true;

    # ACPI daemon
    acpid.enable = true;

    # Populates contents of /bin and /usr/bin/
    envfs.enable = true;

    # Enable touchpad support (enabled default in most desktopManager).
    libinput.mouse.accelSpeed = "-0.5";

    # The color management daemon.
    colord.enable = true;

    # An automatic device mounting daemon.
    devmon.enable = true;

    # A DBus service that provides location information for accessing.
    geoclue2.enable = true;

    # A userspace virtual filesystem.
    gvfs.enable = true; # A lot of mpris packages require it.

    # Printing support through the CUPS daemon.
    printing.enable = false; # Enable CUPS to print documents.

    # sysprof profiling daemon.
    sysprof.enable = true; # Whether to enable sysprof profiling daemon.

    logind.extraConfig = ''
      # don’t shutdown when power button is short-pressed
      HandlePowerKey=ignore
    '';
  };
  environment.systemPackages = [
    (pkgs.writeShellScriptBin "toggle-services" ''
      SERVICES=("$@")

      toggleService() {
          SERVICE="$1"

          if [[ ! "$SERVICE" == *".service"* ]]; then SERVICE="''${SERVICE}.service"; fi

          if systemctl list-unit-files "$SERVICE" &>/dev/null; then
              if systemctl is-active --quiet "$SERVICE"; then
                  echo "Stopping \"$SERVICE\"..."
                  sudo systemctl stop "$SERVICE"
              else
                  echo "Starting \"$SERVICE\"..."
                  sudo systemctl start "$SERVICE"
              fi
          else
              echo "\"$SERVICE\" does not exist"
          fi
      }

      # Retain sudo
      trap "exit" INT TERM; trap "kill 0" EXIT; sudo -v || exit $?; sleep 1; while true; do sleep 60; sudo -nv; done 2>/dev/null &

      for i in "''${SERVICES[@]}"
      do
          toggleService "$i"
      done
    '')
  ];
}
