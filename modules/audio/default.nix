{
  settings,
  lib,
  pkgs,
  ...
}:
# https://wiki.archlinux.org/title/WirePlumber
# https://wiki.archlinux.org/title/PulseAudio/Examples
let
  inherit (lib) mkIf;
in
{
  imports = [
    ./rnnoise.nix
    ./music_analysis.nix
  ];

  config = mkIf (settings.modules.audio.enable or false) {
    # WirePlumber configuration [https://wiki.archlinux.org/title/WirePlumber]
    # To get The id of your audio sink, run:
    # wpctl status
    # Then use the inspect command to view the object's detail and list all properties in that object:
    # wpctl inspect {object_id}
    #
    # Note: the default sink is set here via WirePlumber priority, NOT via
    # /etc/pulse/default.pa — that file's `set-default-sink` syntax is only
    # ever executed by the real `pulseaudio` daemon's script parser, which
    # doesn't run here (services.pulseaudio.enable = false) and isn't
    # replicated by pipewire-pulse. Priority-based selection below is the
    # PipeWire-native equivalent and is what actually takes effect.
    #
    # Confirmed via `wpctl status` on the 3400G/A520M box: the analog codec
    # (ALC897) is exposed as pci-0000_04_00.6, a function of the APU's own
    # PCI device on bus 04 — NOT the FCH southbridge at 00:14.2. Re-check
    # this address if you ever move to different hardware/BIOS.
    environment.etc = {
      "wireplumber/wireplumber.conf.d/set-priorities.conf".text = ''
        monitor.alsa.rules = [
          {
            matches = [
              {
                node.name = "alsa_output.pci-0000_04_00.6.analog-stereo"
              }
            ]
            actions = {
              update-props = {
                priority.driver = 100
                priority.session = 100
                api.alsa.headroom = 512
              }
            }
          }
          # The GPU's HDMI/DP audio ("Raven/Raven2/Fenghuang HDMI/DP Audio
          # Controller", sink id 66 in wpctl status) is a separate device
          # on the same bus. Run `wpctl inspect 66` to get its exact
          # node.name, then uncomment and adjust to keep it from ever
          # outranking the analog output:
          # {
          #   matches = [
          #     { node.name = "alsa_output.pci-0000_04_00.1.hdmi-stereo" }
          #   ]
          #   actions = {
          #     update-props = {
          #       priority.driver = 50
          #       priority.session = 50
          #     }
          #   }
          # }
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

    environment.systemPackages = with pkgs; [
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
