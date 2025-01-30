# https://ulauncher.io/
{ settings, config, pkgs, lib, ... }:
let
  ulauncher = pkgs.ulauncher.overrideAttrs (old:
    with pkgs.python3Packages; {
      propagatedBuildInputs = old.propagatedBuildInputs
        ++ [ pytz pint simpleeval distutils ];
    });
in {
  home.packages = [ ulauncher ];

  systemd.user.services.ulauncher = {
    Unit = {
      Description = "Linux Application Launcher";
      Documentation = "https://ulauncher.io/";
    };
    Service = {
      Environment = [
        "PATH=${
          lib.strings.makeBinPath [
            "$HOME/.nix-profile"
            "/etc/profiles/per-user/${settings.users.selected.username}"
            "${config.xdg.stateHome}/nix/profile"
            "/run/current-system/sw"
          ]
        }"
      ];
      ExecStart = "${ulauncher}/bin/ulauncher --hide-window";
    };
    Install = { WantedBy = [ "graphical-session.target" ]; };
  };

  # xdg.configFile."ulauncher/settings.json".text = ''
  # {
  #   "blacklisted-desktop-dirs": "/usr/share/locale:/usr/share/app-install:/usr/share/kservices5:/usr/share/fk5:/usr/share/kservicetypes5:/usr/share/applications/screensavers:/usr/share/kde4:/usr/share/mimelnk",
  #   "clear-previous-query": true,
  #   "grab-mouse-pointer": true,
  #   "hotkey-show-app": "<Primary>space",
  #   "render-on-screen": "mouse-pointer-monitor",
  #   "show-indicator-icon": false,
  #   "show-recent-apps": "3",
  #   "terminal-command": "alactritty",
  #   "theme-name": "adwaita"
  # }
  # '';
  # xdg.configFile."ulauncher/extensions.json".text = ''
  # {
  #   "com.github.fsevenm.ulauncher-uuid": {
  #       "id": "com.github.fsevenm.ulauncher-uuid",
  #       "url": "https://github.com/fsevenm/ulauncher-uuid",
  #       "updated_at": "2022-09-15T11:59:36.115610",
  #       "last_commit": "2fbb70fd2af246277b2baff03465bc8bd971c85f",
  #       "last_commit_time": "2021-01-14T04:26:08"
  #   },
  #   "com.github.brpaz.ulauncher-encoder": {
  #       "id": "com.github.brpaz.ulauncher-encoder",
  #       "url": "https://github.com/brpaz/ulauncher-encoder",
  #       "updated_at": "2022-09-15T11:59:38.989186",
  #       "last_commit": "8b9f499df983c179f44830111b8a100436389005",
  #       "last_commit_time": "2022-06-13T14:30:16"
  #   },
  #   "com.github.friday.ulauncher-hash2": {
  #       "id": "com.github.friday.ulauncher-hash2",
  #       "url": "https://github.com/friday/ulauncher-hash2",
  #       "updated_at": "2021-12-16T22:42:52.894367",
  #       "last_commit": "7478980b8fd6d9da3454dd0fb9ec232d7457a3c6",
  #       "last_commit_time": "2021-05-01T06:18:09"
  #   },
  #   "com.github.brpaz.ulauncher-timestamp": {
  #       "id": "com.github.brpaz.ulauncher-timestamp",
  #       "url": "https://github.com/brpaz/ulauncher-timestamp",
  #       "updated_at": "2022-09-15T11:59:40.710531",
  #       "last_commit": "e366a81f92b8130dddc0b1bddecad253124c49b9",
  #       "last_commit_time": "2021-12-12T15:49:08"
  #   },
  #   "com.github.ulauncher.ulauncher-emoji": {
  #       "id": "com.github.ulauncher.ulauncher-emoji",
  #       "url": "https://github.com/Ulauncher/ulauncher-emoji",
  #       "updated_at": "2022-09-15T11:59:45.586342",
  #       "last_commit": "4c6af50d1c9a24d5aad2c597634ff0c634972a5c",
  #       "last_commit_time": "2021-08-08T19:19:59"
  #   },
  #   "com.github.episode6.ulauncher-system-management-direct": {
  #       "id": "com.github.episode6.ulauncher-system-management-direct",
  #       "url": "https://github.com/episode6/ulauncher-system-management-direct",
  #       "updated_at": "2022-09-15T11:59:47.456106",
  #       "last_commit": "c6c0febff9eae884e4a8bc97d057480436fb5c9b",
  #       "last_commit_time": "2020-07-22T18:41:36"
  #   },
  #   "com.github.tchar.ulauncher-albert-calculate-anything": {
  #       "id": "com.github.tchar.ulauncher-albert-calculate-anything",
  #       "url": "https://github.com/tchar/ulauncher-albert-calculate-anything",
  #       "updated_at": "2022-09-22T14:12:11.143854",
  #       "last_commit": "ee0903174c8b87cd1f7c3b6c1acef10702547507",
  #       "last_commit_time": "2021-08-12T06:39:56"
  #   }
  # }
  # '';
  # xdg.configFile."ulauncher/shortcuts.json".text = ''
  # {
  #   "83bb140c-309c-45ff-ac87-603e3904a7d7": {
  #       "id": "83bb140c-309c-45ff-ac87-603e3904a7d7",
  #       "name": "Screenshot (select window)",
  #       "keyword": "screenshot window",
  #       "cmd": "grimshot save window - | swappy -f -",
  #       "icon": null,
  #       "is_default_search": false,
  #       "run_without_argument": true,
  #       "added": 1664798574.9109719
  #   },
  #   "fd4d657f-0153-4865-9b93-646aad54b93b": {
  #       "id": "fd4d657f-0153-4865-9b93-646aad54b93b",
  #       "name": "Screenshot (select area)",
  #       "keyword": "screenshot area",
  #       "cmd": "grimshot save area - | swappy -f -",
  #       "icon": null,
  #       "is_default_search": false,
  #       "run_without_argument": true,
  #       "added": 1664798710.1628673
  #   },
  #   "ec4dea36-0c35-44a7-a402-ef456d764a98": {
  #       "id": "ec4dea36-0c35-44a7-a402-ef456d764a98",
  #       "name": "Screenshot (current output)",
  #       "keyword": "screenshot output",
  #       "cmd": "grimshot save output - | swappy -f -",
  #       "icon": null,
  #       "is_default_search": false,
  #       "run_without_argument": true,
  #       "added": 1664798761.6198936
  #   },
  #   "94548c73-be21-4089-a5fd-50d16bc82542": {
  #       "id": "94548c73-be21-4089-a5fd-50d16bc82542",
  #       "name": "Screenshot (all outputs)",
  #       "keyword": "screenshot output all",
  #       "cmd": "grimshot save screen - | swappy -f -",
  #       "icon": null,
  #       "is_default_search": false,
  #       "run_without_argument": true,
  #       "added": 1664798788.4646192
  #   },
  #   "eb79f80f-524a-4b15-8547-f439edb526e4": {
  #       "id": "eb79f80f-524a-4b15-8547-f439edb526e4",
  #       "name": "Screenshot (active window)",
  #       "keyword": "screenshot",
  #       "cmd": "grimshot save active - | swappy -f -",
  #       "icon": null,
  #       "is_default_search": false,
  #       "run_without_argument": true,
  #       "added": 1664798857.858495
  #   }
  # }
  # '';

}
