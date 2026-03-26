{
  settings,
  pkgs,
  system,
  config,
  ...
}:
let
  username = settings.user.username;
  nixfmtPackage = if pkgs ? nixfmt then pkgs.nixfmt else pkgs.nixfmt-rfc-style;
  nixFormatter = "${nixfmtPackage}/bin/nixfmt";
in
{
  programs.vscode.defaultEditor = true;

  home-manager.users.${settings.user.username} = {
    programs.vscode = {
      enable = true;

      # use unstable VS Codium because of quick releases and tight version reqs by extensions
      package = pkgs.update.vscode.override {
        # if keyring does not work, try either "libsecret" or "gnome"
        commandLineArgs = ''--password-store=gnome-libsecret'';
      };

      profiles.default = {
        enableExtensionUpdateCheck = false;
        enableUpdateCheck = false;

        keybindings = [
          {
            key = "ctrl+shift+s";
            command = "editor.action.sortLinesAscending";
          }
          {
            key = "ctrl+alt+;";
            command = "editor.action.insertCursorAtEndOfEachLineSelected";
            when = "editorTextFocus";
          }

          {
            key = "ctrl+alt+/";
            command = "editor.action.commentLine";
            when = "editorTextFocus && !editorReadonly";
          }
          {
            key = "ctrl+shift+t";
            command = "workbench.action.terminal.focus";
            when = "!terminalFocus";
          }
          {
            key = "ctrl+shift+t";
            command = "workbench.action.focusActiveEditorGroup";
            when = "terminalFocus";
          }

          # use ctrl+c in the terminal for copying if there's a selection
          # (passed through to the shell otherwise)
          # thanks to https://stackoverflow.com/a/69928270/7659481
          {
            key = "ctrl+c";
            command = "workbench.action.terminal.copySelection";
            when = "terminalFocus && terminalProcessSupported && terminalTextSelected";
          }

          # use ctrl+v in the terminal for pasting
          {
            key = "ctrl+v";
            command = "workbench.action.terminal.paste";
            when = "terminalFocus && terminalProcessSupported";
          }
        ];

        extensions =
          (with (pkgs.forVSCodeVersion config.programs.vscode.package.version).vscode-marketplace; [
            ## Language Support ##
            # bmewburn.vscode-intelephense-client # PHP language support
            # ms-vscode.cpptools-extension-pack # C/C++ extension pack
            be5invis.toml
            bradlc.vscode-tailwindcss # Tailwind CSS IntelliSense
            brettm12345.nixfmt-vscode
            csstools.postcss
            graphql.vscode-graphql-syntax
            jnoortheen.nix-ide # Nix language support
            karunamurti.haml
            mads-hartmann.bash-ide-vscode
            meta.pyrefly
            ms-python.python # Python language support
            ms-vscode.vscode-typescript-next
            redhat.vscode-yaml
            swellaby.rust-pack
            syler.sass-indented
            tamasfe.even-better-toml # TOML language support
            vue.volar

            ## APIs & Data ##
            apollographql.vscode-apollo
            graphql.vscode-graphql
            graphql.vscode-graphql-execution
            rangav.vscode-thunder-client

            ## Linters & Formatters ##
            davidanson.vscode-markdownlint # Markdown Linting
            dbaeumer.vscode-eslint
            esbenp.prettier-vscode # Prettier code formatter
            foxundermoon.shell-format
            ms-python.isort
            timonwong.shellcheck

            ## Testing & Debugging ##
            ms-python.debugpy
            ms-vscode.js-debug-nightly
            orta.vscode-jest
            rogalmic.bash-debug
            vitest.explorer

            ## GIT & AI Tools ##
            # eamodio.gitlens # GitLens
            donjayamanne.githistory # Git History
            github.codespaces # GitHub Codespaces
            github.copilot # GitHub Copilot
            github.vscode-github-actions # GitHub Actions
            kingleo.deepseek-web

            ## Utilities & Editor Enhancements ##
            # arrterian.nix-env-selector # not needed at the moment
            # ritwickdey.liveserver # launch local html web server
            aaron-bond.better-comments
            antfu.vite
            christian-kohler.path-intellisense
            chrmarti.regex
            editorconfig.editorconfig
            ionutvmi.path-autocomplete
            mkhl.direnv # direnv support
            mohsen1.prettify-json
            mukundan.python-docs
            naumovs.color-highlight
            oderwat.indent-rainbow # colorful indentation
            rolandgreim.sharecode # Pastebin/Gist support
            streetsidesoftware.code-spell-checker
            tauri-apps.tauri-vscode
            yzhang.markdown-all-in-one

            ## Theming & UI ##
            # dracula-theme.theme-dracula # Dracula theme
            # enkia.tokyo-night # Tokyo Night theme
            pkief.material-icon-theme # Material Icon Theme
            pkief.material-product-icons # Material Product Icons
            stuart.unique-window-colors
          ])
          ++ (with pkgs.vscode-marketplace-release; [
            github.copilot-chat # GitHub Copilot Chat, need the release version
          ])
          ++ (with pkgs.vscode-marketplace; [
            github.vscode-pull-request-github # GitHub Pull Requests
            ms-vscode-remote.remote-containers # Dev Containers
            ms-python.vscode-python-envs # commented out as it is currently missing

          ])
          ++ (with pkgs.vscode-extensions; [
            # ms-vscode.cpptools # C/C++ language support, only available via nixpkgs
          ]);

        userSettings = {
          "[css]" = {
            "editor.defaultFormatter" = "vscode.css-language-features";
          };
          "[json]" = {
            "editor.defaultFormatter" = "vscode.json-language-features";
          };
          "[jsonc]" = {
            "editor.defaultFormatter" = "vscode.json-language-features";
          };

          "[markdown]" = {
            "editor.insertSpaces" = true;
            "editor.tabSize" = 2;
            "editor.wordWrap" = "bounded";
            "editor.defaultFormatter" = "DavidAnson.vscode-markdownlint";
          };
          "[nix]" = {
            "editor.defaultFormatter" = "brettm12345.nixfmt-vscode";
            "editor.formatOnSave" = true;
            "editor.inlayHints.enabled" = "on";
            "editor.insertSpaces" = true;
            "editor.tabSize" = 2;
          };

          "[python]" = {
            "editor.insertSpaces" = true;
          };
          "[shellscript]" = {
            "editor.defaultFormatter" = "mads-hartmann.bash-ide-vscode";
          };
          "[typescript]" = {
            "editor.defaultFormatter" = "esbenp.prettier-vscode";
          };
          "[typescriptreact]" = {
            "editor.defaultFormatter" = "esbenp.prettier-vscode";
          };
          "[vue]" = {
            "editor.defaultFormatter" = "Vue.volar";
          };
          "application.shellEnvironmentResolutionTimeout" = 60;
          "better-comments.highlightPlainText" = true;
          "better-comments.multilineComments" = true;
          "better-comments.tags" = [
            {
              "tag" = "!";
              "color" = "#FF2D00";
              "strikethrough" = false;
              "underline" = false;
              "backgroundColor" = "transparent";
              "bold" = false;
              "italic" = false;
            }
            {
              "tag" = "#";
              "color" = "#090";
              "strikethrough" = false;
              "underline" = false;
              "backgroundColor" = "transparent";
              "bold" = false;
              "italic" = true;
            }
            {
              "tag" = "?";
              "color" = "#3498DB";
              "strikethrough" = false;
              "underline" = false;
              "backgroundColor" = "transparent";
              "bold" = false;
              "italic" = false;
            }
            {
              "tag" = "//";
              "color" = "#474747";
              "strikethrough" = true;
              "underline" = false;
              "backgroundColor" = "transparent";
              "bold" = false;
              "italic" = false;
            }
            {
              "tag" = "todo";
              "color" = "#FF8C00";
              "strikethrough" = false;
              "underline" = false;
              "backgroundColor" = "transparent";
              "bold" = false;
              "italic" = false;
            }
            {
              "tag" = "*";
              "color" = "#98C379";
              "strikethrough" = false;
              "underline" = false;
              "backgroundColor" = "transparent";
              "bold" = false;
              "italic" = false;
            }
          ];
          # breadcrumbs
          "breadcrumbs.enabled" = true;
          "breadcrumbs.showArrays" = false;
          "breadcrumbs.showBooleans" = false;
          "breadcrumbs.showClasses" = false;
          "breadcrumbs.showConstants" = false;
          "breadcrumbs.showConstructors" = false;
          "breadcrumbs.showEnumMembers" = false;
          "breadcrumbs.showEnums" = false;
          "breadcrumbs.showEvents" = false;
          "breadcrumbs.showFields" = false;
          "breadcrumbs.showFunctions" = false;
          "breadcrumbs.showInterfaces" = false;
          "breadcrumbs.showKeys" = false;
          "breadcrumbs.showMethods" = false;
          "breadcrumbs.showModules" = false;
          "breadcrumbs.showNamespaces" = false;
          "breadcrumbs.showNull" = false;
          "breadcrumbs.showNumbers" = false;
          "breadcrumbs.showObjects" = false;
          "breadcrumbs.showPackages" = false;
          "breadcrumbs.showProperties" = false;
          "breadcrumbs.showStrings" = false;
          "breadcrumbs.showStructs" = false;
          "breadcrumbs.showTypeParameters" = false;
          "breadcrumbs.showVariables" = false;
          "chat.agent.thinking.collapsedTools" = "withThinking";
          "chat.edits2.enabled" = true;
          "chat.emptyState.history.enabled" = true;
          "css.lint.boxModel" = "warning";
          "dart.checkForSdkUpdates" = false;
          "dart.updateDevTools" = false;
          "debug.allowBreakpointsEverywhere" = true;

          "diffEditor.diffAlgorithm" = "advanced";
          "diffEditor.experimental.showMoves" = true;
          "diffEditor.ignoreTrimWhitespace" = false;
          "direnv.restart.automatic" = true; # Automatically restart direnv if .envrc changes
          "editor.acceptSuggestionOnCommitCharacter" = false;
          "editor.acceptSuggestionOnEnter" = "on";
          "editor.bracketPairColorization.enabled" = true;
          "editor.bracketPairColorization.independentColorPoolPerBracketType" = true;
          "editor.copyWithSyntaxHighlighting" = false;
          "editor.cursorBlinking" = "expand";
          "editor.cursorSmoothCaretAnimation" = "explicit";
          "editor.cursorWidth" = 3;
          "editor.defaultFormatter" = "esbenp.prettier-vscode";
          "editor.detectIndentation" = true;
          # Primary programming fonts with nerd font glyphs support
          "editor.fontFamily" = "'CaskaydiaCove Nerd Font','JetBrainsMono Nerd Font'";
          "editor.fontLigatures" = true;
          "editor.fontSize" = 16;
          "editor.fontWeight" = "normal";
          "editor.formatOnPaste" = true;
          # Automatically format the file when saving
          "editor.formatOnSave" = true;
          "editor.guides.bracketPairs" = true;
          "editor.inlineSuggest.enabled" = false;
          "editor.inlineSuggest.syntaxHighlightingEnabled" = true;
          "editor.insertSpaces" = false;
          "editor.language.brackets" = [
            [
              "["
              "]"
            ]
            [
              "{"
              "}"
            ]
            [
              "("
              ")"
            ]
            [
              "⟨"
              "⟩"
            ]
          ];
          "editor.quickSuggestions" = {
            "comments" = false;
            "other" = false;
            "strings" = false;
          };
          "editor.lineHeight" = 25;
          "editor.minimap.enabled" = false;
          "editor.mouseWheelZoom" = true;
          "editor.occurrencesHighlight" = "off";
          "editor.renderWhitespace" = "all";
          "editor.rulers" = [
            100
          ];
          "editor.scrollbar.vertical" = "visible";
          "editor.scrollbar.verticalScrollbarSize" = 18;
          "editor.smoothScrolling" = true;
          "editor.stickyScroll.enabled" = false;
          "editor.suggest.localityBonus" = true;
          "editor.suggest.preview" = true;
          "editor.suggestSelection" = "recentlyUsed";
          "editor.tabSize" = 4;
          "editor.unicodeHighlight.allowedCharacters" = {
            "×" = true;
            "α" = true;
            "γ" = true;
            "ι" = true;
            "ρ" = true;
            "σ" = true;
            "ℓ" = true;
            "ℕ" = true;
            "ℚ" = true;
            "ℝ" = true;
            "ℤ" = true;
            "∨" = true;
          };
          # Wrap lines if they exceed the editor window width
          "editor.wordWrap" = "on";
          "editor.wordWrapColumn" = 100;
          "explorer.confirmDragAndDrop" = false;
          "explorer.confirmPasteNative" = true;
          "extensions.autoCheckUpdates" = false;
          "extensions.autoUpdate" = false;
          "files.associations" = {
            "*.css" = "css";
            "appsettings*.json" = "jsonc";
          };
          "files.autoSave" = "off";
          "files.enableTrash" = false;
          "files.insertFinalNewline" = true;
          "files.trimFinalNewlines" = true;
          "files.trimTrailingWhitespace" = true;
          "files.watcherExclude" = {
            "**/.ammonite" = true;
            "**/.bloop" = true;
            "**/.metals" = true;
          };
          "git" = {
            "autofetch" = true;
            "confirmSync" = false;
          };
          "git.allowForcePush" = true;
          # Automatically run git fetch periodically
          "git.autofetch" = "all";
          "git.autofetchPeriod" = 120;
          "git.closeDiffOnOperation" = true;
          "git.confirmForcePush" = false;
          "git.confirmSync" = false;
          "git.enableSmartCommit" = true;
          "github.copilot.nextEditSuggestions.enabled" = true;
          "gitlens" = {
            "codeLens" = {
              "enabled" = false;
            };
            "defaultDateFormat" = "YYYY-MM-DD HH:mm";
            "defaultDateLocale" = "system";
            "defaultDateShortFormat" = "YYYY-M-D";
            "defaultTimeFormat" = "HH:mm";
            "statusBar" = {
              "enabled" = false;
            };
            "views" = {
              "repositories" = {
                "showContributors" = false;
                "showStashes" = true;
                "showTags" = false;
                "showWorktrees" = false;
              };
            };
          };
          "gitlens.ai.enabled" = false;
          "gitlens.codeLens.enabled" = false;
          "gitlens.defaultDateFormat" = "YYYY-MM-DD HH=mm";
          "gitlens.defaultDateLocale" = null;
          "gitlens.defaultDateShortFormat" = "YYYY-MM-DD";
          "gitlens.defaultDateStyle" = "absolute";
          "gitlens.defaultTimeFormat" = "HH=mm";
          "gitlens.launchpad.indicator.enabled" = false;
          "gitlens.plusFeatures.enabled" = false;
          "gitlens.showWelcomeOnInstall" = false;
          "gitlens.showWhatsNewAfterUpgrades" = false;
          "haskell.manageHLS" = "PATH";
          "html.format.wrapLineLength" = 0;
          "indentRainbow.colors" = [
            "hsl(271, 60%, 50%)"
            "hsl(142, 60%, 50%)"
            "hsl(217, 60%, 50%)"
            "hsl(45, 60%, 50%)"
            "hsl(330, 60%, 50%)"
          ];
          "indentRainbow.indicatorStyle" = "light";
          # The indent color if the number of spaces is not a multiple of "tabSize".
          "indentRainbow.errorColor" = "rgba(128,32,32,0.6)";
          # The indent color when there is a mix between spaces and tabs.
          # To be disabled this coloring set this to an empty string.
          "indentRainbow.lightIndicatorStyleLineWidth" = 3;
          "indentRainbow.tabmixColor" = "rgba(128,32,96,0.6)";
          "ipynb.experimental.serialization" = false;
          "js/ts.format.semicolons" = "insert";
          "js/ts.inlayHints.enumMemberValues.enabled" = true;
          "js/ts.inlayHints.functionLikeReturnTypes.enabled" = true;
          "js/ts.inlayHints.parameterNames.enabled" = "none";
          "js/ts.inlayHints.parameterNames.suppressWhenArgumentMatchesName" = true;
          "js/ts.inlayHints.parameterTypes.enabled" = true;
          "js/ts.inlayHints.propertyDeclarationTypes.enabled" = true;
          "js/ts.inlayHints.variableTypes.enabled" = true;
          "js/ts.inlayHints.variableTypes.suppressWhenTypeMatchesName" = true;
          "js/ts.updateImportsOnFileMove.enabled" = "always";
          "keyboard.dispatch" = "keyCode";
          "less.lint.boxModel" = "warning";
          "less.lint.unknownAtRules" = "ignore";
          "markdown-kroki.url" = "https://diagrams.eisfunke.com";
          "markyMarkdown.statsItemSeparator" = " / ";
          "markyMarkdown.statsShowCharacters" = true;
          "markyMarkdown.statsShowReadingTime" = false;
          "markyMarkdown.statsShowWords" = true;
          "mypy.enabled" = false;
          "mypy.extraArguments" = [
            "--exclude"
            "result.*/"
          ];
          "rewrap.wrappingColumn" = 100;
          # Explicitly set the absolute path to the nil language server
          "nix.serverPath" = "${pkgs.nil}/bin/nil";
          # GUI apps do not always inherit the same PATH as the shell.
          "nix.formatterPath" = nixFormatter;
          "nix.showNixOSOptions" = true;
          "nix.serverSettings" = {
            "nil" = {
              "diagnostics" = {
                "ignored" = [
                  "unused_binding"
                  "unused_with"
                  "dead_code"
                ];
              };
              "formatting" = {
                "command" = [ nixFormatter ];
              };
            };
          };
          "nixEnvSelector.useFlakes" = true;
          "notebook.defaultFormatter" = "esbenp.prettier-vscode";
          "rust-analyzer.rustfmt.overrideCommand" = null;
          "scss.lint.boxModel" = "warning";
          "scss.lint.unknownAtRules" = "ignore";
          "search.seedWithNearestWord" = true;
          "security.workspace.trust.banner" = "never";
          "security.workspace.trust.enabled" = false;
          "security.workspace.trust.untrustedFiles" = "open";
          # Set up nil as Nix language server.
          "nix.enableLanguageServer" = true;
          "terminal.explorerKind" = "external";
          "terminal.integrated.commandsToSkipShell" = [
            "workbench.action.toggleSidebarVisibility"
          ];
          "terminal.integrated.minimumContrastRatio" = 1;
          "terminal.integrated.cursorBlinking" = true;
          "terminal.integrated.cursorStyle" = "line";
          "terminal.integrated.cursorStyleInactive" = "line";
          "terminal.integrated.cursorWidth" = 2;
          "terminal.integrated.defaultProfile.linux" = "zsh";
          "terminal.integrated.enableImages" = true;
          "terminal.integrated.enableMultiLinePasteWarning" = "never";
          "terminal.integrated.environmentChangesRelaunch" = false;
          "terminal.integrated.fontFamily" = "Fira Code";
          "terminal.integrated.fontLigatures.enabled" = true;
          "terminal.integrated.fontSize" = 14;
          "terminal.integrated.fontWeight" = "bold";
          "terminal.integrated.gpuAcceleration" = "on";
          "terminal.integrated.scrollback" = 5000;
          "terminal.integrated.smoothScrolling" = true;
          "terminal.integrated.tabs.enabled" = false;
          "todo-tree.general.showActivityBarBadge" = true;
          "todo-tree.general.tags" = [
            "TODO"
            "FIXME"
          ];
          "todo-tree.regex.regex" = "(^|\\s|//|#|<!--|;|/\\*)($TAGS)(:|\\s|$)";
          "update.mode" = "manual";
          "update.showReleaseNotes" = false;
          "vite.autoStart" = false;
          "vite.https" = false;
          "window.autoDetectColorScheme" = true;
          "window.commandCenter" = false;
          "window.customTitleBarVisibility" = "never";
          "window.menuBarVisibility" = "toggle";
          "window.titleBarStyle" = "native";
          # Preferred color theme for the editor interface
          "workbench.colorTheme" = "Monokai Pro";
          "workbench.editor.enablePreview" = true;
          "workbench.editor.highlightModifiedTabs" = true;
          "workbench.iconTheme" = "material-icon-theme";
          "workbench.productIconTheme" = "material-product-icons";
          "workbench.layoutControl.enabled" = false;
          "workbench.list.smoothScrolling" = true;
          "workbench.preferredDarkColorTheme" = "Default Dark Modern";
          "workbench.preferredLightColorTheme" = "Default Light Modern";
          "workbench.secondarySideBar.defaultVisibility" = "hidden";
          "workbench.settings.openDefaultKeybindings" = true;
          "workbench.sideBar.location" = "left";
          "workbench.startupEditor" = "none";
          "workbench.tips.enabled" = true;
          "zenMode.fullScreen" = false;
        };
      };
    };
  };
}
