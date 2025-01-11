import os
import ignis
from ignis.utils import Utils


MATERIAL_CACHE_DIR = f"{ignis.CACHE_DIR}/material"  # type: ignore

TEMPLATES = Utils.get_current_dir() + "/templates"
default_wallpaper = Utils.get_current_dir() + "/default.png"

os.makedirs(MATERIAL_CACHE_DIR, exist_ok=True)
