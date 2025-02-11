{ settings, lib, pkgs, ... }: {
  environment.systemPackages = with pkgs; [
    # Ruby
    ruby_3_3 # An object-oriented language for quick and easy programming
    rubyPackages.execjs
  ];
}
