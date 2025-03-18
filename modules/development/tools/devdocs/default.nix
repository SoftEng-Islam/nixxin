{ settings, lib, pkgs, ... }:
let inherit (lib) mkIf;
in mkIf (settings.modules.developement.tools.devdocs.enable) {
  # git clone https://github.com/freeCodeCamp/devdocs && cd devdocs
  # - Install The Requirements
  # - Ruby 3.4.1
  # - libcurl
  # Once you have these installed, run the following commands:
  # git clone https://github.com/freeCodeCamp/devdocs.git && cd devdocs
  # gem install bundler
  # bundle install
  # bundle exec thor docs:download --default
  # bundle exec rackup
}
