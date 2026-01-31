# System Performance Analysis and Issues Log

## System Overview

- **CPU**: AMD PRO A8-8650B R7 (4 cores, 4 threads)
- **GPU**: AMD Radeon R7 Graphics (Kaveri)
- **Memory**: 16GB (mixed RAM configuration detected)
- **OS**: NixOS with Linux 6.18.0-zen1 kernel

## Identified Issues

### 1. GPU Performance Issues

- **Issue**: Suboptimal Hashcat performance (12,111 H/s vs expected 24,000 H/s)
- **Potential Causes**:
  - AMDGPU driver configuration issues
  - Incorrect power management settings
  - Suboptimal OpenCL configuration
  - Memory bandwidth limitations

### 2. Memory Configuration

- **Issue**: Mixed RAM modules detected (4GB + 4GB + 4GB + 4GB with different speeds)
- **Impact**: This can lead to reduced memory performance as all RAM will run at the speed of the slowest module

### 3. Kernel Command Line Parameters

- **Observation**: Several performance-related parameters are set
- **Potential Issues**:
  - `intremap=off` - Disables interrupt remapping, may affect I/O performance
  - `mitigations=off` - Disables security mitigations (performance vs security trade-off)
  - `preempt=full` - May cause higher overhead on some workloads

### 4. OpenCL Configuration

- **Multiple OpenCL Platforms Detected**:
  1. clvk (Vulkan-based)
  2. Clover (Mesa)
  3. rusticl (Mesa)
  4. PoCL (CPU-based)
- **Potential Issue**: Multiple OpenCL implementations may cause conflicts or suboptimal device selection

## Recommended Actions

### 1. GPU Optimization

```nix
# In your hardware configuration
hardware.opengl = {
  enable = true;
  driSupport = true;
  driSupport32Bit = true;
  extraPackages = with pkgs; [
    amdvlk
    rocm-opencl-icd
    rocm-opencl-runtime
  ];
  extraPackages32 = with pkgs; [
    driversi686Linux.amdvlk
  ];
};

# Enable AMD ROCm
hardware.opengl.extraPackages = with pkgs; [
  rocm-opencl-icd
  rocm-opencl-runtime
];
```

### 2. Memory Configuration

- Consider using matched RAM modules for optimal performance
- Ensure RAM is installed in the correct slots for dual-channel operation

### 3. Kernel Parameters

Review and potentially modify kernel parameters in your configuration:

```nix
boot.kernelParams = [
  # Consider removing or adjusting these based on your needs
  # "intremap=off"
  # "mitigations=off"
  # "preempt=full"

  # GPU-specific optimizations
  "amdgpu.ppfeaturemask=0xffffffff"
  "amdgpu.dc=1"
  "amdgpu.dpm=1"
  "amdgpu.gpu_recovery=1"
];
```

### 4. Hashcat Optimization

For better Hashcat performance:

1. Use the correct OpenCL device:

   ```bash
   # List available OpenCL devices
   clinfo | grep "Device Name"

   # Run hashcat with specific device
   hashcat -d 3 -w 4 -m 22000 ...  # Use device #3 (AMD GPU)
   ```

2. Consider using ROCm instead of Mesa OpenCL for better performance:

   ```nix
   environment.systemPackages = with pkgs; [
     rocm-opencl-icd
     rocm-opencl-runtime
   ];
   ```

## Next Steps

1. Test Hashcat performance after applying GPU optimizations
2. Monitor system logs for any remaining issues
3. Consider running memory tests to ensure stability with mixed RAM
4. Benchmark different OpenCL implementations to find the best performer for your workload

## Additional Notes

- The system is running with `transparent_hugepage=always` which is good for performance
- Power management is set to performance-oriented settings
- Consider monitoring GPU temperatures and frequencies during workload to check for thermal throttling
