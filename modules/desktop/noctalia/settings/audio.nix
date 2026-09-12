{
  pkgs,
  ...
}:
let
  messageSound = "${pkgs.sound-theme-freedesktop}/share/sounds/freedesktop/stereo/bell.oga";
in
{
  audio = {
    enable_overdrive = true; # allow volume above 100% (up to 150%)
    enable_sounds = true; # master toggle for UI feedback sounds
    sound_volume = 0.4; # 0.0 - 1.0
    volume_change_sound = ""; # empty = bundled sounds/volume-change.wav
    notification_sound = "${messageSound}"; # empty = bundled sounds/notification.wav
  };
}
