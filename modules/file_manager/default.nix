{ settings, lib, pkgs, ... }:
let
  _spacedrive =
    [ (lib.optional settings.system.fileManagers.spacedrive pkgs.spacedrive) ];
  _fileManager = [
    (lib.optional settings.system.fileManagers.nautilus ./nautilus.nix)
    (lib.optional settings.system.fileManagers.thunar ./thunar.nix)
    (lib.optional settings.system.fileManagers.nemo ./nemo.nix)
  ];
in {
  imports = lib.flatten _fileManager;

  services.gvfs.enable = true; # Mount, trash, and other functionalities
  services.gvfs.package = pkgs.gnome.gvfs;
  services.tumbler.enable = true; # Thumbnail support for images

  home-manager.users.${settings.users.selected.username} = {
    programs.dircolors = { enable = true; };
  };

  environment.systemPackages = with pkgs;
    lib.flatten _spacedrive ++ [

      file # A program that shows the type of files
      lsof # Tool to list open files
      patool # portable archive file manager
      rsync # Fast incremental file transfer utility

      # archives
      p7zip
      # unrar # Utility for RAR archives
      # unrar-free # Free utility to extract files from RAR archives
      # unrar-wrapper # Backwards compatibility between unar and unrar
      unzip # An extraction utility for archives compressed in .zip format
      xz
      zip # Compressor/archiver for creating and modifying zipfiles
      # rar # Utility for RAR archives
      # unar # Archive unpacker program
    ];
}
