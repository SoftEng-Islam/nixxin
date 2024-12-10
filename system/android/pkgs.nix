{ pkgs, ... }: {
  environment.systemPackages = with pkgs; [
    #__ Android __#
    waydroid # Waydroid is a container-based approach to boot a full Android system on a regular GNU/Linux system like Ubuntu
    scrcpy # Display and control Android devices over USB or TCP/IP
  ];
}
