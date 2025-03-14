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
      enableExtensionUpdateCheck = true;
      extensions = extensions ++ nixpkgs-extensions ++ market-extensions;
      globalSnippets = {
        fixme = {
          body = [ "$LINE_COMMENT FIXME: $0" ];
          description = "Insert a FIXME remark";
          prefix = [ "fixme" ];
        };
      };
      userSettings = {
        editor = {
          fontFamily = "'CaskaydiaCove Nerd Font','JetBrainsMono Nerd Font'";
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
          zoomLevel = 5;
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
        javascript.inlayHints.variableTypes.suppressWhenTypeMatchesName = true;
        "typescript.inlayHints.enumMemberValues.enabled" = true;
        "typescript.inlayHints.functionLikeReturnTypes.enabled" = true;
        "typescript.inlayHints.parameterNames.enabled" = "none";
        "typescript.inlayHints.variableTypes.enabled" = true;
        "typescript.inlayHints.propertyDeclarationTypes.enabled" = true;
        "typescript.inlayHints.parameterTypes.enabled" = true;
        typescript.inlayHints.parameterNames.suppressWhenArgumentMatchesName =
          true;
        typescript.inlayHints.variableTypes.suppressWhenTypeMatchesName = true;

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
        "[typescriptreact]".editor.defaultFormatter = "esbenp.prettier-vscode";
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
      keybindings = [
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
    xdg.mimeApps.associations.removed = { "inode/directory" = "code.desktop"; };
  };
}
