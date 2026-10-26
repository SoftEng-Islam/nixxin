{ settings, pkgs, ... }:
let
  media = "/home/${settings.user.username}/.local/share/waydroid/data/media/0";

  watcher = pkgs.writeShellScript "waydroid-media-watch" ''
    mkdir -p "${media}/DCIM" "${media}/Pictures"
    echo "watching ${media}/DCIM and ${media}/Pictures ..."

    inotifywait -m -r -q \
      -e close_write -e moved_to -e create \
      --format '%w%f' "${media}/DCIM" "${media}/Pictures" |
    while read -r f; do
      if [ -d "$f" ]; then chown 1023:1023 "$f"; chmod 770 "$f"; continue; fi
      [ -f "$f" ] || continue

      chown 1023:1023 "$f"
      chmod 660 "$f"
      sleep 1

      rel="/sdcard/''${f#${media}/}"
      echo "indexing: $rel"
      waydroid shell -- content call --uri content://media/ \
        --method scan_file --arg "$rel" || true
    done
  '';
in
{
  systemd.services.waydroid-media-watch = {
    description = "Index files added to Waydroid media from the host";
    wantedBy = [ "multi-user.target" ];
    after = [ "waydroid-container.service" ];

    path = with pkgs; [
      inotify-tools
      waydroid
      lxc
      coreutils
      util-linux
    ];

    serviceConfig = {
      ExecStart = watcher;
      Restart = "always";
      RestartSec = 5;
    };
  };
}
