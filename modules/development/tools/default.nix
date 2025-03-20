{ settings, config, lib, pkgs, ... }:
let inherit (lib) mkIf;
in {
  imports = lib.optionals (settings.modules.development.tools.enable or false) [
    ./devdocs
    # ./ide
  ];
  config = mkIf (settings.modules.development.tools.enable or false) {

    environment.systemPackages = with pkgs; [
      ansible # automation scripts
      awscli # Unified tool to manage your AWS services
      mkcert # create certificates (HTTPS)
      ngrok # expose web server
      stripe-cli # Command-line tool for Stripe
      watchman # required by react native
      jira-cli-go # Feature-rich interactive Jira command line
    ];
  };
}
