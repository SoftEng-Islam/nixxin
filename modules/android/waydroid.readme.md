# Waydroid on NixOS - Guide & Useful Information

This document provides instructions for installing, configuring, and using Waydroid, particularly tailored for NixOS.

## Useful Resources

- [NixOS Waydroid Wiki](https://wiki.nixos.org/wiki/Waydroid)
- [Arch Linux Waydroid Wiki](https://wiki.archlinux.org/title/Waydroid)
- [Waydroid Images on SourceForge](https://sourceforge.net/projects/waydroid/files/images/)

---

## 1. Installation & Initialization

You can either install the images manually or let Waydroid download them. Configuration in NixOS is mostly imperative.

### Automatic Initialization

Initialize Waydroid with either FOSS or GAPPS images.

```bash
sudo waydroid init --system_type <FOSS|GAPPS>
# Or use the short flag for GAPPS:
# sudo waydroid init -s GAPPS -f
```

### Manual Image Installation

If you prefer to download the "system" and "vendor" images manually:

1. Download the appropriate images:

   ```bash
   wget "https://netix.dl.sourceforge.net/project/waydroid/images/vendor/waydroid_x86_64/lineage-20.0-20250809-MAINLINE-waydroid_x86_64-vendor.zip?viasf=1"
   wget "https://sourceforge.net/projects/waydroid/files/images/system/lineage/waydroid_x86_64/lineage-18.1-20250201-GAPPS-waydroid_x86_64-system.zip/download"
   ```

2. Extract the downloaded `system` and `vendor` archives.
3. Move `vendor.img` and `system.img` to `/etc/waydroid-extra/images/`:

   ```bash
   sudo mkdir -p /etc/waydroid-extra/images/
   sudo mv system.img vendor.img /etc/waydroid-extra/images/
   ```

4. Initialize Waydroid using the offline images:

   ```bash
   sudo waydroid init -f
   ```

---

## 2. NixOS Specific Configurations

### Fixing Binder Issues

If you encounter binder issues, manually mount `binderfs`:

```bash
sudo mkdir -p /dev/binderfs
sudo mount -t binder none /dev/binderfs
ls /dev/binderfs/
# It should show: binder, hwbinder, vndbinder
```

### Clipboard Support

Add `wl-clipboard` to your system packages for clipboard synchronization:

```nix
environment.systemPackages = with pkgs; [ wl-clipboard ];
```

### Linux Kernel 5.18+

Linux 5.18 and later removed `ashmem` in favor of `memfd`. Tell Waydroid (1.2.1+) to use the new module by appending to `/var/lib/waydroid/waydroid_base.prop`:

```properties
sys.use_memfd=true
```

### GPU Support

If you have an NVIDIA card or an RX 6800 series, you may need to adjust settings in `/var/lib/waydroid/waydroid_base.prop`:

```properties
ro.hardware.gralloc=default
ro.hardware.egl=swiftshader
```

### Multi-GPU Issues

To run Waydroid on the same GPU as the compositor (useful to fix graphical corruption on multi-GPU systems).
_Reference: [Arch Wiki - Multi-GPU](https://wiki.archlinux.org/title/Waydroid#Graphical_Corruption_on_multi-gpu_systems)_

Set nodes to the correct card (adjust the numbers accordingly):

```bash
sudo sed -i 's|/dev/dri/card0|/dev/dri/card1|' /var/lib/waydroid/lxc/waydroid/config_nodes
sudo sed -i 's|/dev/dri/renderD128|/dev/dri/renderD129|' /var/lib/waydroid/lxc/waydroid/config_nodes
```

**(Note: Rerun these after each `waydroid_script` invocation.)**

---

## 3. Starting Waydroid

1. Start the Waydroid LXC container:

   ```bash
   sudo systemctl start waydroid-container
   ```

   _Tip: Check if it worked via `sudo journalctl -u waydroid-container` (look for "Started Waydroid Container")._

2. Start the Waydroid session:

   ```bash
   waydroid session start &
   ```

   _Tip: It's finished when you see the message "Android with user 0 is ready"._

---

## 4. General Commands & Usage

- **Start Android UI**:

  ```bash
  waydroid show-full-ui
  ```

- **List Installed Android Apps**:

  ```bash
  waydroid app list
  ```

- **Launch an Android App**:

  ```bash
  waydroid app launch <application name>
  ```

- **Install an APK**:

  ```bash
  waydroid app install </path/to/app.apk>
  ```

- **Enter the LXC Shell**:

  ```bash
  sudo waydroid shell
  ```

- **Update Waydroid Android Image**:

  ```bash
  sudo waydroid upgrade
  ```

---

## 5. Hacks, Tweaks & Fixes

### Waydroid Script

A helpful community script used to install microG, libndk (ARM translation), and more.
[casualsnek/waydroid_script](https://github.com/casualsnek/waydroid_script)

```bash
git clone https://github.com/casualsnek/waydroid_script.git
cd waydroid_script
python -m venv .venv
source .venv/bin/activate.fish # Use activate, activate.fish, or activate.csh based on your shell
pip install -r requirements.txt

# Install useful modules
sudo python main.py install microg
sudo python main.py install libndk
sudo python main.py hack hidestatusbar
```

### Certify with Google Play Store

If you installed a GAPPS image, you will likely need to register your device ID to use Google services.

1. Get your Android ID:

   ```bash
   sudo waydroid shell
   ANDROID_RUNTIME_ROOT=/apex/com.android.runtime ANDROID_DATA=/data ANDROID_TZDATA_ROOT=/apex/com.android.tzdata ANDROID_I18N_ROOT=/apex/com.android.i18n sqlite3 /data/data/com.google.android.gsf/databases/gservices.db "select * from main where name = \"android_id\";"
   ```

2. Copy the numerical ID and register it at: [Google Uncertified Device Registration](https://www.google.com/android/uncertified).

### Window System Configuration

- **Enable Windowed Applications** (Multi-Windows):

  ```bash
  waydroid prop set persist.waydroid.multi_windows true
  ```

- **Set Specific Window Size**:

  ```bash
  waydroid prop set persist.waydroid.width <WIDTH>  # e.g., 608
  waydroid prop set persist.waydroid.height <HEIGHT>
  ```

- **Reset Window Size**:

  ```bash
  sudo waydroid shell
  wm size reset
  ```

### Storage Permissions Fix (e.g., Arknights)

Some games do not use the proper storage mechanism and require insecure permissions granting full access.

```bash
sudo waydroid shell
chmod 777 -R /sdcard/Android
chmod 777 -R /data/media/0/Android
chmod 777 -R /sdcard/Android/data
chmod 777 -R /data/media/0/Android/obb
chmod 777 -R /mnt/*/*/*/*/Android/data
chmod 777 -R /mnt/*/*/*/*/Android/obb
```

### Tidying Up Desktop Entries

Hide unnecessary Waydroid app shortcuts from your native desktop launcher:

```bash
sed -i 's|\[Desktop Entry\]|[Desktop Entry]\nNoDisplay=true|' ~/.local/share/applications/waydroid.*.desktop
```
