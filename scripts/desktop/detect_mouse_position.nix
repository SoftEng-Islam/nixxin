{ pkgs, ... }:

let
  detect-mouse-position = pkgs.writeShellScriptBin "detect-mouse-position" ''
    #!/run/current-system/sw/bin/bash
    # State tracking
    edge_triggered=false

    while true; do
      # Get mouse position (format: "x,y")
      pos=$(${pkgs.hyprland}/bin/hyprctl cursorpos -j)
      x=$(echo "$pos" | ${pkgs.jq}/bin/jq -r '.x')
      y=$(echo "$pos" | ${pkgs.jq}/bin/jq -r '.y')

      # Get screen resolution (properly handle JSON output)
      monitor=$(${pkgs.hyprland}/bin/hyprctl monitors -j | ${pkgs.jq}/bin/jq '.[0]')
      width=$(echo "$monitor" | ${pkgs.jq}/bin/jq -r '.width')
      height=$(echo "$monitor" | ${pkgs.jq}/bin/jq -r '.height')

      # Define edge threshold (e.g., 10 pixels)
      edge_threshold=1

      # Check bottom edge And
      # Run overview if the Bottom Edge is reached
      if [ "$y" -ge "$((height - edge_threshold))" ]; then
        if [ "$edge_triggered" = false ]; then
          ${pkgs.hyprland}/bin/hyprctl dispatch overview:toggle
          edge_triggered=true
        fi
      else
        edge_triggered=false  # Reset when leaving edge
      fi

      # if [ "$y" -ge "$((height - edge_threshold))" ]; then
      #   # ${pkgs.libnotify}/bin/notify-send "Bottom edge reached!"
      #   ${pkgs.hyprland}/bin/hyprctl dispatch overview:toggle
      # fi

      # Check edges (using proper integer comparison)
      #if [ "$x" -le "$edge_threshold" ]; then
        # ${pkgs.libnotify}/bin/notify-send "Left edge reached!"
      #elif [ "$x" -ge "$((width - edge_threshold))" ]; then
        # ${pkgs.libnotify}/bin/notify-send "Right edge reached!"
      #elif [ "$y" -le "$edge_threshold" ]; then
        # ${pkgs.libnotify}/bin/notify-send "Top edge reached!"
      #elif [ "$y" -ge "$((height - edge_threshold))" ]; then
        # ${pkgs.libnotify}/bin/notify-send "Bottom edge reached!"
        # Run overview if the Bottom Edge is reached
        # ${pkgs.hyprland}/bin/hyprctl dispatch overview:toggle
      # fi

      sleep 0.1  # Reduce CPU usage
    done
  '';
in {
  # Use the script in your system or home-manager config
  environment.systemPackages = [ detect-mouse-position ];

  systemd.user.services.mouse-edge-detector = {
    description = "Hyprland Mouse Edge Detection";
    wantedBy = [ "graphical-session.target" ];
    partOf = [ "graphical-session.target" ];
    serviceConfig = {
      ExecStart = "${detect-mouse-position}/bin/detect-mouse-position";
      Restart = "always";
    };
  };

  # home.packages = [ detect-mouse-position ];

  # systemd.user.services.mouse-edge-detector = {
  #   Unit = {
  #     Description = "Hyprland Mouse Edge Detection";
  #     PartOf = [ "graphical-session.target" ];
  #   };
  #   Service = {
  #     ExecStart = "${detect-mouse-position}/bin/detect-mouse-position";
  #     Restart = "always";
  #   };
  #   Install = {
  #     WantedBy = [ "graphical-session.target" ];
  #   };
  # };

}
