{ settings, lib, pkgs, ... }: {
  # ---- Systemd Boot Manager ---- #
  # NOTE!! disable to use GRUB instead of systemd-boot
  boot.loader.systemd-boot = {
    enable =
      if (settings.boot.loader.manager.name == "SYSTEMD") then true else false;
  };

}
