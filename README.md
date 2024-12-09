# nixxin

Nixos Enhancement Configurations

> [!WARNING]
>
> - Please don't use this script, still under development
>

This repository is home to the Nix code that builds my systems. Issues, PRs
and questions are welcome!

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

* Personal - personal laptop/desktop
* Work - work laptop (included in the Personal profile)

Each profile contains a `configuration.nix` for system-level configuration and a
`home.nix` for user-level configuration. Setting the `profile` variable in
[`flake.nix`](https://github.com/SoftEng-Islam/nixxin/blob/main/flake.nix) automatically sources the correct `configuration.nix` and `home.nix`.

## Installation

I suppose, you already installed NixOS. To get this config running, start by
cloning the repo:

```bash
git clone https://github.com/SoftEng-Islam/nixxin.git ~/.nixxin
```

To get the hardware configuration on a new system, either copy from
`/etc/nixos/hardware-configuration.nix` or run:

```bash
cd ~/.nixxin
sudo nixos-generate-config --show-hardware-config > profiles/desktop/hardware-configuration.nix
```

> [!WARNING]
>
> - Please don't use my hardware configuration, your system won't boot!
>

Enjoy!

<!-- ![Screenshot](./screenshot.png) -->
