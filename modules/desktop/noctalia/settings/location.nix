{
  # ── Location ──────────────────────────────────────────────────────────────────
  # Single source of "where am I"; feeds Weather, Night Light, and Theme auto mode.

  location = {
    auto_locate = true; # resolve coordinates from IP when true
    address = ""; # e.g. "Toronto, ON"; geocoded when auto_locate = false
    # latitude       = 52.5200;           # manual coordinates, used when auto_locate and address are off
    # longitude      = 13.4050;
    # custom_schedule = true;    # schedule day/night from the times below instead of coordinates
    # sunset         = "20:30";           # HH:MM — night start
    # sunrise        = "07:30";           # HH:MM — day start
  };
}
