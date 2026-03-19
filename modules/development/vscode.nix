{
  settings,
  pkgs,
  inputs,
  system,
  config,
  self,
  ...
}:
let
  myOptions = "(builtins.getFlake \"${self}\").nixosConfigurations.MYHOSTNAME.options";
in
{
  programs.vscode.defaultEditor = true;

  home-manager.users.${settings.user.username} = {
    programs.vscode = {
      enable = true;

      # use unstable VS Codium because of quick releases and tight version reqs by extensions
      package = pkgs.update.vscode;

      profiles.default = {
        enableExtensionUpdateCheck = false;
        enableUpdateCheck = false;

        extensions =
          let
            t =
              inputs.nix-vscode-extensions.extensions.${system}.forVSCodeVersion
                config.programs.vscode.package.version;
            p = t.vscode-marketplace;
            pr = t.vscode-marketplace-release;
          in
          [
            # general
            p.bierner.emojisense
            p.bierner.markdown-checkbox
            p.bierner.markdown-emoji
            p.davidlday.languagetool-linter
            p.dracula-theme.theme-dracula
            pr.eamodio.gitlens # non-release versions "expire" quite quickly
            p.gruntfuggly.todo-tree
            p.mkhl.direnv
            p.robole.marky-stats
            p.stkb.rewrap
            p.tomoki1207.pdf
            p.tyriar.sort-lines
            p.pomdtr.markdown-kroki
            p.editorconfig.editorconfig

            # haskell
            p.haskell.haskell # language server
            p.justusadam.language-haskell # syntax highlighting
            p.s0kil.vscode-hsx # HSX is HTML templating for IHP

            # python
            p.ms-python.python
            p.charliermarsh.ruff
            p.matangover.mypy

            # other languages
            p.banacorn.agda-mode
            p.qbane.als-wasm-loader
            p.denoland.vscode-deno
            p.jnoortheen.nix-ide
            p.kokakiwi.vscode-just
            p.mark-hansen.hledger-vscode
            p.samuelcolvin.jinjahtml
            p.scala-lang.scala
            p.scalameta.metals
            p.tamasfe.even-better-toml
            p.mechatroner.rainbow-csv
            p.thenuprojectcontributors.vscode-nushell-lang
            p.antyos.openscad
            p.jetbrains.resharper-code
            p.vue.volar
          ];

        keybindings = [
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

          # workaround to use Neo2 backslash for Agda Unicode input
          # neither `[Backslash]` nor `capslock+u` work
          # taken from the record keys function from the shortcut editor
          {
            key = "[Backslash]";
            command = "-agda-mode.input-symbol[Activate]";
          }
          {
            key = "["; # this is what Neo2 ß registers as
            command = "agda-mode.input-symbol[Activate]";
            when = "editorTextFocus && !editorHasSelection && editorLangId == 'agda'";
          }

          {
            key = "ctrl+x ctrl+=";
            command = "-agda-mode.lookup-symbol";
          }
          {
            key = "ctrl+c ctrl+s";
            command = "agda-mode.lookup-symbol";
            when = "editorTextFocus && !editorHasSelection && editorLangId == 'agda'";
          }
        ];

        userSettings = {
          "keyboard.dispatch" = "keyCode";

          "editor.fontFamily" = "Iosevka Funke";
          "editor.fontSize" = 14;
          "editor.fontLigatures" = true;
          "editor.rulers" = [ 100 ];
          "editor.wordWrapColumn" = 100; # column to wrap at, ignored by default due to wordWrap, relevant e.g. for markdown
          "editor.wordWrap" = "on"; # by default, wrap at the viewport
          "rewrap.wrappingColumn" = 100; # rewrap text with rewrap extension at column 100
          "editor.cursorStyle" = "line";
          "editor.cursorBlinking" = "solid";
          "editor.renderWhitespace" = "boundary";
          "editor.guides.bracketPairs" = true;
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

          # allow various mathematical symbols for use in stuff like TeX and Agda
          "editor.unicodeHighlight.allowedCharacters" = builtins.listToAttrs (
            map
              (x: {
                name = x;
                value = true;
              })
              [
                "ℕ"
                "ℚ"
                "ℝ"
                "ℤ"
                "α"
                "γ"
                "ρ"
                "σ"
                "ι"
                "∨"
                "ℓ"
                "×"
              ]
          );

          # by default, I use tabs for indentation for accessibility reasons
          "editor.insertSpaces" = false;
          "editor.tabSize" = 4;
          "editor.detectIndentation" = true;

          # I don't like suggestions popping up automatically
          "editor.quickSuggestions" = {
            "other" = false;
            "comments" = false;
            "strings" = false;
          };

          "editor.inlineSuggest.enabled" = false; # I prefer the suggest widget
          "editor.acceptSuggestionOnEnter" = "on";
          "editor.acceptSuggestionOnCommitCharacter" = false;
          "editor.suggest.preview" = true;
          "editor.suggestSelection" = "recentlyUsed";
          "editor.copyWithSyntaxHighlighting" = false;

          "editor.scrollbar.vertical" = "visible";
          "editor.minimap.enabled" = false;

          "diffEditor.experimental.showMoves" = true;
          "diffEditor.ignoreTrimWhitespace" = false;
          "diffEditor.diffAlgorithm" = "advanced";

          "window.titleBarStyle" = "native";
          "window.customTitleBarVisibility" = "never";
          "window.menuBarVisibility" = "toggle";
          "window.commandCenter" = false;

          "explorer.confirmDragAndDrop" = false;

          "files.trimFinalNewlines" = true;
          "files.trimTrailingWhitespace" = true;
          "files.insertFinalNewline" = true;
          "files.watcherExclude" = {
            "**/.bloop" = true;
            "**/.metals" = true;
            "**/.ammonite" = true;
          };
          "files.associations" = {
            # dotnet appsettings.json allows comments
            "appsettings*.json" = "jsonc";
          };
          "files.enableTrash" = false;

          "workbench.startupEditor" = "none";
          "workbench.colorTheme" = "Dracula Theme";
          "workbench.sideBar.location" = "right";

          "security.workspace.trust.enabled" = false;
          "update.showReleaseNotes" = false;
          "extensions.autoUpdate" = false;

          "git.enableSmartCommit" = true; # commit all if nothing staged
          "git.confirmSync" = false; # no confirm dialog on sync
          "git.autofetch" = "all"; # regularly fetch from all remotes of the repo
          "git.autofetchPeriod" = 120;
          "git.closeDiffOnOperation" = true; # close diff editors on commits etc.
          "git.allowForcePush" = true;
          "git.confirmForcePush" = false;

          "gitlens.showWelcomeOnInstall" = false;
          "gitlens.showWhatsNewAfterUpgrades" = false;
          "gitlens.plusFeatures.enabled" = false;
          "gitlens.codeLens.enabled" = false;
          "gitlens.ai.enabled" = false;
          "gitlens.defaultDateStyle" = "absolute";
          "gitlens.defaultDateLocale" = null;
          "gitlens.defaultDateFormat" = "YYYY-MM-DD HH:mm";
          "gitlens.defaultDateShortFormat" = "YYYY-MM-DD";
          "gitlens.defaultTimeFormat" = "HH:mm";
          "gitlens.remotes" = [
            {
              "domain" = "git.eisfunke.com";
              "type" = "GitLab";
            }
            {
              "domain" = "gitlab.fachschaften.org";
              "type" = "GitLab";
            }
            {
              "domain" = "git.rrs.ruhr";
              "type" = "GitLab";
            }
          ];
          "gitlens.launchpad.indicator.enabled" = false;

          "terminal.integrated.tabs.enabled" = false;
          "terminal.integrated.scrollback" = 5000;
          "terminal.integrated.cursorStyle" = "line";
          /*
            vscode fixes colors in the termial to meet certain contrast ratios
            I just want the original colors
          */
          "terminal.integrated.minimumContrastRatio" = 1;
          "terminal.integrated.env.linux" = {
            # -r: reuse existing window, -w: wait until file is closed
            EDITOR = "codium -rw";
            VISUAL = "codium -rw";
          };
          "terminal.integrated.commandsToSkipShell" = [
            "workbench.action.toggleSidebarVisibility"
          ];

          "haskell.manageHLS" = "PATH";

          "todo-tree.general.showActivityBarBadge" = true;
          "todo-tree.general.tags" = [
            "TODO"
            "FIXME"
          ];
          "todo-tree.regex.regex" = "(^|\\s|//|#|<!--|;|/\\*)($TAGS)(:|\\s|$)";

          "markyMarkdown.statsShowReadingTime" = false;
          "markyMarkdown.statsShowWords" = true;
          "markyMarkdown.statsShowCharacters" = true;
          "markyMarkdown.statsItemSeparator" = " / ";

          "markdown-kroki.url" = "https://diagrams.eisfunke.com";

          "languageToolLinter.external.url" = "http://localhost:64203";
          "languageToolLinter.lintOnOpen" = true;
          # https://github.com/davidlday/vscode-languagetool-linter/issues/603
          # "languageToolLinter.languageTool.ignoredWordHint" = false;

          "languageToolLinter.languageTool.preferredVariants" = "en-US,de-DE,nl-NL";
          "languageToolLinter.languageTool.motherTongue" = "de-DE";
          "languageToolLinter.languageTool.ignoredWordsGlobal" = [
            "iirc"
            "eisfunke"
            "eisfunkelab"
            "kb"
            "nebelhorn"
            "agda"
            "dir"
            "bruijn"
            "codomain"
          ];

          /*
            - turn off mypy extension by default
            - I'd rather turn it on only in specific workspaces
            - because it complains in every workspace without mypy installed in it otherwise
          */
          "mypy.enabled" = false;
          /*
            Exclude Nix result folders from mypy checking. Otherwise this would lead to errors.

            See: https://mypy.readthedocs.io/en/stable/command_line.html#cmdoption-mypy-exclude
          */
          "mypy.extraArguments" = [
            "--exclude"
            "result.*/"
          ];

          /*
            Set up nixd as Nix language server.

            Note: I tried to get the home-manager options directly from the home config inside the NixOS
            config, but I didn't find an exposed `options` there anywhere. So that's why I've added the
            plain home-manager configs to the flake.
          */
          "nix.enableLanguageServer" = true;
          "nix.serverPath" = "${pkgs.nixd}/bin/nixd";
          "nix.serverSettings".nixd = {
            nixpkgs.expr = "(builtins.getFlake \"${inputs.self}\").nixosConfigurations.${settings.user.hostname}.pkgs";
            formatting.command = [ "nixfmt" ];
            options = {
              nixos.expr = "(builtins.getFlake \"${inputs.self}\").nixosConfigurations.${settings.user.hostname}.options";
              home-manager.expr = "(builtins.getFlake \"${inputs.self}\").homeConfigurations.base-${system}.options";
              flake-parts.expr = "(builtins.getFlake \"${inputs.self}\").debug.options";
            };
          };

          "agdaMode.connection.downloadPolicy" = "No, and don't ask again";
          "agdaMode.connection.agdaVersion" = "agda";

          # C#

          # "[csharp]" = {
          #   "editor.defaultFormatter" = "csharpier.csharpier-vscode";
          # };

          # language specific indentation settings
          # "[scala]" = {
          #   # follow Scala style guide
          #   "editor.insertSpaces" = true;
          #   "editor.tabSize" = 2;
          # };
          "[markdown]" = {
            # indent markdown with spaces so YAML frontmatter doesn't break
            "editor.wordWrap" = "bounded"; # wrap markdown files at line width
            "editor.insertSpaces" = true;
            "editor.tabSize" = 2;
          };
          # "[haskell]"."editor.insertSpaces" = true; # GHC warns when using tabs
          "[python]"."editor.insertSpaces" = true; # black forces spaces
          "[agda]"."editor.insertSpaces" = true; # agda forces spaces
        };
      };
    };
  };
}
