{ impurity, ... }: {
  xdg.configFile = {
    "ags".source = impurity.link ./.config/ags;
    "fish".source = impurity.link ./.config/fish;
    "foot".source = impurity.link ./.config/foot;
    "fuzzel".source = impurity.link ./.config/fuzzel;
    "mpv".source = impurity.link ./.config/mpv;
    "thorium-flags.conf".source = impurity.link ./.config/thorium-flags.conf;
    "starship.toml".source = impurity.link ./.config/starship.toml;
  };
}

