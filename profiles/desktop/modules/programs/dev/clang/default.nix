{ pkgs, ... }: {
  programs.lang-c.enable = true;
  environment.systemPackages = with pkgs; [
    valgrind

    # build tools
    cmake
    gcc
    gnumake
    ninja
    pkg-config

    # generates .cache and compile_commands.json
    # files required by clangd
    bear

    # provides clangd (LSP)
    # provides libraries
    # NOTE: make sure mason.nvim don't install clangd
    clang-tools

    # required by codelldb (debugger)
    # lldb # libraries conflicts with clang-tools
    gdb

    # libs
    gpp # c++ module?, decrypt
    gecode # c++ module
  ];
}
