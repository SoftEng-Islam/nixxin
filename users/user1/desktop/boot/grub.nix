{ settings, lib, pkgs, ... }: {
  boot.loader. # Grub boot
  grub = {
    enable =
      if (settings.boot.loader.manager.name == "GRUB") then true else false;

    fontSize = settings.boot.loader.manager.grub.fontSize;
    # theme = settings.boot.loader.manager.grub.theme;
    efiSupport = settings.boot.loader.manager.grub.efiSupport;
    gfxmodeEfi = settings.boot.loader.manager.grub.gfxmodeEfi;
    devices = settings.boot.loader.manager.grub.devices;
    device = settings.boot.loader.manager.grub.device;
    useOSProber = settings.boot.loader.manager.grub.osProber;
    extraConfig = settings.boot.loader.manager.grub.extraConfig;
    # extraEntries = ''
    #   menuentry 'Arch Linux' {
    #   	insmod part_gpt
    #   	insmod ext2
    #   	search --no-floppy --fs-uuid --set=root d8ac40a1-c821-402f-b593-baf82f4efc31
    #   	linux /boot/vmlinuz-linux root=UUID=d8ac40a1-c821-402f-b593-baf82f4efc31 rw
    #   	initrd /boot/initramfs-linux.img
    #   }

    #   menuentry 'Windows Boot Manager (on /dev/sdb2)' --class windows --class os $menuentry_id_option 'osprober-efi-0AEE-1E17' {
    #   	insmod part_gpt
    #   	insmod fat
    #   	set root='hd0,gpt1'
    #   	if [ x$feature_platform_search_hint = xy ]; then
    #   	  search --no-floppy --fs-uuid --set=root --hint-bios=hd0,gpt1 --hint-efi=hd0,gpt1 --hint-baremetal=ahci0,gpt1  0AEE-1E17
    #   	else
    #   	  search --no-floppy --fs-uuid --set=root 0AEE-1E17
    #   	fi
    #   	chainloader /EFI/Microsoft/Boot/bootmgfw.efi
    #   }
    # '';
  };
  environment.systemPackages = with pkgs; [
    os-prober
    grub2_efi
    grub2_full
    sleek-grub-theme
    nixos-grub2-theme
  ];
}
