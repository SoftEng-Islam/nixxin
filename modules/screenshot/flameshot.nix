# An open-source screenshot software.
# https://flameshot.org/
{ settings, pkgs, ... }: {
  environment.systemPackages = with pkgs;
    [
      (flameshot.overrideAttrs (oldAttrs: {
        version = oldAttrs.version + "-unstable-latest";
        src = pkgs.fetchFromGitHub {
          owner = "flameshot-org";
          repo = "flameshot";
          rev = "c1dac52231024174faa68a29577129ebca125dff";
          hash = "sha256-Y9RnVxic5mlRIc48wYVQXrvu/s65smtMMVj8HBskHzE=";
        };
      }))
    ];
}
