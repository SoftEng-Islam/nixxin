{
  settings,
  lib,
  pkgs,
  ...
}:
let
  fm_settings = settings.modules.desktop.file_manager;
in
{
  # ---- Tracker3 ---- #
  services.gnome.tinysparql.enable = true; # indexing files
  services.gnome.localsearch.enable = true;

  nixpkgs.overlays = [
    (self: super: {
      gnome = super.gnome.overrideScope (
        gself: gsuper: {
          nautilus = gsuper.nautilus.overrideAttrs (nsuper: {
            buildInputs =
              nsuper.buildInputs
              ++ (with pkgs; [
                gst_all_1.gst-plugins-good
                gst_all_1.gst-plugins-bad
                gst_all_1.gst-plugins-base
                gst_all_1.gstreamer
                gst_all_1.gst-libav
              ]);
          });
        }
      );
    })
  ];

  home-manager.users.${settings.user.username} = {
    systemd.user.services =
      lib.optionalAttrs (fm_settings.default == "nauitlus" || fm_settings.default == "nautilus")
        {
          nautilus-keepalive = {
            Unit = {
              Description = "Nautilus keep-alive";
              After = [ "graphical-session.target" ];
              Wants = [ "graphical-session.target" ];
              PartOf = [ "graphical-session.target" ];
            };
            Service = {
              ExecStart = "${pkgs.nautilus}/bin/nautilus --gapplication-service";
              Restart = "on-failure";
            };
            Install = {
              WantedBy = [ "graphical-session.target" ];
            };
          };
        };

    dconf.settings = {
      "org/gnome/nautilus/preferences" = {
        always-use-location-entry = true;
        default-folder-viewer = "icon-view"; # "icon-view", "list-view"
        migrated-gtk-settings = true;
        search-filter-time-type = "last_modified";
        search-view = "list-view";
        show-create-link = true;
        show-delete-permanently = true;
        show-hidden = false;
        sort-directories-first = true;
      };
      "org/gnome/nautilus/list-view" = {
        default-column-order = [
          "name"
          "size"
          "type"
          "owner"
          "group"
          "permissions"
          "where"
          "date_modified"
          "date_modified_with_time"
          "date_accessed"
          "recency"
          "starred"
          "detailed_type"
        ];
        default-visible-columns = [
          "name"
          "size"
          "type"
          "owner"
        ];
      };

      # "small" or "small-plus" or "medium" or "large" or "extra-large"
      "org/gnome/nautilus/icon-view" = {
        default-zoom-level = settings.modules.desktop.dconf.icons.icon_view_size;
      };
    };
  };

  environment.sessionVariables.FILE_MANAGER = "nautilus";

  environment.systemPackages = with pkgs; [
    nautilus

    # Desktop-neutral user information store, search tool and indexer
    tinysparql
  ];
}
