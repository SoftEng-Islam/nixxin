{ settings, lib, pkgs, ... }:
# https://wiki.archlinux.org/title/WirePlumber
# https://wiki.archlinux.org/title/PulseAudio/Examples
let inherit (lib) mkIf;
in {
  imports = [ ./rnnoise.nix ];

  config = mkIf (settings.modules.audio.enable or true) {
    # WirePlumber configuration [https://wiki.archlinux.org/title/WirePlumber]
    # To get The id of your audio sink, run:
    # wpctl status
    # Then use the inspect command to view the object's detail and list all properties in that object:
    # wpctl inspect {object_id}
    environment.etc = {
      "pulse/default.pa".text = ''
        set-default-sink alsa_output.pci-0000_00_14.2.analog-stereo
      '';

      "wireplumber/wireplumber.conf.d/set-priorities.conf".text = ''
        monitor.alsa.rules = [
          {
            matches = [
              {
                node.name = "alsa_output.pci-0000_00_14.2.analog-stereo"
              }
            ]
            actions = {
              update-props = {
                priority.driver = 100
                priority.session = 100
              }
            }
          }
        ]
      '';
    };

    # boot.kernelModules = [ "snd_emu10k1" ];

    # Better scheduling for better CPU cycles & audio performance
    # services.system76-scheduler = { enable = true; };

    #? What is ALSA?
    # ALSA stands for Advanced Linux Sound Architecture.
    # The Core Sound System in Linux
    # At its core, ALSA is the low-level audio driver framework built into the Linux kernel.
    # It:
    #- Talks directly to your sound hardware (sound cards, audio codecs, DACs, etc.)
    #- Provides kernel drivers for nearly all audio chips (Intel, Realtek, etc.)
    #- Offers user-space tools to configure audio (e.g., alsamixer, aplay)
    hardware.alsa.enable = false;

    services = {
      playerctld.enable = true;
      pulseaudio.enable = false; # Enable sound with pipewire.
      pulseaudio.support32Bit = false;
      pipewire = {
        enable = true;
        audio.enable = true;

        # Integrate ALSA into PipeWire (instead of standalone)
        alsa.enable = true;
        alsa.support32Bit = true;

        # Enable PulseAudio compatibility (for apps that expect pulseaudio)
        pulse.enable = true;

        # Enable JACK support (for pro audio tools like Ardour)
        jack.enable = true;

        # Enable a session manager (required)
        wireplumber.enable = true;

        # Optional: Tweak for better sound quality
        extraConfig.pipewire = {
          "10-clock-rate" = {
            "context.properties" = {
              "default.clock.allowed-rates" = [ 44100 48000 96000 ];
            };
          };
          "92-low-latency" = {
            "context.properties" = {
              "default.clock.rate" =
                96000; # Maximum common sample rate for high-quality audio
              "default.clock.quantum" =
                64; # Smallest quantum for the lowest latency
              "default.clock.min-quantum" = 64;
              "default.clock.max-quantum" =
                1024; # Maximum for flexibility if needed
            };
          };
        };
      };
      udev.extraRules = ''
        KERNEL=="rtc0", GROUP="audio"
        KERNEL=="hpet", GROUP="audio"
        KERNEL=="snd*", MODE="0660", GROUP="audio"

        ENV{INTERFACE}=="veth*", ENV{NM_UNMANAGED}="1"
        ENV{INTERFACE}=="ve-*", ENV{NM_UNMANAGED}="1"

        KERNEL=="tun", TAG+="systemd"
        SUBSYSTEM=="input", KERNEL=="mice", TAG+="systemd"
        SUBSYSTEM=="misc", KERNEL=="uinput", MODE="0660", GROUP="uinput", OPTIONS+="static_node=uinput"
        SUBSYSTEM=="misc", KERNEL=="sgx_enclave",   SYMLINK+="sgx/enclave"
        SUBSYSTEM=="misc", KERNEL=="sgx_provision", SYMLINK+="sgx/provision"
      '';
    };
    security = {
      # Whether to enable the RealtimeKit system service "recommended"
      rtkit.enable = true;
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

    # https://github.com/noisetorch/NoiseTorch
    # NoiseTorch-ng is an easy to use open source application for Linux with PulseAudio or PipeWire.
    #  It creates a virtual microphone that suppresses noise in any application using RNNoise.
    #  Use whichever conferencing or VOIP application you like and
    #  simply select the filtered Virtual Microphone as input to torch the sound of your mechanical keyboard,
    #  computer fans, trains and the likes.
    programs.noisetorch.enable = true;

    # Audio effects for PipeWire applications.
    # home-manager.users.${settings.user.username}.services.easyeffects = {
    # Whether to enable EasyEffects.
    #! [Required] Necessitates programs.dconf.enable to be true.
    # enable = false;
    # };

    # Adds MIDI soundfonts (if present) to /run/current-system/sw.
    # Why this does not seem to be done by default is beyond me.
    environment.pathsToLink = [ "/share/soundfonts" ];

    environment.systemPackages = with pkgs; [
      helvum

      # alsa-firmware
      # alsa-lib
      alsa-tools
      alsa-utils # ALSA, the Advanced Linux Sound Architecture utils
      # sof-firmware # Sound Open Firmware

      # pulseaudio # Sound server for POSIX and Win32 systems
      # pulseaudio-ctl # Control pulseaudio volume from the shell or mapped to keyboard shortcuts. No need for alsa-utils
      pulseaudioFull # Sound server for POSIX and Win32 systems

      pamixer # CLI volume control
      pavucontrol # GUI volume control
      pipewire # Server and user space API to deal with multimedia pipelines
      pipecontrol # Pipewire control GUI program in Qt (Kirigami2)

      wireplumber # Modular session / policy manager for PipeWire
      ladspaPlugins # LADSPA format audio plugins
      calf # Set of high quality open source audio plugins for musicians
      lsp-plugins # Collection of open-source audio plugins
      easyeffects # Real-time effects, EQ, bass boost, etc.

      # A lightweight and versatile audio player.
      audacious

      # View and edit tags for various audio files.
      easytag

      # Sound editor with graphical UI. Audio editor (like Audacity)
      tenacity

      # Midi sound fonts.
      # soundfont-fluid
      # soundfont-arachno
      # soundfont-ydp-grand
      # soundfont-generaluser
    ];
  };
}
