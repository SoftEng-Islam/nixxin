{ settings, lib, pkgs, ... }:
let
  inherit (lib) mkIf;
  _pkgs = with pkgs;
    [ (lib.optional settings.modules.file_manager.spacedrive pkgs.spacedrive) ];

  _imports = [
    (lib.optional settings.modules.file_manager.nautilus ./nautilus.nix)
    (lib.optional settings.modules.file_manager.thunar ./thunar.nix)
    (lib.optional settings.modules.file_manager.nemo ./nemo.nix)
  ];
in {
  imports = lib.flatten _imports;

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

      # CLI programs required by file-roller
      _7zz
      binutils

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
