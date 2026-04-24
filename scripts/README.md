# Scripts Layout

This directory is organized by domain so the Nix modules and standalone shell
scripts are easier to scan and maintain.

## Categories

- `desktop/`: Hyprland, wallpaper, and desktop-session helpers.
- `media/`: video encoding and media inspection tools.
- `network/`: connectivity and Wi-Fi management helpers.
- `system/`: diagnostics, hardware investigation, and system service helpers.

## Structure

- Each category can expose a `default.nix` entrypoint.
- `scripts/default.nix` imports only category entrypoints.
- Standalone shell scripts live next to related Nix modules when they belong to
  the same domain.

## Notes

- Generated files such as encoder status logs should stay out of version
  control.
