{
  description = "Softeng Nixxin Configuration";

  inputs = {
    # channels
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    home-manager.url = "github:nix-community/home-manager/master";
    home-manager.inputs.nixpkgs.follows = "nixpkgs";

    # `ucodenix` is a Nix flake providing AMD microcode updates for unsupported CPUs.
    ucodenix.url = "github:e-tho/ucodenix";
    # System-wide colorscheming and typography for NixOS
    stylix.url = "github:danth/stylix";
    # Efficient animated wallpaper daemon for wayland, controlled at runtime
    swww.url = "github:LGFae/swww";
    # superfile.url = "github:yorukot/superfile";

    # third party nixpkgs|overlays|modules
    ags = {
      url = "github:Aylur/ags";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nix-ld = {
      url = "github:Mic92/nix-ld";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    hyprland = {
      type = "git";
      url = "https://github.com/hyprwm/Hyprland";
      submodules = true;
    };
    hyprland-plugins = {
      url = "github:hyprwm/hyprland-plugins";
      inputs.hyprland.follows = "hyprland";
    };
    hyprpicker = {
      url = "github:hyprwm/hyprpicker";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    pyprland = {
      url = "github:hyprland-community/pyprland";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    # others
    retroarch-shaders.url = "github:libretro/glsl-shaders";
    retroarch-shaders.flake = false;

    # terminal tools
    fuzzy-sys.url = "github:NullSense/fuzzy-sys";
    fuzzy-sys.flake = false;

    kitty-scrollback-nvim.url = "github:mikesmithgh/kitty-scrollback.nvim";
    kitty-scrollback-nvim.flake = false;
    kitty-smart-scroll.url = "github:yurikhan/kitty-smart-scroll";
    kitty-smart-scroll.flake = false;
    kitty-smart-tab.url = "github:yurikhan/kitty-smart-tab";
    kitty-smart-tab.flake = false;

    smart-splits-nvim.url = "github:mrjones2014/smart-splits.nvim";
    smart-splits-nvim.flake = false;

    zsh-autocomplete.url =
      "github:wochap/zsh-autocomplete?rev=d52da825c2b60b664f33e8d82fdfc1c3b647b753";
    zsh-autocomplete.flake = false;
    zsh-defer.url =
      "github:romkatv/zsh-defer?rev=1c75faff4d8584afe090b06db11991c8c8d62055";
    zsh-defer.flake = false;
    zsh-history-substring-search.url =
      "github:zsh-users/zsh-history-substring-search?rev=8dd05bfcc12b0cd1ee9ea64be725b3d9f713cf64";
    zsh-history-substring-search.flake = false;
    zsh-notify.url =
      "github:marzocchi/zsh-notify?rev=9c1dac81a48ec85d742ebf236172b4d92aab2f3f";
    zsh-notify.flake = false;
    zsh-vi-mode.url =
      "github:wochap/zsh-vi-mode?rev=6091e2bc63cd076f94583a6d51eda74980566d28";
    zsh-vi-mode.flake = false;
    zsh-pnpm-shell-completion.url = "github:g-plane/pnpm-shell-completion";
    zsh-pnpm-shell-completion.flake = false;
    figlet-fonts.url = "github:wochap/figlet-fonts";
    figlet-fonts.flake = false;
    ipwebcam-gst.url =
      "github:agarciadom/ipwebcam-gst?rev=5a02ffae8597ab1cc7461f096f86ca233f925a07";
    ipwebcam-gst.flake = false;
    tmux-sessionx.url =
      "github:omerxx/tmux-sessionx?rev=ac9b0ec219c2e36ce6beb3f900ef852ba8888095";
    nnn-cppath.url =
      "github:raffaem/nnn-cppath?rev=1d3f4f64d43533d203af82c61f4a93afc8d5aaf5";
    nnn-cppath.flake = false;

    # themes
    dracula-lsd.url =
      "github:dracula/lsd?rev=75f3305a2bba4dacac82b143a15d278daee28232";
    dracula-lsd.flake = false;
    catppuccin-grub.url = "github:catppuccin/grub";
    catppuccin-grub.flake = false;
    catppuccin-alacritty.url = "github:catppuccin/alacritty";
    catppuccin-alacritty.flake = false;
    catppuccin-amfora.url = "github:catppuccin/amfora";
    catppuccin-amfora.flake = false;
    catppuccin-bat.url = "github:catppuccin/bat";
    catppuccin-bat.flake = false;
    catppuccin-bottom.url = "github:catppuccin/bottom";
    catppuccin-bottom.flake = false;
    catppuccin-dircolors.url = "github:wochap/dircolors";
    catppuccin-dircolors.flake = false;
    catppuccin-discord.url = "github:catppuccin/discord";
    catppuccin-discord.flake = false;
    catppuccin-kitty.url = "github:catppuccin/kitty";
    catppuccin-kitty.flake = false;
    catppuccin-lazygit.url = "github:catppuccin/lazygit";
    catppuccin-lazygit.flake = false;
    catppuccin-delta.url = "github:catppuccin/delta";
    catppuccin-delta.flake = false;
    catppuccin-neomutt.url = "github:catppuccin/neomutt";
    catppuccin-neomutt.flake = false;
    catppuccin-newsboat.url = "github:catppuccin/newsboat";
    catppuccin-newsboat.flake = false;
    catppuccin-qutebrowser.url = "github:catppuccin/qutebrowser";
    catppuccin-qutebrowser.flake = false;
    catppuccin-zathura.url = "github:catppuccin/zathura";
    catppuccin-zathura.flake = false;
    catppuccin-zsh-fsh.url = "github:catppuccin/zsh-fsh";
    catppuccin-zsh-fsh.flake = false;
    catppuccin-tmux.url = "github:catppuccin/tmux";
    catppuccin-tmux.flake = false;
    catppuccin-mpv.url = "github:catppuccin/mpv";
    catppuccin-mpv.flake = false;
    catppuccin-foot.url = "github:catppuccin/foot";
    catppuccin-foot.flake = false;
    catppuccin-obs.url = "github:catppuccin/obs";
    catppuccin-obs.flake = false;
  };

  outputs = inputs@{ self, nixpkgs, home-manager, ... }:
    let
      settings = import (./. + "/settings.nix") { inherit pkgs; };
      pkgs = import nixpkgs { system = settings.system; };

      mkLib = pkgs: system:
        let
          lib = pkgs.lib.extend (final: prev: {
            home-manager = inputs.home-manager.lib.hm;
            _custom = import ./lib {
              pkgs = import pkgs { inherit system; };
              inherit inputs;
              inherit lib;
            };
          });
        in lib;
      mkNixosSystem = pkgs: system: hostName:
        pkgs.lib.nixosSystem {
          inherit system;
          modules = [
            inputs.home-manager.nixosModules.home-manager
            inputs.stylix.nixosModules.stylix
            inputs.chaotic.nixosModules.default
            inputs.ucodenix.nixosModules.default
            inputs.nur.nixosModules.nur
            home-manager.nixosModules.home-manager
            # ./packages
            # (./. + "/hosts/${hostName}")
            (./. + "/profiles" + ("/" + settings.profile)
              + "/configuration.nix")
            (./. + "/profiles" + ("/" + settings.profile) + "/home.nix")

            {
              nixpkgs.config.allowUnfree = true;
              # nixpkgs.config.permittedInsecurePackages = [ "nodejs-14.21.3" ];
              networking.hostName = settings.hostName;
              home-manager.useGlobalPkgs = true;
              home-manager.useUserPackages = true;
              home-manager.users.jdoe = import ./home.nix;

              # Optionally, use home-manager.extraSpecialArgs to pass
              # arguments to home.nix
            }
          ];
          specialArgs = {
            inherit inputs;
            inherit settings;
            inherit system;
            lib = mkLib pkgs system;
            nixpkgs = pkgs;
          };
        };
    in {
      nixosConfigurations = {
        ${settings.username} =
          mkNixosSystem pkgs settings.system settings.hostName;
      };
    };
}
