{ settings, inputs, lib, config, pkgs, ... }: {
  home-manager.users.${settings.user.username} = {
    programs.yt-dlp = {
      enable = settings.modules.data_transferring.yt-dlp.enable or false;
      package =
        inputs.yt-dlp-src.packages.${pkgs.stdenv.hostPlatform.system}.default;
      # package = pkgs.yt-dlp;

      settings = {
        # embed-thumbnail = true;
        # embed-metadata = true;
        # embed-chapters = true;
        sponsorblock-mark = "all";
        # downloader = lib.getExe pkgs.aria2;
        # downloader = "aria2c";
        # downloader-args = "aria2c:'-c -x12 -s12 -j10 -k1024M'";
        # cookies-from-browser = "chrome";
      };
      extraConfig = ''
        -f "bestvideo[height<=1080]+bestaudio/best"
        --abort-on-unavailable-fragments
        --abort-on-error
        --extractor-args "youtube:player_client=default"
      '';
    };
  };
  environment.systemPackages = with pkgs; [ aria2 ];
}
