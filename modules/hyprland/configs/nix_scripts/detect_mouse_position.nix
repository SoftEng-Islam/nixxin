{ pkgs, ... }:

let
  detect-mouse-position = pkgs.writeShellScriptBin "detect-mouse-position" ''
    #!/bin/sh
    while true; do
      # Get mouse position (format: "x,y")
      pos=$(${pkgs.hyprland}/bin/hyprctl cursorpos -j | ${pkgs.jq}/bin/jq -r '"\(.x),\(.y)"')
      x=''${pos%,*}
      y=''${pos#*,}

      # Get screen resolution
      res=$(${pkgs.hyprland}/bin/hyprctl monitors -j | ${pkgs.jq}/bin/jq -r '.[0].width,.[0].height' | tr '\n' ',')
      width=''${res%,*}
      height=''${res#*,}

      # Define edge threshold (e.g., 10 pixels)
      edge_threshold=10

      # Run overview if the Bottom Edge is reached
      if (( y >= height - edge_threshold )); then
        ${pkgs.hyprland}/bin/hyprctl dispatch overview:toggle
      fi

      # Check edges
      #if (( x <= edge_threshold )); then
        # ${pkgs.libnotify}/bin/notify-send "Left edge reached!"   # Replace with your action
      #elif (( x >= width - edge_threshold )); then
        # ${pkgs.libnotify}/bin/notify-send "Right edge reached!"  # Replace with your action
      #elif (( y <= edge_threshold )); then
        # ${pkgs.libnotify}/bin/notify-send "Top edge reached!"    # Replace with your action
      #elif (( y >= height - edge_threshold )); then
        #${pkgs.libnotify}/bin/notify-send "Bottom edge reached!" # Replace with your action
      #fi

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
