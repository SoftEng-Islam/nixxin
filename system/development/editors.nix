{ pkgs, ... }: {
  environment.systemPackages = with pkgs; [
    gedit # Former GNOME text editor
    vscode # Open source source code editor developed by Microsoft for Windows, Linux and macOS
    zed-editor # Zed editor (like vscode)
  ];
}
