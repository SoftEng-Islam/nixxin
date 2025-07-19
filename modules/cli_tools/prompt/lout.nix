{ pkgs, ... }: {
  environment.systemPackages = with pkgs; [
    lout
    (pkgs.writeShellScriptBin "lout" ''
      pkill -KILL -u $USER
    '')
  ];
}
