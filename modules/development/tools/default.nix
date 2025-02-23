{ settings, lib, pkgs, ... }:
let inherit (lib) mkIf;
in mkIf (settings.modules.development.tools.enable) {
  environment.systemPackages = with pkgs; [
    ansible # automation scripts
    awscli # Unified tool to manage your AWS services
    mkcert # create certificates (HTTPS)
    ngrok # expose web server
    stripe-cli # Command-line tool for Stripe
    watchman # required by react native
    jira-cli-go # Feature-rich interactive Jira command line
  ];
}
