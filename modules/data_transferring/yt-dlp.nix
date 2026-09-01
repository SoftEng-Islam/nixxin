{
  settings,
  inputs,
  lib,
  config,
  pkgs,
  ...
}:
{
  home-manager.users.${settings.user.username} = {
    programs.yt-dlp = {
      enable = settings.modules.data_transferring.yt-dlp.enable or false;
      package = inputs.yt-dlp-src.packages.${pkgs.stdenv.hostPlatform.system}.default;
      # package = pkgs.yt-dlp;

      settings = {
        # embed-thumbnail = true;
        # embed-metadata = true;
        # embed-chapters = true;
        sponsorblock-mark = "all";
        # downloader = lib.getExe pkgs.aria2;
        # downloader = "aria2c";
        # downloader-args = "aria2c:'-c -x12 -s12 -j10 -k1024M'";
        cookies-from-browser = "firefox:${settings.HOME}/.zen";
      };
      extraConfig = ''
        -f "bestvideo[height<=1080]+bestaudio/best"
        --download-archive downloaded.txt
        --remote-components ejs:github
        --abort-on-unavailable-fragments
        # --abort-on-error
        --ignore-errors
        --no-check-certificates
        # Use iOS or Android client as fallback if web client fails
        --extractor-args "youtube:player_client=ios,android"
        # --extractor-args "youtube:player-client=tv,mweb;formats=incomplete" -f "ba[protocol=sabr]+bv[protocol=sabr]"
        # --extractor-args "youtube:player_client=tv,mweb;formats=incomplete"

      '';
    };
  };

  # Install required JavaScript runtime for YouTube challenge solving
  # Deno is required for yt-dlp to solve YouTube's n-parameter and signature challenges
  environment.systemPackages = with pkgs; [
    aria2
    deno  # JavaScript runtime for yt-dlp challenge solving
  ];
}
