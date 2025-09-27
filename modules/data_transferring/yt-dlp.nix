{ settings, lib, config, pkgs, ... }: {
  home-manager.users.${settings.user.username} = {
    programs.yt-dlp = {
      enable = true;
      settings = {
        embed-thumbnail = true;
        embed-metadata = true;
        embed-chapters = true;
        sponsorblock-mark = "all";
        downloader = lib.getExe pkgs.aria2;
        cookies-from-browser = "chrome";
        format =
          "bestvideo[height<=?1080][fps<=?60][ext!=webm][vcodec!=?av1]+bestaudio/best";
      };
    };
  };
  environment.systemPackages = with pkgs; [ yt-dlp aria2 ];
}
