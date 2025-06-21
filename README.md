# nixxin

**Nixos** Enhancement Configurations


![image](https://github.com/user-attachments/assets/b6d1ebd9-0fbd-4061-ba10-5c9286387bc3)



> [!WARNING]
>
> - Please don't use this Project, still under development.
>

This repository is home to the Nix code that builds my systems.
Issues, PRs and questions are welcome!

## Modules

The config is modular, you can either specify settings inside [`flake.nix`](https://github.com/SoftEng-Islam/nixxin/blob/main/flake.nix) or/and
exclude/include some modules inside profiles directory with:

```nix
imports = [
    ./import1.nix
    ./import2.nix
    ...
];
```

## Profiles

The configuration is separated into several profiles:

- Personal - personal laptop/desktop
- Work - work laptop (included in the Personal profile)

Each profile contains a `configuration.nix` for system-level configuration and a
`home.nix` for user-level configuration.
Setting the `profile` variable in [`flake.nix`](https://github.com/SoftEng-Islam/nixxin/blob/main/flake.nix) automatically sources the correct `configuration.nix` and `home.nix`.

## Installation

I suppose, you already installed NixOS.
To get this config running, start by cloning the repo:

```bash
git clone https://github.com/SoftEng-Islam/nixxin.git ~/nixxin
```

To get the hardware configuration on a new system, either copy from
`/etc/nixos/hardware-configuration.nix` or run:

```bash
cd ~/nixxin
sudo nixos-generate-config --show-hardware-config > profiles/desktop/hardware-configuration.nix
```

> [!WARNING]
>
> - Don't use my hardware configuration, your system won't boot!
>

Now, it's time to configure `settings.nix` (and probably profiles) to your liking.
Once the variables are set, then switch into the system configuration by running:

```bash
cd ~/nixxin
sudo nixos-rebuild switch --flake .
```

Home manager can be installed with:

```bash
nix-channel --add https://github.com/nix-community/home-manager/archive/master.tar.gz home-manager
nix-channel --update
nix-shell '<home-manager>' -A install
```

If home-manager starts to not cooperate, it may be because the unstable branch
of nixpkgs is in the Nix channel list. This can be fixed via:

```bash
nix-channel --add https://nixos.org/channels/nixpkgs-unstable
nix-channel --update
```

Home-manager may also not work without re-logging back in after it has been
installed. Once home-manager is running, the home-manager configuration can be
installed with:

```bash
cd ~/nixxin
home-manager switch --flake .
```

## Themes

<!-- ![Screen](./assets/catppuccin/overview.png)

![Screen2](./assets/gruvbox/overview.png)

![Screen3](./assets/everforest/overview.png) -->

## Extra

to Update the Input Use the following command to update just one input:
```bash
    sudo nix flake update <input-name>
```
Replace <input-name> with the name of the input you want to update.
Example:
```bash
    sudo nix flake update hyprland
```

## Errors

use `journalctl` to find problems:
```bash
    # home-manager errors
    journalctl -xe | grep home-manager
    # OR and replace [user] with your username like home-manager-softeng
    journalctl -xeu home-manager-[user].service | tail -50

    # Boot Errors
    # Show all errors from the current boot:
    journalctl -b -p err

    # Or to include warnings:
    journalctl -b -p warning

    # To see the previous boot (e.g. after a reboot):
    journalctl -b -1 -p err
    # You can go back further with -2, -3, etc.

    # 🔁 2. Reboot/Shutdown Errors
    # To see logs from the last shutdown or reboot, you can look at sessions that ended:
    journalctl --list-boots
    # You’ll see something like:
    # -2 9d2d9c7a1b504d9fbb65dd... Wed 2025-06-20
    # -1 1d12c34b5a234abcd123456... Thu 2025-06-21
    #  0 abcdef1234567890abcdef... Fri 2025-06-21
    # Then use one of the boots:
    journalctl -b -1 -p err

    # For shutdown logs, filter by shutdown target:
    journalctl | grep -i shutdown

    # Or use:
    journalctl -u systemd-poweroff.service
    journalctl -u systemd-shutdown

    # To watch the shutdown and reboot steps in more detail:
    journalctl -b -1 | grep -Ei 'reboot|shutdown|poweroff|failed|error'

    # 🔧 3. Save All Errors to a File
    # You can store all logs for inspection:
    journalctl -b -1 -p err > previous-boot-errors.log
    journalctl -b -0 -p err > current-boot-errors.log

    # 🧼 Optional: Filter Only NixOS-Related Services
    #To focus on system services (NixOS modules), filter for systemd units:
    journalctl -b -0 -p err -u '*'
```

use chmod u+w /to/path if you have permissions errors:
Error:
```bash
PermissionError: [Errno 13] Permission denied: '/home/softeng/.cache/ignis/wallpaper'
```

Fix:
```bash
chmod u+w /home/softeng/.cache/ignis/wallpaper
ls -ld /home/softeng/.cache/ignis/wallpaper
```


## Credits

Enjoy!

<!-- ![Screenshot](./screenshot.png) -->
