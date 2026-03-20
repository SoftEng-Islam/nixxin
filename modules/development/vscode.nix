{
  settings,
  pkgs,
  inputs,
  system,
  osConfig,
  config,
  self,
  ...
}:
let
  myOptions = "(builtins.getFlake \"${self}\").nixosConfigurations.${settings.system.hostName}.options";

  # extract package pname for each package in the list of all installed packages, then put them in a list
  packagesList = map (x: x.pname) (config.home.packages ++ osConfig.environment.systemPackages);

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
        ## Language support ##
        jnoortheen.nix-ide # Nix language support
        # ms-python.python # Python language support
        # ms-vscode.cpptools-extension-pack # C/C++ extension pack
        tamasfe.even-better-toml # TOML language support
        # bmewburn.vscode-intelephense-client # PHP language support
        bradlc.vscode-tailwindcss # Tailwind CSS IntelliSense

        ## Linters ##
        esbenp.prettier-vscode # Prettier code formatter
        davidanson.vscode-markdownlint # Markdown Linting

        ## GIT Tools ##
        github.copilot # GitHub Copilot
        github.codespaces # GitHub Codespaces
        github.vscode-github-actions # GitHub Actions
        donjayamanne.githistory # Git History
        # eamodio.gitlens # GitLens

        rolandgreim.sharecode # Pastebin/Gist support
        # ritwickdey.liveserver # launch local html web server
        mkhl.direnv # direnv support
        oderwat.indent-rainbow # colorful indentation
        # arrterian.nix-env-selector # not needed at the moment

        ## THEMING ##
        # dracula-theme.theme-dracula # Dracula theme
        # enkia.tokyo-night # Tokyo Night theme
        robbowen.synthwave-vscode # SynthWave '84 theme
        pkief.material-icon-theme # Material Icon Theme
        pkief.material-product-icons # Material Product Icons
      ])
      ++ (with pkgs.vscode-marketplace-release; [
        github.copilot-chat # GitHub Copilot Chat, need the release version
      ])
      ++ (with pkgs.vscode-marketplace; [
        ms-vscode-remote.remote-containers # Dev Containers

        github.vscode-pull-request-github # GitHub Pull Requests
      ])
      ++ (with pkgs.vscode-extensions; [
        # ms-vscode.cpptools # C/C++ language support, only available via nixpkgs
      ]);

        userSettings = {
          "direnv.restart.automatic" = true; # Automatically restart direnv if .envrc changes

          /*
            Set up nixd as Nix language server.

            Note: I tried to get the home-manager options directly from the home config inside the NixOS
            config, but I didn't find an exposed `options` there anywhere. So that's why I've added the
            plain home-manager configs to the flake.
          */
          "nix.enableLanguageServer" = true;
          "nix.serverPath" = "${pkgs.nixd}/bin/nixd";
          "nix.serverSettings".nixd = {
            nixpkgs.expr = "(builtins.getFlake \"${inputs.self}\").nixosConfigurations.${settings.system.hostName}.pkgs";
            formatting.command = [ "nixfmt" ];
            options = {
              nixos.expr = myOptions;
              home-manager.expr = myOptions + ".home-manager.users.type.getSubOptions []";
              flake-parts.expr = myOptions + ".flake-parts.type.getSubOptions []";
            };
          };

          	"[markdown]" = {
              "editor.insertSpaces" = true;
              "editor.tabSize" = 2;
              "editor.wordWrap" = "bounded";
              "editor.defaultFormatter" = "DavidAnson.vscode-markdownlint";
            };

            "[python]" = {
              "editor.insertSpaces" = true;
            };

            "diffEditor.diffAlgorithm"= "advanced";
            "diffEditor.experimental.showMoves"= true;
            "diffEditor.ignoreTrimWhitespace"= false;
            "editor.acceptSuggestionOnCommitCharacter"= false;
            "editor.acceptSuggestionOnEnter"= "on";
            "editor.copyWithSyntaxHighlighting"= false;
            "editor.detectIndentation"= true;
            "editor.fontSize"= 16;
            "editor.guides.bracketPairs"= true;
            "editor.inlineSuggest.enabled"= false;
            "editor.insertSpaces"= false;
            "editor.language.brackets"= [
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
              "comments"= false;
              "other"= false;
              "strings"= false;
            };
            "editor.rulers"= [
              100
            ];
            "editor.scrollbar.vertical"= "visible";
            "editor.suggest.preview"= true;
            "editor.suggestSelection"= "recentlyUsed";
            "editor.tabSize"= 4;
            "editor.unicodeHighlight.allowedCharacters"= {
              "×"= true;
              "α"= true;
              "γ"= true;
              "ι"= true;
              "ρ"= true;
              "σ"= true;
              "ℓ"= true;
              "ℕ"= true;
              "ℚ"= true;
              "ℝ"= true;
              "ℤ"= true;
              "∨"= true;
            };
            "editor.wordWrap"= "on";
            "editor.wordWrapColumn"= 100;
            "explorer.confirmDragAndDrop"= false;
            "extensions.autoCheckUpdates"= false;
            "files.enableTrash"= false;
            "files.watcherExclude" = {
              "**/.ammonite"= true;
              "**/.bloop"= true;
              "**/.metals"= true;
            };
            "git.allowForcePush"= true;
            "git.autofetch"= "all";
            "git.autofetchPeriod"= 120;
            "git.closeDiffOnOperation"= true;
            "git.confirmForcePush"= false;
            "git.confirmSync"= false;
            "git.enableSmartCommit"= true;
            "gitlens.ai.enabled"= false;
            "gitlens.codeLens.enabled"= false;
            "gitlens.defaultDateFormat"= "YYYY-MM-DD HH=mm";
            "gitlens.defaultDateLocale"= null;
            "gitlens.defaultDateShortFormat"= "YYYY-MM-DD";
            "gitlens.defaultDateStyle"= "absolute";
            "gitlens.defaultTimeFormat"= "HH=mm";
            "gitlens.launchpad.indicator.enabled"= false;
            "gitlens.plusFeatures.enabled"= false;
            "gitlens.showWelcomeOnInstall"= false;
            "gitlens.showWhatsNewAfterUpgrades"= false;
            "haskell.manageHLS"= "PATH";
            "keyboard.dispatch"= "keyCode";
            "markdown-kroki.url"= "https://diagrams.eisfunke.com";
            "markyMarkdown.statsItemSeparator"= " / ";
            "markyMarkdown.statsShowCharacters"= true;
            "markyMarkdown.statsShowReadingTime"= false;
            "markyMarkdown.statsShowWords"= true;
            "mypy.enabled"= false;
            "mypy.extraArguments"= [
              "--exclude"
              "result.*/"
            ];
            "rewrap.wrappingColumn" = 100;
            "security.workspace.trust.enabled"= false;
            "terminal.integrated.commandsToSkipShell"= [
              "workbench.action.toggleSidebarVisibility"
            ];
            "terminal.integrated.minimumContrastRatio"= 1;
            "terminal.integrated.scrollback"= 5000;
            "terminal.integrated.tabs.enabled"= false;
            "todo-tree.general.showActivityBarBadge"= true;
            "todo-tree.general.tags"= [
              "TODO"
              "FIXME"
            ];
            "todo-tree.regex.regex"= "(^|\\s|//|#|<!--|;|/\\*)($TAGS)(:|\\s|$)";
            "[nix]"= {
              "editor.defaultFormatter"= "jnoortheen.nix-ide";
              "editor.formatOnSave"= true;
              "editor.inlayHints.enabled"= "on";
              "editor.insertSpaces"= true;
              "editor.tabSize"= 2;
            };
            "[shellscript]"= {
              "editor.defaultFormatter"= "mads-hartmann.bash-ide-vscode";
            };
            "[typescript]"= {
              "editor.defaultFormatter"= "esbenp.prettier-vscode";
            };
            "[typescriptreact]"= {
              "editor.defaultFormatter"= "esbenp.prettier-vscode";
            };
            "application.shellEnvironmentResolutionTimeout"= 60;
            "better-comments.multilineComments"= true;
            "better-comments.highlightPlainText"= true;
            "better-comments.tags"= [
              {
                "tag"= "!";
                "color"= "#FF2D00";
                "strikethrough"= false;
                "underline"= false;
                "backgroundColor"= "transparent";
                "bold"= false;
                "italic"= false;
              }
              {
                "tag"= "#";
                "color"= "#090";
                "strikethrough"= false;
                "underline"= false;
                "backgroundColor"= "transparent";
                "bold"= false;
                "italic"= true;
              }
              {
                "tag"= "?";
                "color"= "#3498DB";
                "strikethrough"= false;
                "underline"= false;
                "backgroundColor"= "transparent";
                "bold"= false;
                "italic"= false;
              }
              {
                "tag"= "//";
                "color"= "#474747";
                "strikethrough"= true;
                "underline"= false;
                "backgroundColor"= "transparent";
                "bold"= false;
                "italic"= false;
              }
              {
                "tag"= "todo";
                "color"= "#FF8C00";
                "strikethrough"= false;
                "underline"= false;
                "backgroundColor"= "transparent";
                "bold"= false;
                "italic"= false;
              }
              {
                "tag"= "*";
                "color"= "#98C379";
                "strikethrough"= false;
                "underline"= false;
                "backgroundColor"= "transparent";
                "bold"= false;
                "italic"= false;
              }
            ];
            # breadcrumbs
            "breadcrumbs.enabled"= true;
            "breadcrumbs.showArrays"= false;
            "breadcrumbs.showBooleans"= false;
            "breadcrumbs.showClasses"= false;
            "breadcrumbs.showConstants"= false;
            "breadcrumbs.showConstructors"= false;
            "breadcrumbs.showEnumMembers"= false;
            "breadcrumbs.showEnums"= false;
            "breadcrumbs.showEvents"= false;
            "breadcrumbs.showFields"= false;
            "breadcrumbs.showFunctions"= false;
            "breadcrumbs.showInterfaces"= false;
            "breadcrumbs.showKeys"= false;
            "breadcrumbs.showMethods"= false;
            "breadcrumbs.showModules"= false;
            "breadcrumbs.showNamespaces"= false;
            "breadcrumbs.showNull"= false;
            "breadcrumbs.showNumbers"= false;
            "breadcrumbs.showObjects"= false;
            "breadcrumbs.showPackages"= false;
            "breadcrumbs.showProperties"= false;
            "breadcrumbs.showStrings"= false;
            "breadcrumbs.showStructs"= false;
            "breadcrumbs.showTypeParameters"= false;
            "breadcrumbs.showVariables"= false;
            "debug.allowBreakpointsEverywhere"= true;
            "editor.bracketPairColorization.enabled"= true;
            "editor.bracketPairColorization.independentColorPoolPerBracketType"= true;
            "editor.cursorBlinking"= "expand";
            "editor.cursorSmoothCaretAnimation"= "explicit";
            "editor.cursorWidth"= 3;
            "editor.fontFamily"= "'CaskaydiaCove Nerd Font','JetBrainsMono Nerd Font'";
            "editor.fontLigatures"= true;
            "editor.fontWeight"= "normal";
            "editor.formatOnPaste"= true;
            "editor.formatOnSave"= true;
            "editor.inlineSuggest.syntaxHighlightingEnabled"= true;
            "editor.lineHeight"= 25;
            "editor.minimap.enabled"= false;
            "editor.mouseWheelZoom"= true;
            "editor.occurrencesHighlight"= "off";
            "editor.renderWhitespace"= "all";
            "editor.smoothScrolling"= true;
            "editor.suggest.localityBonus"= true;
            "explorer.confirmPasteNative"= true;
            "files.associations"= {
              "*.css"= "css";
              "appsettings*.json"= "jsonc";
            };
            "files.autoSave"= "off";
            "files.insertFinalNewline"= true;
            "files.trimFinalNewlines"= true;
            "files.trimTrailingWhitespace"= true;
            "git"= {
              "autofetch"= true;
              "confirmSync"= false;
            };
            "gitlens"= {
              "codeLens"= {
                "enabled"= false;
              };
              "defaultDateFormat"= "YYYY-MM-DD HH:mm";
              "defaultDateLocale"= "system";
              "defaultDateShortFormat"= "YYYY-M-D";
              "defaultTimeFormat"= "HH:mm";
              "statusBar"= {
                "enabled"= false;
              };
              "views"= {
                "repositories"= {
                  "showContributors"= false;
                  "showStashes"= true;
                  "showTags"= false;
                  "showWorktrees"= false;
                };
              };
            };
            "html.format.wrapLineLength"= 0;
            "indentRainbow.colors"= [
              "hsl(271, 60%, 50%)"
              "hsl(142, 60%, 50%)"
              "hsl(217, 60%, 50%)"
              "hsl(45, 60%, 50%)"
              "hsl(330, 60%, 50%)"
            ];
            "indentRainbow.indicatorStyle"= "light";
            "indentRainbow.lightIndicatorStyleLineWidth"= 3;
            # The indent color if the number of spaces is not a multiple of "tabSize".
            "indentRainbow.errorColor"= "rgba(128,32,32,0.6)";
            # The indent color when there is a mix between spaces and tabs.
            # To be disabled this coloring set this to an empty string.
            "indentRainbow.tabmixColor"= "rgba(128,32,96,0.6)";
            "javascript.inlayHints.variableTypes.suppressWhenTypeMatchesName"= true;
            "javascript.format.semicolons"= "insert";
            "javascript.inlayHints.enumMemberValues.enabled"= true;
            "javascript.inlayHints.functionLikeReturnTypes.enabled"= true;
            "javascript.inlayHints.parameterNames.enabled"= "none";
            "javascript.inlayHints.parameterNames.suppressWhenArgumentMatchesName"= true;
            "javascript.inlayHints.parameterTypes.enabled"= true;
            "javascript.inlayHints.propertyDeclarationTypes.enabled"= true;
            "javascript.inlayHints.variableTypes.enabled"= true;
            "javascript.updateImportsOnFileMove.enabled"= "always";
            "less.lint.unknownAtRules"= "ignore";
            "rust-analyzer.rustfmt.overrideCommand"= null;
            "scss.lint.unknownAtRules"= "ignore";
            "search.seedWithNearestWord"= true;
            "security.workspace.trust.banner"= "never";
            "security.workspace.trust.untrustedFiles"= "open";
            "terminal.explorerKind"= "external";
            "terminal.integrated.cursorBlinking"= true;
            "terminal.integrated.cursorStyle"= "line";
            "terminal.integrated.cursorStyleInactive"= "line";
            "terminal.integrated.cursorWidth"= 2;
            "terminal.integrated.defaultProfile.linux"= "zsh";
            "terminal.integrated.enableImages"= true;
            "terminal.integrated.enableMultiLinePasteWarning"= "never";
            "terminal.integrated.environmentChangesRelaunch"= false;
            "terminal.integrated.fontFamily"= "Fira Code";
            "terminal.integrated.fontLigatures.enabled"= true;
            "terminal.integrated.fontSize"= 14;
            "terminal.integrated.fontWeight"= "bold";
            "terminal.integrated.gpuAcceleration"= "on";
            "terminal.integrated.smoothScrolling"= true;
            "typescript.inlayHints.parameterNames.suppressWhenArgumentMatchesName"= true;
            "typescript.inlayHints.variableTypes.suppressWhenTypeMatchesName"= true;
            "typescript.format.semicolons"= "insert";
            "typescript.inlayHints.enumMemberValues.enabled"= true;
            "typescript.inlayHints.functionLikeReturnTypes.enabled"= true;
            "typescript.inlayHints.parameterNames.enabled"= "none";
            "typescript.inlayHints.parameterTypes.enabled"= true;
            "typescript.inlayHints.propertyDeclarationTypes.enabled"= true;
            "typescript.inlayHints.variableTypes.enabled"= true;
            "update.showReleaseNotes"= false;
            "vite.autoStart"= false;
            "vite.https"= false;
            "window.autoDetectColorScheme"= true;
            "window.menuBarVisibility"= "toggle";
            "workbench.editor.enablePreview"= true;
            "workbench.editor.highlightModifiedTabs"= true;
            "workbench.iconTheme"= "material-icon-theme";
            "workbench.list.smoothScrolling"= true;
            "workbench.preferredLightColorTheme"= "Default Dark Modern";
            "workbench.settings.openDefaultKeybindings"= true;
            "workbench.sideBar.location"= "right";
            "workbench.startupEditor"= "none";
            "workbench.tips.enabled"= true;
            "window.commandCenter"= false;
            "workbench.layoutControl.enabled"= false;
            "window.customTitleBarVisibility"= "never";
            "window.titleBarStyle"= "native";
            "zenMode.fullScreen"= false;
            "editor.stickyScroll.enabled"= false;
            "[jsonc]"= {
              "editor.defaultFormatter"= "vscode.json-language-features";
            };
            "nixEnvSelector.useFlakes"= true;
            "[vue]"= {
              "editor.defaultFormatter"= "Vue.volar";
            };
            "extensions.autoUpdate"= false;
            "update.mode"= "manual";
            "dart.checkForSdkUpdates"= false;
            "dart.updateDevTools"= false;
            "github.copilot.nextEditSuggestions.enabled"= true;
            "[css]"= {
              "editor.defaultFormatter"= "vscode.css-language-features";
            };
            "typescript.updateImportsOnFileMove.enabled"= "always";
            "workbench.secondarySideBar.defaultVisibility"= "hidden";
            "workbench.colorTheme"= "Monokai Pro";
            "chat.agent.thinking.collapsedTools"= "all";
            "chat.edits2.enabled"= true;
            "[json]"= {
              "editor.defaultFormatter"= "vscode.json-language-features";
            };
            "editor.defaultFormatter"= "esbenp.prettier-vscode";
            "notebook.defaultFormatter"= "esbenp.prettier-vscode";
            "chat.emptyState.history.enabled"= true;
            "editor.scrollbar.verticalScrollbarSize"= 18;
            "css.lint.boxModel"= "warning";
            "less.lint.boxModel"= "warning";
            "scss.lint.boxModel"= "warning";
            "workbench.preferredDarkColorTheme"= "Material Night Eighties";
            "ipynb.experimental.serialization"= false;
        };
      };
    };
  };
}
