{pkgs, ...}: {
  environment.systemPackages = with pkgs; [
    # https://github.com/Aider-AI/aider
    aider-chat
  ];
}
