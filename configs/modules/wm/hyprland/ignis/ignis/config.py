from ignis.utils import Utils
from ignis.app import IgnisApp
from ignis.services.wallpaper import WallpaperService
from jinja2 import Environment, FileSystemLoader
import os

from modules import (
    Bar,
    ControlCenter,
    Launcher,
    NotificationPopup,
    OSD,
    Powermenu,
    Settings,
)

# Custom template rendering function
def render_templates(output_dir, templates_dir, user_data):
    env = Environment(loader=FileSystemLoader(templates_dir))
    os.makedirs(output_dir, exist_ok=True)

    for template_name in os.listdir(templates_dir):
        if template_name.endswith(".scss"):
            template = env.get_template(template_name)
            rendered_content = template.render(user_data)
            with open(os.path.join(output_dir, template_name), "w") as f:
                f.write(rendered_content)

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
        "background": "#121212",
        "onBackground": "#ffffff",
        "dark_mode": "true",
        # Add more color variables here
    },
)

# GNOME and Hyprland Settings
Utils.exec_sh("gsettings set org.gnome.desktop.interface gtk-theme Material")
Utils.exec_sh("gsettings set org.gnome.desktop.interface icon-theme Papirus-Dark")
Utils.exec_sh(
    'gsettings set org.gnome.desktop.interface font-name "JetBrainsMonoNL Nerd Font Mono 11"'
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
