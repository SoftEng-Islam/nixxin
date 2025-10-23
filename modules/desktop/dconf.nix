{ settings, lib, pkgs, ... }:

# you can try this command if you have any problem with gnome settings
# dconf reset -f /org/gnome/

# Run the following command to disable the Gnome check-alive-timeout or "App Not Responding" dialog:
# dconf write /org/gnome/mutter/debug/enable-frame-timing false
# gsettings set org.gnome.mutter check-alive-timeout 0

with lib.gvariant; {
  programs.dconf.enable = true;
  environment.systemPackages = with pkgs; [ dconf ];

  home-manager.users.${settings.user.username} = {
    dconf.settings = {
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
        default-visible-columns = [ "name" "size" "type" "owner" ];
      };

      "org/gnome/desktop/wm/preferences" = {
        # We don't want buttons because of using ( Hyprland + hyprbars)
        "button-layout" = lib.mkDefault "";
      };

      "org/gnome/nautilus/preferences" = {
        "default-folder-viewer" = "icon-view"; # "icon-view", "list-view"
        "migrated-gtk-settings" = true;
        "search-filter-time-type" = "last_modified";
        "search-view" = "list-view";
      };

      "org/gtk/gtk4/settings/file-chooser" = { "show-hidden" = true; };

      "org/gtk/settings/file-chooser" = {
        "date-format" = "regular";
        "location-mode" = "path-bar";
        "show-hidden" = true;
        "show-size-column" = true;
        "show-type-column" = true;
        "sort-column" = "name";
        "sort-directories-first" = false;
        "sort-order" = "ascending";
        "type-format" = "category";
        "view-type" = "list";
      };
    };
  };
}
