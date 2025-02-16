{ settings, lib, pkgs, ... }:
let
  inherit (lib) mkIf;
  extensions = with pkgs.vscode-extensions; [
    ms-vscode.cpptools
    ms-vscode.cpptools-extension-pack
    ms-vscode.cmake-tools
    denoland.vscode-deno
    EditorConfig.EditorConfig
    syler.sass-indented
    timonwong.shellcheck
    rangav.vscode-thunder-client
    Vue.volar
    redhat.vscode-yaml
    rogalmic.bash-debug
    mads-hartmann.bash-ide-vscode
    aaron-bond.better-comments
    karunamurti.haml
    naumovs.color-highlight
    batisteo.vscode-django
    dbaeumer.vscode-eslint
    tamasfe.even-better-toml
    GraphQL.vscode-graphql-syntax
    ecmel.vscode-html-css
    oderwat.indent-rainbow
    brunnerh.insert-unicode
    VisualStudioExptTeam.vscodeintellicode
    VisualStudioExptTeam.intellicode-api-usage-examples
    ms-vscode.vscode-typescript-next
    ms-vscode.js-debug-nightly
    Orta.vscode-jest
    andys8.jest-snippets
    wholroyd.jinja
    ms-vsliveshare.vsliveshare
    PKief.material-icon-theme
    ms-vscode.Theme-MaterialKit
    jnoortheen.nix-ide
    christian-kohler.path-intellisense
    csstools.postcss
    esbenp.prettier-vscode
    mohsen1.prettify-json
    Mukundan.python-docs
    chrmarti.regex
    Swellaby.rust-pack
    rust-lang.rust-analyzer
    foxundermoon.shell-format
    bradlc.vscode-tailwindcss
    tauri-apps.tauri-vscode
    be5invis.toml
    oijaz.unicode-latex
    antfu.vite
    njpwerner.autodocstring
    ms-python.autopep8
    ms-python.black-formatter
    streetsidesoftware.code-spell-checker
    ms-python.isort
    DavidAnson.vscode-markdownlint
    ms-python.mypy-type-checker
    davidrockburn.py-pack
    ms-python.vscode-pylance
    ms-python.python
    ms-python.debugpy
    ms-python.vscode-python-envs
    KevinRose.vsc-python-indent
    stuart.unique-window-colors
    eww-yuck.yuck
  ];
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
  home-manager.users.${settings.user.username} = {
    programs.vscode = {
      enable = true;
      mutableExtensionsDir = true;
      extensions = extensions ++ nixpkgs-extensions ++ market-extensions;
      globalSnippets = {
        fixme = {
          body = [ "$LINE_COMMENT FIXME: $0" ];
          description = "Insert a FIXME remark";
          prefix = [ "fixme" ];
        };
      };
      userSettings = {
        "files.autoSave" = "off";
        "[nix]"."editor.tabSize" = 2;
      };
      keybindings = [{
        key = "ctrl+c";
        command = "editor.action.clipboardCopyAction";
        when = "textInputFocus";
      }];
    };
    xdg.mimeApps.associations.removed = { "inode/directory" = "code.desktop"; };
  };
}
