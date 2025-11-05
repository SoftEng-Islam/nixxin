{ settings, pkgs, ... }: {
  imports = [ ./screen ./sound ];
  environment.systemPackages = with pkgs; [
    gpu-screen-recorder # A screen recorder that has minimal impact on system performance by recording a window using the GPU only
    gpu-screen-recorder-gtk # GTK frontend for gpu-screen-recorder.
  ];
}
