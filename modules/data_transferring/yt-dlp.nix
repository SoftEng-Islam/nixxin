{ settings, lib, config, pkgs, ... }: {
  home-manager.users.${settings.user.username} = {
    programs.yt-dlp = {
      enable = settings.modules.data_transferring.yt-dlp.enable or false;
      settings = {
        # embed-thumbnail = true;
        # embed-metadata = true;
        # embed-chapters = true;
        sponsorblock-mark = "all";
        # downloader = lib.getExe pkgs.aria2;
        downloader = "aria2c";
        downloader-args = "aria2c:'-c -x8 -s8 -k1024M'";
        cookies-from-browser = "chrome";
        format = "bestvideo[height<=?1080][fps<=?60]+bestaudio/best";
      };
    };
  };
  environment.systemPackages = with pkgs; [ aria2 ];
}
