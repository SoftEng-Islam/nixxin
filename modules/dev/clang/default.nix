{ pkgs, ... }: {

  environment.variables = {
    # Use gcc for compilation
    # CC="${pkgs.gcc}/bin/gcc";
    # CXX="${pkgs.gcc}/bin/c++"";
    CC = "${pkgs.clang}/bin/clang";
    CXX = "${pkgs.clang}/bin/clang++";
  };
  environment.systemPackages = with pkgs; [
    valgrind # Valgrind is an award-winning instrumentation framework for building dynamic analysis tools.

    # build tools
    cmake
    cmake-format
    cmake-language-server
    cmakeCurses
    gcc14
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
