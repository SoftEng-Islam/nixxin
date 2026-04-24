{ settings, lib, pkgs, ... }:
# https://wiki.archlinux.org/title/WirePlumber
# https://wiki.archlinux.org/title/PulseAudio/Examples
let inherit (lib) mkIf;
in {
  imports = [ ./rnnoise.nix ];

  config = mkIf (settings.modules.audio.enable or false) {
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
      playerctld.enable = false;
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
      };
    };
    # Whether to enable the RealtimeKit system service "recommended"
    security.rtkit.enable = true;

    # https://github.com/noisetorch/NoiseTorch
    # NoiseTorch-ng is an easy to use open source application for Linux with PulseAudio or PipeWire.
    #  It creates a virtual microphone that suppresses noise in any application using RNNoise.
    #  Use whichever conferencing or VOIP application you like and
    #  simply select the filtered Virtual Microphone as input to torch the sound of your mechanical keyboard,
    #  computer fans, trains and the likes.
    programs.noisetorch.enable = false;

    environment.systemPackages = with pkgs;
      [
        # alsa-tools
        # alsa-utils # ALSA, the Advanced Linux Sound Architecture utils

        # pamixer # CLI volume control

        # A lightweight and versatile audio player.
        # audacious

        # View and edit tags for various audio files.
        # easytag

        # Sound editor with graphical UI. Audio editor (like Audacity)
        # tenacity
      ];
  };
}
