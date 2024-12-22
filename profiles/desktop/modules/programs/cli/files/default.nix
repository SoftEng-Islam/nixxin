{ pkgs, ... }: {
  environment.systemPackages = with pkgs; [
    file # A program that shows the type of files
    lsof # Tool to list open files
    patool # portable archive file manager
    rsync # Fast incremental file transfer utility
    unrar-free # Free utility to extract files from RAR archives
    unrar-wrapper # Backwards compatibility between unar and unrar
    unzip # An extraction utility for archives compressed in .zip format
    zip # Compressor/archiver for creating and modifying zipfiles
  ];
}
