# nixxin

Nixos Enhancement Configuration

## My Nixos Configurations

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
* Work - work laptop (included in the Personal profile, as I work from home)

Each profile contains a `configuration.nix` for system-level configuration and a
`home.nix` for user-level configuration. Setting the `profile` variable in
[`flake.nix`](https://github.com/SoftEng-Islam/nixxin/blob/main/flake.nix) automatically sources the correct `configuration.nix` and `home.nix`.

## Installation

Enjoy!

<!-- ![Screenshot](./screenshot.png) -->
