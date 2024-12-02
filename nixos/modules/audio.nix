{ pkgs, ... }:
{
  hardware = {
    pulseaudio.enable = false;
    # pulseaudio.enable = false; # Enable sound with pipewire.
    # pulseaudio.support32Bit = false;
  };
  services = {
    pipewire = {
      enable = true;
      audio.enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;
      jack.enable = true;
      wireplumber.enable = true;
      extraConfig.pipewire."92-low-latency" = {
        "context.properties" = {
          "default.clock.rate" = 192000; # Maximum common sample rate for high-quality audio
          "default.clock.quantum" = 64; # Smallest quantum for the lowest latency
          "default.clock.min-quantum" = 64;
          "default.clock.max-quantum" = 1024; # Maximum for flexibility if needed
        };
      };
    };
    udev.extraRules = ''
      KERNEL=="rtc0", GROUP="audio"
      KERNEL=="hpet", GROUP="audio"
      KERNEL=="snd*", MODE="0660", GROUP="audio"  # Added for improved ALSA access
    '';
  };
  security = {
    rtkit.enable = true; # Whether to enable the RealtimeKit system service "recommended"
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
  environment.systemPackages = with pkgs; [
    alsa-utils # ALSA, the Advanced Linux Sound Architecture utils
    # pulseaudio # Sound server for POSIX and Win32 systems
    # pulseaudio-ctl # Control pulseaudio volume from the shell or mapped to keyboard shortcuts. No need for alsa-utils
    pamixer # Pulseaudio command line mixer
    pavucontrol # PulseAudio Volume Control
    pipewire # Server and user space API to deal with multimedia pipelines
    pulseaudioFull # Sound server for POSIX and Win32 systems
    wireplumber # Modular session / policy manager for PipeWire
  ];
}
