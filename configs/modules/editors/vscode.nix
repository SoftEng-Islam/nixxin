{ settings, pkgs, ... }: {
  environment.systemPackages = with pkgs; [ vscode ];
  home-manager.users.${settings.username} = {
    programs.vscode = {
      enable = true;
      extensions = [ ];
      userSettings = {
        "chat.editor.fontFamily": "CaskaydiaCove Nerd Font Mono",
        "chat.editor.fontSize": 16.0,
        "debug.console.fontFamily": "CaskaydiaCove Nerd Font Mono",
        "debug.console.fontSize": 16.0,
        "editor.fontFamily": "CaskaydiaCove Nerd Font Mono",
        "editor.fontSize": 16.0,
        "editor.inlayHints.fontFamily": "CaskaydiaCove Nerd Font Mono",
        "editor.inlineSuggest.fontFamily": "CaskaydiaCove Nerd Font Mono",
        "editor.minimap.sectionHeaderFontSize": 10.285714285714286,
        "markdown.preview.fontFamily": "Noto Sans",
        "markdown.preview.fontSize": 16.0,
        "scm.inputFontFamily": "CaskaydiaCove Nerd Font Mono",
        "scm.inputFontSize": 14.857142857142858,
        "screencastMode.fontSize": 64.0,
        "terminal.integrated.fontSize": 16.0,
        "workbench.colorTheme": "Stylix"
        # ---- Editor ---- #
        "editor.fontFamily": "${settings.fontName}";
        "editor.fontLigatures": true;
        "editor.fontWeight": "600";
        "editor.fontSize": 20;
        "editor.lineHeight": 35;
        "editor.cursorWidth": 3;
        "editor.cursorBlinking": "expand";
        "editor.cursorSmoothCaretAnimation": "explicit";
        "editor.smoothScrolling": true;
        "editor.renderWhitespace": "all";
        "editor.minimap.enabled": false;
        "editor.mouseWheelZoom": true;
        "editor.occurrencesHighlight": "off";
        "editor.suggest.localityBonus": true;
        "editor.inlineSuggest.syntaxHighlightingEnabled": true;

        # ---- window ---- #
        "window.autoDetectColorScheme": true;
        "workbench.editor.highlightModifiedTabs": true;
        "workbench.sideBar.location": "right";
        "workbench.colorCustomizations": {
          ## Text Selection
          # "editor.selectionBackground": "#020101"; // Replace with your desired color code
          # "editor.selectionHighlightBackground": "#850000bc"; // Optional: for find matches highlight color
          # "editor.inactiveSelectionBackground": "#1613beb7";
          ## Activity Bar
          # "activityBar.background": "#2a2a2a";
          # "activityBar.foreground":"#f90";
          # "activityBar.inactiveForeground":"#ffffff";
          ## Title Bar
          # "titleBar.activeBackground": "#2a2a2a";
          # "titleBar.activeForeground": "#FAFCFC";
          ## Status Bar
          # "statusBar.background": "#2a2a2a";
          # "statusBar.border": "#94854eee";
        };
        # ---- Terminal Settings ---- #
        "terminal.integrated.enableImages": true;
        "terminal.integrated.fontFamily": "${settings.fontName}";
        "terminal.integrated.cursorBlinking": true;
        "terminal.integrated.cursorWidth": 2;
        "terminal.integrated.cursorStyle": "line";
        "terminal.integrated.cursorStyleInactive": "line";
        "terminal.integrated.environmentChangesRelaunch": false;
        "terminal.integrated.enableMultiLinePasteWarning": "never";
        "terminal.integrated.defaultProfile.linux": "zsh";
        # ---- Files and Explorer ---- #
        "files.trimTrailingWhitespace": true;
        "explorer.confirmDragAndDrop": false;
        "explorer.confirmDelete": false;
        "better-comments.highlightPlainText": true;
        "debug.allowBreakpointsEverywhere": true;
        "search.seedWithNearestWord": true;
        # ---- JS & TS ---- #
        "typescript.format.semicolons": "insert";
        "javascript.format.semicolons": "insert";
        "javascript.updateImportsOnFileMove.enabled": "always";
        # ---- Linting ---- #
        "css.lint.unknownAtRules": "ignore";
        "scss.lint.unknownAtRules": "ignore";
        "less.lint.unknownAtRules": "ignore";
        // Vite
        "vite.autoStart": false;
        "vite.https": false;
        // Miscellaneous
        "application.shellEnvironmentResolutionTimeout": 60;
        "tabnine.experimentalAutoImports": true;
        // Update Settings
        "update.showReleaseNotes": false;
        "update.mode": "manual";
        "extensions.autoUpdate": false;
        "extensions.autoCheckUpdates": true;
        "terminal.explorerKind": "external";
        "security.workspace.trust.banner": "never";
        "security.workspace.trust.untrustedFiles": "open";
        "explorer.confirmPasteNative": false;
        "javascript.inlayHints.enumMemberValues.enabled": true;
        "javascript.inlayHints.functionLikeReturnTypes.enabled": true;
        "javascript.inlayHints.parameterNames.enabled": "none";
        "javascript.inlayHints.parameterTypes.enabled": true;
        "javascript.inlayHints.propertyDeclarationTypes.enabled": true;
        "javascript.inlayHints.variableTypes.enabled": true;
        "javascript.inlayHints.parameterNames.suppressWhenArgumentMatchesName": true;
        "javascript.inlayHints.variableTypes.suppressWhenTypeMatchesName": true;
        "typescript.inlayHints.enumMemberValues.enabled": true;
        "typescript.inlayHints.functionLikeReturnTypes.enabled": true;
        "typescript.inlayHints.parameterNames.enabled": "none";
        "typescript.inlayHints.variableTypes.enabled": true;
        "typescript.inlayHints.propertyDeclarationTypes.enabled": true;
        "typescript.inlayHints.parameterTypes.enabled": true;
        "typescript.inlayHints.parameterNames.suppressWhenArgumentMatchesName": true;
        "typescript.inlayHints.variableTypes.suppressWhenTypeMatchesName": true;
        // ShellScript
        "[shellscript]": {
          "editor.defaultFormatter": "mads-hartmann.bash-ide-vscode"
        };
        "[nix]": {
          "diffEditor.wordWrap": "off";
          "editor.wordWrap": "off";
          "editor.wordWrapColumn": 1000;
          "editor.wordBreak": "keepAll";
          "editor.formatOnSave": true;
          "editor.tabSize": 2;
          "editor.insertSpaces": true;
          "editor.defaultFormatter": "jnoortheen.nix-ide"
        };
        "[nix]"."editor.tabSize" = 2;
        "nix.hiddenLanguageServerErrors": [
          "textDocument/definition";
          "textDocument/documentSymbol"
        ];
        "nix.enableLanguageServer": true; // Enable LSP.
        "nix.serverPath": "nixd"; // nixd or nil
        "nix.formatterPath": "nixpkgs-fmt"; // or "nixpkgs-fmt" or ["treefmt", "--stdin", "{file}"]
        // or using flakes with `formatter = pkgs.alejandra;`
        // "nix.formatterPath": ["nix", "fmt", "--", "--"]
        "nix.serverSettings": {
          // Control the diagnostic system
          "diagnostic": {
            "suppress": [
              "sema-extra-with"
            ]
          };
          "nil": {
            "formatting": {
              "command": [
                "nixfmt"
              ]
            };
            "diagnostic": {
              "ignored": [
                "unused_binding";
                "unused_with"
              ]
            };
            "nix": {
              # Example: "/run/current-system/sw/bin/nix"
              "binary": "nix";

              "maxMemoryMB": 2560;
              "flake": {
                "autoArchive": null;
                "autoEvalInputs": true;
                "nixpkgsInputName": "nixpkgs";
              }
            }
          };
          "nixpkgs": {
            "expr": "import <nixpkgs> { }"
          };
          "formatting": {
            "command": [
              "nixfmt" // alejandra or nixfmt or nixpkgs-fmt
            ];
          };
        };
        "[conf]": {
          "editor.formatOnSave": false;
        };
        "javascript.suggest.enabled": true;
        "javascript.validate.enable": true;
        "[jsonc]": {
          "editor.defaultFormatter": "vscode.json-language-features"
        };
        "[json]": {
          "editor.defaultFormatter": "vscode.json-language-features"
        };
        // IndentRainbow
        "indentRainbow.indicatorStyle": "light";
        "indentRainbow.lightIndicatorStyleLineWidth": 2;
        "indentRainbow.colors": [
          "rgba(151,208,90,0.59)",
          "rgba(89,152,127,0.75)",
          "rgba(182,173,61,0.79)",
          "rgba(166,51,125,0.89)",
        ];
        "files.associations": {
          "*.css": "css"
        };
        "workbench.editor.enablePreview": true;
        "workbench.settings.openDefaultKeybindings": true;
        "workbench.preferredDarkColorTheme": "Rosé Pine";
        "workbench.iconTheme": "material-icon-theme";
        "editor.bracketPairColorization.independentColorPoolPerBracketType": true;
        "html.format.wrapLineLength": 0;
        "window.menuBarVisibility": "hidden";
      };
    };
  };
}
