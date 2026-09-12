{
  calendar = {
    enabled = true;
    refresh_minutes = 15;
  };

  # Calendar tab of the control center.
  control_center.calendar = {
    show_events_card = true;
    show_week_numbers = false; # ISO 8601 week numbers in the month grid
    event_date_format = "%A %e %B"; # date format used for events
    event_time_format = "%H:%M"; # time format used for events
  };
}
