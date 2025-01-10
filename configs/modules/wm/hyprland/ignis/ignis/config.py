from ignis.utils import Utils
from ignis.app import IgnisApp
from ignis.services.wallpaper import WallpaperService
from ignis.services.material.util import render_templates
from modules import (
    Bar,
    ControlCenter,
    Launcher,
    NotificationPopup,
    OSD,
    Powermenu,
    Settings,
)

# Initialize Ignis and Wallpaper
app = IgnisApp.get_default()
WallpaperService.get_default()

# Add Icons and Apply CSS
app.add_icons(f"{Utils.get_current_dir()}/icons")
app.apply_css(Utils.get_current_dir() + "/style.scss")

# Render Material Templates
render_templates(
    output_dir=Utils.get_cache_dir() + "/material/",
    templates_dir=Utils.get_current_dir() + "/services/material/templates/",
    user_data={
        "primary_paletteKeyColor": "#ff0000",
        "secondary_paletteKeyColor": "#00ff00",
        "tertiary_paletteKeyColor": "#0000ff",
        # Add more color values here
        "background": "#121212",
        "onBackground": "#ffffff",
        # Add all necessary variables here...
        "dark_mode": "true",
    },
)

# GNOME and Hyprland Settings
Utils.exec_sh("gsettings set org.gnome.desktop.interface gtk-theme Material")
Utils.exec_sh("gsettings set org.gnome.desktop.interface icon-theme Papirus")
Utils.exec_sh(
    'gsettings set org.gnome.desktop.interface font-name "JetBrains Mono Regular 11"'
)
Utils.exec_sh("hyprctl reload")

# Add Modules
ControlCenter()

for monitor in range(Utils.get_n_monitors()):
    Bar(monitor)

for monitor in range(Utils.get_n_monitors()):
    NotificationPopup(monitor)

Launcher()
Powermenu()
OSD()
Settings()
