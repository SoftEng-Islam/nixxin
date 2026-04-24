{
  mgr.prepend_keymap = [
    {
      on = "p";
      run = "plugin augment-command -- paste";
      desc = "Smart paste yanked files";
    }
    {
      on = "t";
      run = "plugin augment-command -- tab_create --current";
      desc = "Create a new tab with smart directory";
    }
    {
      on = [
        "c"
        "a"
      ];
      run = "plugin compress";
      desc = "Compress file";
    }
    {
      on = [
        "c"
        "m"
      ];
      run = "plugin chmod";
      desc = "Change file permissions";
    }
    {
      on = [ "M" ];
      run = "plugin mount";
      desc = "Mount mgr";
    }
    {
      on = [ "T" ];
      run = "plugin toggle-pane max-preview";
      desc = "Maximize or restore preview";
    }
    {
      on = [
        "."
        "s"
      ];
      run = "plugin what-size --args='--clipboard'";
      desc = "Calc size of selection or cwd";
    }
    {
      on = "C-n";
      run = ''shell -- ripdrag -xna "$1"'';
      desc = "ripdrag";
    }
  ];
}
