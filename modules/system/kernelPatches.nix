{
  settings,
  lib,
  pkgs,
  config,
  ...
}:
let
  inherit (lib.kernel) yes no;
  inherit (lib.attrsets) mapAttrs;
  inherit (lib.modules) mkForce;
  kernelName = config.boot.kernelPackages.kernel.pname or "";
  # CachyOS kernels already include AMD optimizations, LRU_GEN, and Rust support.
  # Applying these patches on top causes conflicts and forces a full recompilation.
  isCachyOS = lib.hasPrefix "linux-cachyos" kernelName;
in
lib.mkIf ((settings.modules.system.kernelPatches or false) && !isCachyOS) {
  boot.kernelPatches = [
    {
      # recompile with AMD platform specific optimizations
      name = "amd-platform-patches";
      patch = null; # no patch is needed, just apply the options
      extraStructuredConfig = mapAttrs (_: mkForce) {
        # enable compiler optimizations for AMD
        MNATIVE_AMD = yes;
        X86_USE_PPRO_CHECKSUM = yes;
        X86_AMD_PSTATE = yes;

        X86_EXTENDED_PLATFORM = no; # disable support for other x86 platforms
        X86_MCE_INTEL = no; # disable support for intel mce

        # multigen LRU
        LRU_GEN = yes;
        LRU_GEN_ENABLED = yes;

        # collect CPU frequency statistics
        CPU_FREQ_STAT = yes;

        # Optimized for performance
        # this is already set on the Xanmod kernel
        # CC_OPTIMIZE_FOR_PERFORMANCE_O3 = yes;
      };
    }
    {
      name = "Rust Support";
      patch = null;
      features = {
        rust = true;
      };
    }
  ];
}
