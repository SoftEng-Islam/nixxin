{ settings, ... }:
{
  home-manager.users.${settings.user.username} = {
    programs.noctalia-shell.settings = {
      location = {
        name = "Cairo";
        weatherEnabled = false;
        use12hourFormat = true;
        showWeekNumberInCalendar = false;
        weatherShowEffects = true;
        useFahrenheit = false;
        showCalendarEvents = true;
        showCalendarWeather = true;
        analogClockInCalendar = false;
        firstDayOfWeek = -1;
        hideWeatherTimezone = false;
        hideWeatherCityName = false;
      };
    };
  };
}
