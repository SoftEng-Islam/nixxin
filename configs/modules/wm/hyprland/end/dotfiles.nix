{ ... }: {
  xdg.configFile = {
    "ags".source = ./.config/ags;
    "fish".source = ./.config/fish;
    "foot".source = ./.config/foot;
    "fuzzel".source = ./.config/fuzzel;
    "mpv".source = ./.config/mpv;
    "thorium-flags.conf".source = ./.config/thorium-flags.conf;
    "starship.toml".source = ./.config/starship.toml;
  };
}

