{ settings, pkgs, ... }: {
  environment.systemPackages = with pkgs; [
    ansible # automation scripts
    awscli
    mkcert # create certificates (HTTPS)
    ngrok # expose web server
    stripe-cli
    watchman # required by react native
    jira-cli-go
  ];
}
