{ pkgs, ... }:

{
  environment.systemPackages = [
    # AI Tools for developers

    # Cursor — AI-powered code editor
    pkgs.update.code-cursor

    # Google Antigravity — agentic IDE
    # Provided by the antigravity-nix overlay (github:jacopone/antigravity-nix).
    # Using the no-fhs variant: autoPatchelfHook instead of buildFHSEnv/bubblewrap,
    # which avoids the kernel "no_new_privileges" flag that would break sudo/pkexec
    # inside the integrated terminal.
    # Wayland flags are already baked into the .desktop entry by the upstream package.
    pkgs.google-antigravity-no-fhs

    # Windsurf — AI-powered code editor by Codeium
    pkgs.update.windsurf
  ];
}
