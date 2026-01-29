{ settings, inputs, lib, pkgs, ... }:
let
  inherit (lib) mkIf;
  nixpkgs-extensions = with pkgs.vscode-extensions; [
    ms-vscode.cpptools
    ms-vscode.cpptools-extension-pack
    ms-vscode.cmake-tools
    denoland.vscode-deno
    timonwong.shellcheck
    redhat.vscode-yaml
    mads-hartmann.bash-ide-vscode
    aaron-bond.better-comments
    karunamurti.haml
    naumovs.color-highlight
    batisteo.vscode-django
    dbaeumer.vscode-eslint
    tamasfe.even-better-toml
    ecmel.vscode-html-css
    oderwat.indent-rainbow
    wholroyd.jinja
    ms-vsliveshare.vsliveshare
    jnoortheen.nix-ide
    christian-kohler.path-intellisense
    esbenp.prettier-vscode
    rust-lang.rust-analyzer
    foxundermoon.shell-format
    bradlc.vscode-tailwindcss
    tauri-apps.tauri-vscode
    njpwerner.autodocstring
    ms-python.black-formatter
    streetsidesoftware.code-spell-checker
    ms-python.isort
    ms-python.vscode-pylance
    ms-python.python
    ms-python.debugpy
    arcticicestudio.nord-visual-studio-code
    esbenp.prettier-vscode
    editorconfig.editorconfig
    elixir-lsp.vscode-elixir-ls
    firefox-devtools.vscode-firefox-debug
    golang.go
    gleam.gleam
    phoenixframework.phoenix
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
  market-extensions = with pkgs.vscode-marketplace;
    pkgs.vsx [
      EditorConfig.EditorConfig
      syler.sass-indented
      rangav.vscode-thunder-client
      Vue.volar
      ms-python.isort
      nico-castell.linux-desktop-file
      # antfu.unocss
      bradlc.vscode-tailwindcss
      rogalmic.bash-debug
      GraphQL.vscode-graphql-syntax
      brunnerh.insert-unicode
      VisualStudioExptTeam.vscodeintellicode
      VisualStudioExptTeam.intellicode-api-usage-examples
      ms-vscode.vscode-typescript-next
      ms-vscode.js-debug-nightly
      Orta.vscode-jest
      andys8.jest-snippets
      PKief.material-icon-theme
      ms-vscode.Theme-MaterialKit
      csstools.postcss
      mohsen1.prettify-json
      Mukundan.python-docs
      chrmarti.regex
      Swellaby.rust-pack
      be5invis.toml
      oijaz.unicode-latex
      antfu.vite
      ms-python.autopep8
      DavidAnson.vscode-markdownlint
      ms-python.mypy-type-checker
      davidrockburn.py-pack
      ms-python.vscode-python-envs
      KevinRose.vsc-python-indent
      stuart.unique-window-colors
      eww-yuck.yuck
    ];
in {

  # nixpkgs.overlays = [ inputs.nix-vscode-extensions.overlays.default ];

  home-manager.users.${settings.user.username} = {
    programs.vscode = {
      enable = true;
      package = pkgs.vscode.override {
        commandLineArgs = [
          # "--enable-features=WaylandWindowDecorations"
          "--ozone-platform-hint="
          "--ozone-platform=wayland"
          # make it use GTK_IM_MODULE if it runs with Gtk4, so fcitx5 can work with it.
          # (only supported by chromium/chrome at this time, not electron)
          "--gtk-version=4"
          # make it use text-input-v1, which works for kwin 5.27 and weston
          "--enable-wayland-ime"

          # enable hardware acceleration - vulkan api
          "--enable-features=Vulkan"

          "--ozone-platform-hint=auto"
          "--ozone-platform=wayland"
          # make it use GTK_IM_MODULE if it runs with Gtk4, so fcitx5 can work with it.
          # (only supported by chromium/chrome at this time, not electron)
          "--gtk-version=4"
          # make it use text-input-v1, which works for kwin 5.27 and weston
          "--enable-wayland-ime"

          # TODO: fix https://github.com/microsoft/vscode/issues/187436
          # still not works...
          "--password-store=gnome" # use gnome-keyring as password store
        ];
      }; # vscode or vscodium or  vscode-fhs
      mutableExtensionsDir = true;
      profiles.default = {
        enableExtensionUpdateCheck = true;
        extensions =
          lib.optionals (settings.modules.development.vscode.extensions_home)
          nixpkgs-extensions; # ++ market-extensions;
        globalSnippets =
          mkIf (settings.modules.development.vscode.globalSnippets_home) {
            fixme = {
              body = [ "$LINE_COMMENT FIXME: $0" ];
              description = "Insert a FIXME remark";
              prefix = [ "fixme" ];
            };
          };
        userSettings =
          mkIf (settings.modules.development.vscode.userSettings_home) {
            # This property will be used to generate settings.json:
            # https://code.visualstudio.com/docs/getstarted/settings#_settingsjson
            editor = {
              fontFamily =
                "'CaskaydiaCove Nerd Font','JetBrainsMono Nerd Font'";
              fontLigatures = true;
              fontSize = 14;
              fontWeight = "bold";
              formatOnPaste = true;
              formatOnSave = true;
              cursorBlinking = "expand";
              cursorSmoothCaretAnimation = "explicit";
              cursorWidth = 3;
              inlineSuggest.syntaxHighlightingEnabled = true;
              lineHeight = 25;
              minimap.enabled = false;
              mouseWheelZoom = true;
              occurrencesHighlight = "off";
              renderWhitespace = "all";
              smoothScrolling = true;
              suggest.localityBonus = true;
              tabSize = 4;
            };

            # ---- Window Settings ---- #
            window = {
              menuBarVisibility = "toggle";
              zoomLevel = 1;
              autoDetectColorScheme = true;
            };

            # ---- workbench Settings ---- #
            workbench = {
              colorTheme = "One Dark Pro Darker";
              iconTheme = "material-icon-theme";
              editor.highlightModifiedTabs = true;
              list.smoothScrolling = true;
              sideBar.location = "right";
              startupEditor = "none";
              tips.enabled = true;
              colorCustomizations = {
                # ---- Text Selection ---- #
                # editor.selectionBackground = "#020101"; # Replace with your desired color code
                # editor.selectionHighlightBackground = "#850000bc"; # Optional: for find matches highlight color
                # editor.inactiveSelectionBackground = "#1613beb7";

                # ---- Activity Bar ---- #
                # activityBar.background = "#2a2a2a";
                # activityBar.foreground = "#f90";
                # activityBar.inactiveForeground = "#ffffff";

                # ---- Title Bar ---- #
                # titleBar.activeBackground = "#2a2a2a";
                # titleBar.activeForeground = "#FAFCFC";

                # ---- Status Bar ---- #
                statusBar.background = "#2a2a2a";
                statusBar.border = "#94854eee";
              };
            };

            # ---- Terminal Settings ---- #
            terminal.integrated = {
              cursorBlinking = true;
              cursorStyle = "line";
              smoothScrolling = true;
              gpuAcceleration = "on";
              fontFamily = "CaskaydiaCove Nerd Font";
              enableImages = true;
              fontLigatures = true;
              fontSize = 14;
              fontWeight = "bold";
              cursorWidth = 2;
              cursorStyleInactive = "line";
              environmentChangesRelaunch = false;
              enableMultiLinePasteWarning = "never";
              defaultProfile.linux = "zsh";
            };

            # ---- Files and Explorer ---- #
            files = {
              # associations."*.css" = "tailwindcss";
              associations."*.css" = "css";
              autoSave = "off";
              insertFinalNewline = true;
              trimFinalNewlines = true;
              trimTrailingWhitespace = true;
            };

            explorer = {
              confirmDragAndDrop = false;
              confirmDelete = false;
              confirmPasteNative = false;
            };

            git = {
              autofetch = true;
              confirmSync = false;
            };

            gitlens = {
              codeLens.enabled = false;
              defaultDateFormat = "YYYY-MM-DD HH:mm";
              defaultDateLocale = "system";
              defaultDateShortFormat = "YYYY-M-D";
              defaultTimeFormat = "HH:mm";
              statusBar.enabled = false;

              views.repositories = {
                showContributors = false;
                showStashes = true;
                showTags = false;
                showWorktrees = false;
              };
            };

            intelephense = {
              # environment.phpVersion = "7.4.3";
              # format.braces = "k&r";
            };

            # JavaScript and TypeScript
            "typescript.format.semicolons" = "insert";
            "javascript.format.semicolons" = "insert";
            "javascript.updateImportsOnFileMove.enabled" = "always";
            "javascript.inlayHints.enumMemberValues.enabled" = true;
            "javascript.inlayHints.functionLikeReturnTypes.enabled" = true;
            "javascript.inlayHints.parameterNames.enabled" = "none";
            "javascript.inlayHints.parameterTypes.enabled" = true;
            "javascript.inlayHints.propertyDeclarationTypes.enabled" = true;
            "javascript.inlayHints.variableTypes.enabled" = true;
            "javascript.inlayHints.parameterNames.suppressWhenArgumentMatchesName" =
              true;
            javascript.inlayHints.variableTypes.suppressWhenTypeMatchesName =
              true;
            "typescript.inlayHints.enumMemberValues.enabled" = true;
            "typescript.inlayHints.functionLikeReturnTypes.enabled" = true;
            "typescript.inlayHints.parameterNames.enabled" = "none";
            "typescript.inlayHints.variableTypes.enabled" = true;
            "typescript.inlayHints.propertyDeclarationTypes.enabled" = true;
            "typescript.inlayHints.parameterTypes.enabled" = true;
            typescript.inlayHints.parameterNames.suppressWhenArgumentMatchesName =
              true;
            typescript.inlayHints.variableTypes.suppressWhenTypeMatchesName =
              true;

            # ShellScript
            "[shellscript]" = {
              editor.defaultFormatter = "foxundermoon.shell-format";
            };

            # Update Settings
            update.showReleaseNotes = false;
            update.mode = "manual";
            extensions.autoUpdate = false;
            extensions.autoCheckUpdates = true;
            terminal.explorerKind = "external";

            security.workspace.trust.banner = "never";
            security.workspace.trust.untrustedFiles = "open";

            # Linting
            css.lint.unknownAtRules = "ignore";
            scss.lint.unknownAtRules = "ignore";
            less.lint.unknownAtRules = "ignore";

            # Vite
            vite.autoStart = false;
            vite.https = false;

            # Miscellaneous
            application.shellEnvironmentResolutionTimeout = 60;
            tabnine.experimentalAutoImports = true;
            scm.showHistoryGraph = false;

            "[nix]" = {
              editor.inlayHints.enabled = "on";
              editor.formatOnSave = true;
              editor.tabSize = 2;
              editor.insertSpaces = true;
              editor.defaultFormatter = "jnoortheen.nix-ide";
            };

            "nix.hiddenLanguageServerErrors" = [
              "textDocument/didSave"
              "textDocument/definition"
              "textDocument/completion"
              "textDocument/documentSymbol"
              "workspace/didChangeWatchedFiles"
            ];

            nix.enableLanguageServer = true;
            nix.serverPath = "nixd";
            nix.formatterPath = "nixfmt";
            "nix.serverSettings" = {
              "nixpkgs" = { "expr" = "import <nixpkgs> { }"; };
              "formatting" = {
                "command" = [
                  "nixfmt" # alejandra or nixfmt or nixpkgs-fmt
                ];
              };
            };

            evenBetterToml.formatter.alignComments = false;

            "[css]".editor.defaultFormatter = "esbenp.prettier-vscode";
            "[javascript]".editor.defaultFormatter = "esbenp.prettier-vscode";
            "[typescript]".editor.defaultFormatter = "esbenp.prettier-vscode";
            "[typescriptreact]".editor.defaultFormatter =
              "esbenp.prettier-vscode";
            diffEditor.ignoreTrimWhitespace = false;

            better-comments.highlightPlainText = true;
            debug.allowBreakpointsEverywhere = true;
            search.seedWithNearestWord = true;

            "[conf]" = { editor.formatOnSave = false; };
            "[jsonc]" = {
              editor.defaultFormatter = "vscode.json-language-features";
            };
            "[json]" = {
              editor.defaultFormatter = "vscode.json-language-features";
            };
            # ---- IndentRainbow
            indentRainbow.indicatorStyle = "light";
            indentRainbow.lightIndicatorStyleLineWidth = 2;
            indentRainbow.colors = [
              "rgba(151,208,90,0.59)"
              "rgba(89,152,127,0.75)"
              "rgba(182,173,61,0.79)"
              "rgba(166,51,125,0.89)"
              "rgba(148,236,61,0.54)"
              "rgba(203,64,240,0.75)"
              "rgba(238,214,137,1.0)"
            ];
            workbench.editor.enablePreview = true;
            workbench.settings.openDefaultKeybindings = true;
            editor.bracketPairColorization.independentColorPoolPerBracketType =
              true;
            html.format.wrapLineLength = 0;
            workbench.preferredLightColorTheme = "Material Night Eighties";
            rust-analyzer.rustfmt.overrideCommand = null;
            notebook.breadcrumbs.showCodeCells = false;
            breadcrumbs.showArrays = false;
            breadcrumbs.showBooleans = false;
            breadcrumbs.showClasses = false;
            breadcrumbs.showConstants = false;
            breadcrumbs.showConstructors = false;
            breadcrumbs.showEnumMembers = false;
            breadcrumbs.showEnums = false;
            breadcrumbs.showEvents = false;
            breadcrumbs.showFields = false;
            breadcrumbs.showFunctions = false;
            breadcrumbs.showInterfaces = false;
            breadcrumbs.showKeys = false;
            breadcrumbs.showVariables = false;
            breadcrumbs.showTypeParameters = false;
            breadcrumbs.showStructs = false;
            breadcrumbs.showStrings = false;
            breadcrumbs.showProperties = false;
            breadcrumbs.showPackages = false;
            breadcrumbs.showObjects = false;
            breadcrumbs.showNumbers = false;
            breadcrumbs.showNull = false;
            breadcrumbs.showNamespaces = false;
            breadcrumbs.showModules = false;
            breadcrumbs.showMethods = false;
          };
        keybindings =
          lib.optionals (settings.modules.development.vscode.keybindings_home) [
            # See https://code.visualstudio.com/docs/getstarted/keybindings#_advanced-customization
            {
              key = "shift+cmd+j";
              command = "workbench.action.focusActiveEditorGroup";
              when = "terminalFocus";
            }
            {
              key = "ctrl+c";
              command = "editor.action.clipboardCopyAction";
              when = "textInputFocus";
            }
            {
              key = "alt+down";
              command = "editor.action.moveLinesDownAction";
              when = "editorTextFocus && !editorReadonly";
            }
            {
              key = "alt+up";
              command = "editor.action.moveLinesUpAction";
              when = "editorTextFocus && !editorReadonly";
            }
            {
              key = "ctrl+shift+s";
              command = "editor.action.sortLinesAscending";
            }
            {
              key = "ctrl+shift+r";
              command = "editor.action.removeDuplicateLines";
            }
            {
              key = "ctrl+c";
              command = "workbench.action.terminal.copySelection";
              when =
                "terminalTextSelectedInFocused || terminalFocus && terminalHasBeenCreated && terminalTextSelected || terminalFocus && terminalProcessSupported && terminalTextSelected || terminalFocus && terminalTextSelected && terminalTextSelectedInFocused || terminalHasBeenCreated && terminalTextSelected && terminalTextSelectedInFocused || terminalProcessSupported && terminalTextSelected && terminalTextSelectedInFocused";
            }
            {
              key = "ctrl+shift+c";
              command = "-workbench.action.terminal.copySelection";
              when =
                "terminalTextSelectedInFocused || terminalFocus && terminalHasBeenCreated && terminalTextSelected || terminalFocus && terminalProcessSupported && terminalTextSelected || terminalFocus && terminalTextSelected && terminalTextSelectedInFocused || terminalHasBeenCreated && terminalTextSelected && terminalTextSelectedInFocused || terminalProcessSupported && terminalTextSelected && terminalTextSelectedInFocused";
            }
            {
              key = "ctrl+v";
              command = "workbench.action.terminal.paste";
              when =
                "terminalFocus && terminalHasBeenCreated || terminalFocus && terminalProcessSupported";
            }
            {
              key = "ctrl+shift+v";
              command = "-workbench.action.terminal.paste";
              when =
                "terminalFocus && terminalHasBeenCreated || terminalFocus && terminalProcessSupported";
            }
            {
              key = "ctrl+shift+c";
              command = "-workbench.action.terminal.openNativeConsole";
              when = "!terminalFocus";
            }
            {
              key = "ctrl+k ctrl+c";
              command = "-editor.action.addCommentLine";
              when = "editorTextFocus && !editorReadonly";
            }
          ];
      };
    };
    xdg.mimeApps.associations.removed = { "inode/directory" = "code.desktop"; };
  };

}
