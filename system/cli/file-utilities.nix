{ pkgs, ... }: {
  environment.systemPackages = with pkgs; [
    file # Program that shows the type of files
    lsof # Tool to list open files
    rar # Utility for RAR archives
    rsync # Fast incremental file transfer utility
    unar # Archive unpacker program
    unrar-free # Free utility to extract files from RAR archives
    unrar-wrapper # Backwards compatibility between unar and unrar
    zip # Compressor/archiver for creating and modifying zipfiles
  ];
}
