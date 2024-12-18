{ pkgs, ... }: {
  environment.systemPackages = with pkgs; [ wayland wl-clipboard wayvnc ];
  services.xserver = {
    enable = true;
    xkb = {
      variant = "";
      layout = "us,ara";
      options = "grp:win_space_toggle";
    };
    videoDrivers = [ "amdgpu" ];
    displayManager.startx = { enable = false; };
  };
}
