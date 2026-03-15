{
  config,
  pkgs,
  ...
}: {
  home.packages = with pkgs; [
    taskwarrior-tui
  ];
  programs.taskwarrior = {
    enable = true;
    package = pkgs.taskwarrior3;
    colorTheme = "dark-blue-256";
    dataLocation = "${config.xdg.dataHome}/task";
    config = {
      confirmation = false;
      report = {
        minimal.filter = "status:pending";
        active.columns = [
          "id"
          "start"
          "entry.age"
          "priority"
          "project"
          "due"
          "description"
        ];
        active.labels = [
          "ID"
          "Started"
          "Age"
          "Priority"
          "Project"
          "Due"
          "Description"
        ];
        # taskd = {
        #   certificate = "/path/to/cert";
        #   key = "/path/to/key";
        #   ca = "/path/to/ca";
        #   server = "host.domain:53589";
        #   credentials = "Org/First Last/cf31f287-ee9e-43a8-843e-e8bbd5de4294";
        # };
      };
    };
  };
}
