{ pkgs, ... }: { environment.systemPackages = with pkgs; [ lout ]; }
