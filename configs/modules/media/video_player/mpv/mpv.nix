{ settings, pkgs, ... }: {
  home-manager.users.${settings.username} = {
    programs.mpv = {
      enable = true;
      scripts = [ pkgs.mpvScripts.mpris ];
      defaultProfiles = [ "gpu-hq" ];
      config = {
        profile = "gpu-hq";
        force-window = true;
        ytdl-format = "bestvideo+bestaudio";
        cache-default = 4000000;
        sub-auto = "fuzzy"; # Automatically load subtitles with a similar name
        # sub-file-paths = "~/subtitles";  # Add a custom directory for subtitles
        sub-font-size = "30"; # Set font size for subtitles
        sub-border-size = "3"; # Set border size for readability
      };
    };
  };
}
