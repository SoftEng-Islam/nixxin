{ pkgs, ... }: {
  environment.systemPackages = with pkgs; [
    # anki # Spaced repetition flashcard program
    audacity # Sound editor with graphical UI
    gparted # Graphical disk partitioning tool
    gromit-mpx # Desktop annotation tool
    obs-studio # Free and open source software for video recording and live streaming
    screenkey # A screencast tool to display your keys inspired by Screenflick
  ];
}
