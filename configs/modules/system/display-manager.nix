{ pkgs, ... }: { environment.systemPackages = with pkgs; [ gdm ]; }
