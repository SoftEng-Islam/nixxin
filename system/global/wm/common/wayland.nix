{ pkgs, ... }: {
  environment.systemPackages = [ pkgs.wayland pkgs.wl-clipboard ];
  services.xserver = {
    enable = true;
    xkb = {
      variant = "";
      layout = "us,ara";
      options = "grp:win_space_toggle";
    };
    videoDrivers = [ "amdgpu" ];
    displayManager.startx = { enable = true; };
  };
}
