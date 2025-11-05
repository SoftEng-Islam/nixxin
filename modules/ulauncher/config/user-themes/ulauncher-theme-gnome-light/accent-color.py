#!/usr/bin/env python3

import subprocess
import json
import re
from pathlib import Path

ACCENT_COLORS = {
    "blue": "#3584e4",
    "teal": "#2190a4",
    "green": "#3a944a",
    "yellow": "#c88800",
    "orange": "#ed5b00",
    "red": "#e62d42",
    "pink": "#d56199",
    "purple": "#9141ac",
    "slate": "#6f8396",
}


def get_gnome_accent_color():
    result = subprocess.run(
        ["gsettings", "get", "org.gnome.desktop.interface", "accent-color"],
        capture_output=True,
        text=True,
        check=True,
    )
    return result.stdout.strip().strip("'")


def update_manifest_json(manifest_path, hex_color):
    with open(manifest_path, "r") as f:
        manifest = json.load(f)
    manifest["matched_text_hl_colors"]["when_selected"] = hex_color
    manifest["matched_text_hl_colors"]["when_not_selected"] = hex_color

    with open(manifest_path, "w") as f:
        json.dump(manifest, f, indent=2)
    print(f"Updated {manifest_path} with {hex_color}")


def update_theme_css(css_path, hex_color):
    with open(css_path, "r") as f:
        css_content = f.read()

    new_css = re.sub(
        r"@define-color selected_bg_color #[0-9a-fA-F]{6};",
        f"@define-color selected_bg_color {hex_color};",
        css_content,
    )

    with open(css_path, "w") as f:
        f.write(new_css)
    print(f"Updated {css_path} with {hex_color}")


def restart_ulauncher():
    try:
        subprocess.run(["pkill", "-f", "ulauncher"], check=True)
        print("Ulauncher process terminated")
    except subprocess.CalledProcessError:
        print("No running Ulauncher process found")

    subprocess.Popen(
        ["ulauncher"], stdout=subprocess.DEVNULL, stderr=subprocess.DEVNULL
    )
    print("Ulauncher restarted")


def main():
    theme_dir = (
        Path.home()
        / ".config"
        / "ulauncher"
        / "user-themes"
        / "ulauncher-theme-gnome-light"
    )
    manifest_file = theme_dir / "manifest.json"
    css_file = theme_dir / "theme.css"

    accent_color = get_gnome_accent_color()
    hex_color = ACCENT_COLORS.get(accent_color)
    if not hex_color:
        print(
            f"Unsupported color: {accent_color}. Supported: {', '.join(ACCENT_COLORS.keys())}"
        )
        exit(1)

    update_manifest_json(manifest_file, hex_color)
    update_theme_css(css_file, hex_color)
    restart_ulauncher()
    print(f"Done!")


if __name__ == "__main__":
    main()

