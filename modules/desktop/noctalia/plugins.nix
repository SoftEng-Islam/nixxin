{ settings, ... }:
{
  home-manager.users.${settings.user.username} = {
    programs.noctalia-shell = {
      # https://docs.noctalia.dev/getting-started/nixos/#plugins
      #$ cat ~/.config/noctalia/plugins/<name>/settings.json | nix-converter
      plugins = {
        sources = [
          {
            enabled = true;
            name = "Official Noctalia Plugins";
            url = "https://github.com/noctalia-dev/noctalia-plugins";
          }
        ];
        states = {
          assistant-panel = {
            enabled = false;
            sourceUrl = "https://github.com/noctalia-dev/noctalia-plugins";
          };
          network-indicator = {
            enabled = true;
            sourceUrl = "https://github.com/noctalia-dev/noctalia-plugins";
          };
          catwalk = {
            enabled = true;
            sourceUrl = "https://github.com/noctalia-dev/noctalia-plugins";
          };
          translator = {
            enabled = true;
            sourceUrl = "https://github.com/noctalia-dev/noctalia-plugins";
          };
          kaomoji-provider = {
            enabled = true;
            sourceUrl = "https://github.com/noctalia-dev/noctalia-plugins";
          };
          keybind-cheatsheet = {
            enabled = false;
            sourceUrl = "https://github.com/noctalia-dev/noctalia-plugins";
          };
          pomodoro = {
            enabled = true;
            sourceUrl = "https://github.com/noctalia-dev/noctalia-plugins";
          };
          screen-recorder = {
            enabled = true;
            sourceUrl = "https://github.com/noctalia-dev/noctalia-plugins";
          };
          screenshot = {
            enabled = true;
            sourceUrl = "https://github.com/noctalia-dev/noctalia-plugins";
          };
          timer = {
            enabled = false;
            sourceUrl = "https://github.com/noctalia-dev/noctalia-plugins";
          };
          unicode-picker = {
            enabled = false;
            sourceUrl = "https://github.com/noctalia-dev/noctalia-plugins";
          };
          todo = {
            enabled = true;
            sourceUrl = "https://github.com/noctalia-dev/noctalia-plugins";
          };
          # To use this plugin, you must disable or uninstall your existing polkit authentication..
          # agent (e.g., polkit-gnome, polkit-kde-agent, lxpolkit, etc).
          polkit-agent = {
            enabled = false;
            sourceUrl = "https://github.com/noctalia-dev/noctalia-plugins";
          };
        };
        version = 1;
      };

      #$ cat ~/.config/noctalia/plugins/<name>/settings.json | nix-converter
      pluginSettings = {
        network-indicator = {
          # ["arrow", "arrow-bar", "arrow-big", "arrow-narrow", "caret", "chevron", "chevron-compact", "fold"]
          arrowType = "fold";
          byteThresholdActive = 1024;
          fontSizeModifier = 1.1;
          forceMegabytes = false;
          iconSizeModifier = 1.1;
          # minWidth = 100; # in px
          showNumbers = true;
          spacingInbetween = 1;
          useCustomColors = true;
          colorSilent = "#E91E63";
          colorTx = "#7FFF00";
          colorRx = "#FFC107";
          colorText = "#DEB887";
          colorBackground = "";
        };
        catwalk = {
          # minimumThreshold = 25;
          # hideBackground = true;
        };
        pomodoro = {
          workDuration = 25;
          shortBreakDuration = 5;
          longBreakDuration = 15;
          sessionsBeforeLongBreak = 4;
          autoStartBreaks = true;
          autoStartWork = true;
          compactMode = false;
        };
        # https://github.com/noctalia-dev/noctalia-plugins/tree/main/assistant-panel
        assistant-panel = {
          maxHistoryLength = 100;
          panelDetached = true;
          panelPosition = "right";
          panelHeightRatio = 0.85;
          panelWidth = 520;
          scale = 1;
          ai = {
            provider = "google";
            model = "gemini-2.5-flash";
            apiKeys = {
              google = "";
            };
            temperature = 0.7;
            systemPrompt = "You are a helpful assistant integrated into a Linux desktop shell. Be concise and helpful.";
            maxHistoryLength = 100;
            openaiLocal = false;
            openaiBaseUrl = "https://api.openai.com/v1/chat/completions";
          };
          translator = {
            backend = "google";
            sourceLanguage = "auto";
            targetLanguage = "en";
            realTimeTranslation = true;
            deeplApiKey = "";
          };
        };
      };
    };
  };
}
