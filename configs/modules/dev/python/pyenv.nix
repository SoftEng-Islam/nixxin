{ pkgs, ... }:

let
  # A script to configure pyenv and install the required Python version and packages
  pyenvSetupScript = ''
    export PYENV_ROOT="$HOME/.pyenv"
    export PATH="$PYENV_ROOT/bin:$PATH"
    eval "$(pyenv init --path)"
    eval "$(pyenv init -)"
    pyenv install 3.13.1
    pyenv global 3.13.1
    pip install --upgrade pip
    pip install jinja2 flask django requests
  '';
in {
  environment.variables = {
    PYENV_ROOT = "$HOME/.pyenv";
    PATH = "$PYENV_ROOT/bin:$PATH";
  };
  # Add the script to the system's post-installation setup
  systemd.user.services.pyenv-setup = {
    description = "Setup pyenv and install Python packages";
    serviceConfig.ExecStart = "${pkgs.bash}/bin/bash -c '${pyenvSetupScript}'";
    wantedBy = [ "default.target" ];
  };
}
