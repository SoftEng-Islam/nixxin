{ pkgs, ... }: {
  imports = [ ./zathura.nix ];

  home.packages = with pkgs;
    [
      # libreoffice # Comprehensive, professional-quality productivity suite, a variant of openoffice.org
      # obsidian # Powerful knowledge base that works on top of a local folder of plain text Markdown files
      # # rnote # Simple drawing application to create handwritten notes
      # xournalpp # Xournal++ is a handwriting Notetaking software with PDF annotation support
    ];
}
