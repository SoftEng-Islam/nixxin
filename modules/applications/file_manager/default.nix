{ settings, lib, pkgs, ... }:
let
  inherit (lib) mkIf;
  _pkgs = with pkgs;
    [ (lib.optional settings.modules.applications.spacedrive pkgs.spacedrive) ];

  _fileManager = [
    (lib.optional settings.modules.applications.fileManagers.nautilus
      ./nautilus.nix)
    (lib.optional settings.modules.applications.fileManagers.thunar
      ./thunar.nix)
    (lib.optional settings.modules.applications.fileManagers.nemo ./nemo.nix)
  ];
in mkIf (settings.modules.applications.file_manager.enable) {
  imports = lib.flatten _fileManager;

  services.gvfs.enable = true; # Mount, trash, and other functionalities
  services.gvfs.package = pkgs.gnome.gvfs;
  services.tumbler.enable = true; # Thumbnail support for images

  home-manager.users.${settings.user.username} = {
    programs.dircolors = { enable = true; };
  };

  environment.systemPackages = with pkgs;
    lib.flatten _pkgs ++ [

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
