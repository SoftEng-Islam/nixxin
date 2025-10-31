{ settings, lib, pkgs, ... }: {
  # It depends on your monitor and GPU driver support.
  # Details:
  # External LCD Monitor over VGA/DVI/HDMI/DisplayPort:
  # If the monitor has no DDC/CI support, you cannot control brightness via software.
  # If it does support DDC/CI (Display Data Channel Command Interface), you can use tools like:
  # => ddcutil
  # => ddccontrol (less maintained)
  # Check if your monitor supports DDC/CI:
  # $ ddcutil detect
  # If it returns info about your monitor,
  # software brightness control is possible.
  # Otherwise, only hardware buttons will work.

  boot.kernelModules = [
    "i2c-dev"
    "i2c-i801"
  ]; # i2c-i801 for Intel chipsets; use your actual hardware module
  hardware.i2c.enable = true; # Enables support for i2c tools

  services.udev.extraRules = ''
    KERNEL=="i2c-[0-9]*", MODE="0660", GROUP="i2c"
  '';

  users.users.${settings.user.username} = {
    extraGroups = [ "i2c" ]; # Add "i2c" group
  };

}
