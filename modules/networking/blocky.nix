{ settings, pkgs, ... }: {
  networking.firewall.allowedUDPPorts = [ 53 ];
  networking.firewall.allowedTCPPorts = [ 53 4000 ];
  environment.systemPackages = with pkgs; [ blocky ];

  systemd.services.blocky.serviceConfig = {
    ProtectKernelTunables = true;
    ProtectKernelModules = true;
    ProtectKernelLogs = true;
    ProtectHostname = true;
    ProtectControlGroups = true;
    ProtectProc = "invisible";
    SystemCallFilter =
      [ "~@obsolete" "~@cpu-emulation" "~@swap" "~@reboot" "~@mount" ];
    SystemCallArchitectures = "native";
  };

  services.blocky = {
    enable = true;
    settings = {
      connectIPVersion = "v4";
      minTlsServeVersion = "1.2";
      log = {
        level = "debug";
        privacy = true;
      };
      ports = {
        dns = 53; # Port for incoming DNS Queries.
        http = 4000;
        https = 443;
        tls = 853;
      };
      upstreams = {
        strategy = "strict";
        timeout = "30s";
        init.strategy = "fast";
        groups = {
          default = [
            "tcp+udp:127.0.0.1:5335"
            "tcp-tls:dns.quad9.net"
            "https://dns.quad9.net/dns-query"
          ];
        };
      };
      # For initially solving DoH/DoT Requests when no system Resolver is available.
      bootstrapDns = {
        upstream = "https://dns.quad9.net/dns-query";
        ips = [ "9.9.9.9" "149.112.112.112" ];
      };
      #Enable Blocking of certian domains.
      blocking = {
        blockType = "nxDomain";
        loading = {
          strategy = "fast";
          concurrency = 8;
          refreshPeriod = "4h";
        };
        blackLists = let
          customBlacklist = pkgs.writeText "custom.txt" ''
            /fextralife.com/
          '';
        in {
          ads = [
            "https://stripchat.com"
            "https://melbetegypt.com"
            "https://blocklistproject.github.io/Lists/ads.txt"
            "https://raw.githubusercontent.com/StevenBlack/hosts/master/hosts"
            "https://adaway.org/hosts.txt"
            "https://v.firebog.net/hosts/AdguardDNS.txt"
            "https://v.firebog.net/hosts/Admiral.txt"
            "https://raw.githubusercontent.com/anudeepND/blacklist/master/adservers.txt"
            "https://s3.amazonaws.com/lists.disconnect.me/simple_ad.txt"
            "https://v.firebog.net/hosts/Easylist.txt"
            "https://pgl.yoyo.org/adservers/serverlist.php?hostformat=hosts&showintro=0&mimetype=plaintext"
            "https://raw.githubusercontent.com/FadeMind/hosts.extras/master/UncheckyAds/hosts"
            "https://raw.githubusercontent.com/bigdargon/hostsVN/master/hosts"
            "https://raw.githubusercontent.com/AdGoBye/AdGoBye-Blocklists/main/AGBBase.toml"
            "https://raw.githubusercontent.com/AdGoBye/AdGoBye-Blocklists/main/AGBCommunity.toml"
            "https://raw.githubusercontent.com/AdGoBye/AdGoBye-Blocklists/main/AGBUpsell.toml"
            "https://raw.githubusercontent.com/AdGoBye/AdGoBye-Blocklists/main/AGBSupporters.toml"
          ];
          tracking = [
            "https://v.firebog.net/hosts/Easyprivacy.txt"
            "https://v.firebog.net/hosts/Prigent-Ads.txt"
            "https://raw.githubusercontent.com/FadeMind/hosts.extras/master/add.2o7Net/hosts"
            "https://raw.githubusercontent.com/crazy-max/WindowsSpyBlocker/master/data/hosts/spy.txt"
            "https://hostfiles.frogeye.fr/firstparty-trackers-hosts.txt"
          ];
          malicious = [
            "https://raw.githubusercontent.com/DandelionSprout/adfilt/master/Alternate%20versions%20Anti-Malware%20List/AntiMalwareHosts.txt"
            "https://osint.digitalside.it/Threat-Intel/lists/latestdomains.txt"
            "https://s3.amazonaws.com/lists.disconnect.me/simple_malvertising.txt"
            "https://v.firebog.net/hosts/Prigent-Crypto.txt"
            "https://raw.githubusercontent.com/FadeMind/hosts.extras/master/add.Risk/hosts"
            "https://v.firebog.net/hosts/RPiList-Phishing.txt"
            "https://v.firebog.net/hosts/RPiList-Malware.txt"
          ];
          misc = [
            "https://zerodot1.gitlab.io/CoinBlockerLists/hosts_browser"
            "https://raw.githubusercontent.com/StevenBlack/hosts/master/alternates/fakenews-only/hosts"
          ];
          catchall = [ "https://big.oisd.nl/domainswild" ];
          custom = [ customBlacklist ];
        };
        whiteLists = let
          customWhitelist = pkgs.writeText "misc.txt" ''
            ax.phobos.apple.com.edgesuite.net
            amp-api-edge.apps.apple.com
            (\.|^)dscx\.akamaiedge\.net$
            (\.|^)wac\.phicdn\.net$
            *.flake.sh
            *.clickhouse.com
            *.discord.com
            *.last.fm
            *.spotify.com
          '';
        in {
          ads = [
            "https://raw.githubusercontent.com/anudeepND/whitelist/master/domains/whitelist.txt"
            "https://raw.githubusercontent.com/anudeepND/whitelist/master/domains/optional-list.txt"
            "https://raw.githubusercontent.com/StevenBlack/hosts/master/hosts"
          ];
          misc = [ customWhitelist ];
        };
        #Configure what block categories are used
        clientGroupsBlock = {
          default = [ "ads" "tracking" "malicious" "misc" "catchall" "custom" ];
        };
      };
      customDNS = {
        customTTL = "1h";
        mapping = let Ip = "192.168.1.80"; in { };
      };
      redis = {
        address = "192.168.1.211:6381";
        password = "blocky";
        database = 0;
        required = false;
        connectionAttempts = 10;
        connectionCooldown = "5s";
      };
      caching = {
        minTime = "2h";
        maxTime = "12h";
        maxItemsCount = 0;
        prefetching = true;
        prefetchExpires = "2h";
        prefetchThreshold = 5;
      };
      prometheus = {
        enable = true;
        path = "/metrics";
      };
      queryLog = { type = "console"; };
    };
  };

}
