{ settings, lib, pkgs, ... }: {
  i18n.inputMethod.fcitx5 = {
    addons = with pkgs; [
      fcitx5-m17n
      fcitx5-gtk
      fcitx5-configtool
      fcitx5-fluent
    ];

    ignoreUserConfig = true;

    # Enables Fcitx5’s Wayland native input method (works perfectly in Hyprland).
    waylandFrontend = true;

    # Input method configuration (English + Arabic)
    settings.inputMethod = {
      "Groups/0" = {
        "Name" = "Default";
        "Default Layout" = "us";
        "DefaultIM" = "keyboard-us";
      };
      "Groups/0/Items/0" = {
        "Name" = "keyboard-us";
        "Layout" = null;
      };
      "Groups/0/Items/1" = {
        "Name" = "keyboard-ar";
        "Layout" = null;
      };
      "GroupOrder" = { "0" = "Default"; };
    };

    # Global fcitx5 options — Alt+Shift switching
    settings.globalOptions = {
      "Hotkey/TriggerKeys" = "Alt+Shift";
      "Hotkey/AltTriggerKeys" = "Shift+Alt";

      Behavior = {
        ActiveByDefault = "False";
        PreeditEnabledByDefault = "True";
        ShowInputMethodInformation = "True";
        CompactInputMethodInformation = "True";
        PreloadInputMethod = "True";
        AutoSavePeriod = "30";
      };
    };
  };
  # Environment Variables for Input Method
  # See https://fcitx-im.org/wiki/Using_Fcitx_5_on_Wayland
  # https://fcitx-im.org/wiki/Setup_Fcitx_5
  environment.variables = {
    # Wayland-native input frontend
    INPUT_METHOD = "fcitx";

    QT_IM_MODULE = "fcitx";
    QT_IM_MODULES = "fcitx";

    # Legacy support for Xwayland apps (still required by many GUI programs).
    XMODIFIERS = "@im=fcitx";
    SDL_IM_MODULE = "fcitx";

    # Do NOT set GTK_IM_MODULE (avoids that warning)
    GTK_IM_MODULE = lib.mkForce "";
    GLFW_IM_MODULE = "ibus"; # fallback for some games
  };

}
