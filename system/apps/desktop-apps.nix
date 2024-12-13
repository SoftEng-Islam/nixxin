{ pkgs, ... }: {
  environment.systemPackages = with pkgs; [

    anki # Spaced repetition flashcard program
    gparted # Graphical disk partitioning tool

    audacity # Sound editor with graphical UI
    gromit-mpx # Desktop annotation tool
    obs-studio # Free and open source software for video recording and live streaming
    screenkey # A screencast tool to display your keys inspired by Screenflick

    obsidian # A powerful knowledge base that works on top of a local folder of plain text Markdown files
  ];
}
