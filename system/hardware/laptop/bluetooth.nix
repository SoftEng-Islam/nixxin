{ pkgs, ... }: {
  environment.systemPackages = with pkgs; [ bluez bluez-tools ];

  hardware.bluetooth = {
    enable = true;
    package = pkgs.bluez;
    powerOnBoot = false;
    # settings.General.Experimental = false; # for gnome-bluetooth percentage
  };
  # services.blueman.enable = false;
}
