{ settings, lib, pkgs, ... }:
let inherit (lib) optionals mkIf;
in {
  imports = optionals (settings.modules.audio.rnnoise.enable) [ ./rnnoise.nix ];

  config = mkIf (settings.modules.audio.enable) {

    hardware = { alsa.enable = false; };
    services = {
      playerctld.enable = true;
      pulseaudio.enable = false; # Enable sound with pipewire.
      pulseaudio.support32Bit = false;
      pipewire = {
        enable = true;
        audio.enable = true;
        alsa.enable = true;
        alsa.support32Bit = true;
        pulse.enable = true;
        jack.enable = true;
        wireplumber.enable = true;
        extraConfig.pipewire = {
          "10-clock-rate" = {
            "context.properties" = {
              "default.clock.allowed-rates" = [ 44100 48000 96000 ];
            };
          };
          # "92-low-latency" = {
          #   "context.properties" = {
          #     "default.clock.rate" =
          #       96000; # Maximum common sample rate for high-quality audio
          #     "default.clock.quantum" =
          #       64; # Smallest quantum for the lowest latency
          #     "default.clock.min-quantum" = 64;
          #     "default.clock.max-quantum" =
          #       1024; # Maximum for flexibility if needed
          #   };
          # };
        };
      };
      udev.extraRules = ''
        KERNEL=="rtc0", GROUP="audio"
        KERNEL=="hpet", GROUP="audio"
        KERNEL=="snd*", MODE="0660", GROUP="audio"  # Added for improved ALSA access
      '';
    };
    security = {
      rtkit.enable =
        true; # Whether to enable the RealtimeKit system service "recommended"
      pam.loginLimits = [
        {
          domain = "@audio";
          item = "memlock";
          type = "-";
          value = "unlimited";
        }
        {
          domain = "@audio";
          item = "rtprio";
          type = "-";
          value = "99";
        }
        {
          domain = "@audio";
          item = "nofile";
          type = "soft";
          value = "99999";
        }
        {
          domain = "@audio";
          item = "nofile";
          type = "hard";
          value = "524288";
        }
      ];
    };

    # Audio effects for PipeWire applications.
    home-manager.users.${settings.user.username}.services.easyeffects = {
      # Whether to enable EasyEffects.
      # Necessitates programs.dconf.enable to be true.
      enable = true;
    };

    # Adds MIDI soundfonts (if present) to /run/current-system/sw.
    # Why this does not seem to be done by default is beyond me.
    environment.pathsToLink = [ "/share/soundfonts" ];

    environment.systemPackages = with pkgs; [
      alsa-utils # ALSA, the Advanced Linux Sound Architecture utils
      sof-firmware # Sound Open Firmware
      # pulseaudio # Sound server for POSIX and Win32 systems
      # pulseaudio-ctl # Control pulseaudio volume from the shell or mapped to keyboard shortcuts. No need for alsa-utils
      pamixer # Pulseaudio command line mixer
      pavucontrol # PulseAudio Volume Control
      pipewire # Server and user space API to deal with multimedia pipelines
      pipecontrol # Pipewire control GUI program in Qt (Kirigami2)
      pulseaudioFull # Sound server for POSIX and Win32 systems
      wireplumber # Modular session / policy manager for PipeWire
      ladspaPlugins # LADSPA format audio plugins
      calf # Set of high quality open source audio plugins for musicians
      lsp-plugins # Collection of open-source audio plugins
      easyeffects # Audio effects for PipeWire apps

      # A lightweight and versatile audio player.
      audacious

      # View and edit tags for various audio files.
      easytag

      # Sound editor with graphical UI.
      tenacity

      # Midi sound fonts.
      soundfont-fluid
      soundfont-arachno
      soundfont-ydp-grand
      soundfont-generaluser
    ];
  };
}
