{ pkgs, ... }: {
  #__ Nodejs & JavaScript Stuff __#
  environment.systemPackages = with pkgs; [
    nodejs_23 # Event-driven I/O framework for the V8 JavaScript engine
    nodePackages.pnpm # Fast, disk space efficient package manager
    typescript # Superset of JavaScript that compiles to clean JavaScript output
  ];
}
