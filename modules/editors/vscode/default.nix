{ settings, pkgs, ... }:
let
  nixpkgs-extensions = with pkgs.vscode-extensions; [
    arcticicestudio.nord-visual-studio-code
    esbenp.prettier-vscode
    editorconfig.editorconfig
    elixir-lsp.vscode-elixir-ls
    firefox-devtools.vscode-firefox-debug
    golang.go
    gleam.gleam
    phoenixframework.phoenix
    jnoortheen.nix-ide
    rust-lang.rust-analyzer
    ms-python.python
    ms-python.vscode-pylance
    ms-vscode.cpptools
    ms-vscode.makefile-tools
    ms-vscode.cmake-tools
    ms-vscode.cpptools-extension-pack
    redhat.vscode-xml
    redhat.vscode-yaml
    ryu1kn.partial-diff
    tomoki1207.pdf
  ];
  market-extensions = with pkgs.vscode-marketplace; [
    denoland.vscode-deno
    brian-anders.sublime-duplicate-text
    cardinal90.multi-cursor-case-preserve
    # pkgs.vscode-marketplace."cuelang.org".cue
    pgourlain.erlang
    jakebecker.elixir-ls
    jallen7usa.vscode-cue-fmt
    maximus136.change-string-case
    ms-python.isort
    ms-vscode.sublime-keybindings
    # ms-vscode.cpptools-extension-pack
    nico-castell.linux-desktop-file
    # platformio.platformio-ide
    # unifiedjs.vscode-mdx
    # VisualStudioExptTeam.vscodeintellicode
    xoronic.pestfile
    # silabs.siliconlabssupportextension
    # marus25.cortex-debug
    # mcu-debug.debug-tracker-vscode
    # mcu-debug.memory-view
    # mcu-debug.rtos-views
    # mcu-debug.peripheral-viewer
    antfu.unocss
    bradlc.vscode-tailwindcss
  ];
in {
  environment.systemPackages = with pkgs; [ vscode ];
  home-manager.users.${settings.users.selected.username} = {
    programs.vscode = {
      enable = true;
      mutableExtensionsDir = true;
      extensions = nixpkgs-extensions ++ market-extensions;
      userSettings = { };
    };
    xdg.mimeApps.associations.removed = { "inode/directory" = "code.desktop"; };
  };
}
