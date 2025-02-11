{ settings, pkgs, ... }: {
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
