{ settings, lib, pkgs, ... }:

lib.mkIf (settings.modules.data_transferring.curl.enable or true) {
  home-manager.users.${settings.user.username}.home.file.".curlrc" = {
    text = ''
      # this is a sample .curlrc file
      # https://everything.curl.dev/ is a GREAT RESOURCE

      # Maximum time allowed to spend
      --max-time 100
      # Never spend more than this to connect
      --connect-timeout 100

      # To help avoid a really slow connection
      --keepalive-time 300

      # store the trace in curl_trace.txt file. beware that multiple executions of the curl command will overwrite this file
      --trace curl_trace.txt

      # store the header info in curl_headers.txt file. beware that multiple executions of the curl command will overwrite this file
      --dump-header curl_headers.txt

      # change the below referrer URL or comment it out entirely
      -e "https://www.google.com"

      # change the below useragent string. get your/other UA strings from http://www.useragentstring.com/
      -A "Mozilla/5.0 (Windows; U; Windows NT 6.0; en-US) AppleWebKit/525.13 (KHTML, like Gecko) Chrome/0.2.149.27 Safari/525.13"

      # some headers
      -H  "Accept: text/html,application/xhtml+xml,application/xml;q=0.9,image/webp,*/*;q=0.8"
      -H  "Upgrade-Insecure-Requests: 1"
      -H  "Accept-Encoding: gzip, deflate, sdch"
      -H  "Accept-Language: en-US,en;q=0.8"

      # follow redirects
      --location

      # verbose
      # --verbose

      # trace the time taken. more info here https://everything.curl.dev/usingcurl/verbose/trace
      --trace-time

      # write the trace data to stdout
      --trace-ascii -

      # ok if certification validation fails
      --insecure
    '';
  };
  environment.systemPackages = with pkgs;
    [
      curl
      # curlFull
      # curlHTTP3
      # curl-impersonate
      # curl-impersonate-chrome
    ];
}
