# System Performance Analysis and Issues Log

## System Overview

- **CPU**: AMD PRO A8-8650B R7 (4 cores, 4 threads)
- **GPU**: AMD Radeon R7 Graphics (KAVERI / GCN-era iGPU)
- **Memory**: 18 GB DDR3 installed (4 GB + 2 GB + 4 GB + 8 GB), configured at **1333 MT/s** on all sticks
- **OS / Kernel**: NixOS, Linux `6.18.0-zen1`

## Identified Issues

### 1. GPU Performance Issues

- **Issue**: Suboptimal Hashcat performance (`12111 H/s` vs expected ~`24000 H/s`)
- **Potential Causes**:
  - Using Mesa **Rusticl** OpenCL runtime (hashcat device `#04`) instead of a vendor OpenCL stack (Windows driver likely differs)
  - Memory bandwidth limitations (DDR3 running at 1333 MT/s + asymmetric channel population)
  - GPU power/perf profile not pinned to a high-performance state during compute loads

### 2. Memory Configuration

- **Issue**: Mixed DDR3 modules and asymmetric channels (from `logs/dmidecode.txt`):
  - ChannelA: 4 GB (1333) + 8 GB (1600) → runs at 1333
  - ChannelB: 4 GB (1333) + 2 GB (1600) → runs at 1333
- **Impact**:
  - All RAM runs at the slowest configured speed (**1333 MT/s**).
  - Uneven channel sizes can reduce effective bandwidth (especially painful for an iGPU doing OpenCL).

### 3. Kernel Command Line Parameters

- **Observation**: Many performance-related parameters are set (see `logs/dmesg.log.txt`).
- **Potential Issues / Notes**:
  - Kernel reports unknown params: `split_lock_mitigate=off`, `rtl8xxxu_disable_hw_crypto=1`, `biosdevname=0` (passed to user space, not handled by kernel).
  - `preempt=full` is latency-oriented; may slightly reduce pure throughput on some workloads.

### 4. OpenCL Configuration

- **Multiple OpenCL Platforms Detected** (from `logs/hashcat_backend.log.txt` / `hashcat -I`):
  1. **clvk** (Vulkan-based OpenCL)
  2. **Clover** (Mesa OpenCL 1.1) — hashcat flags as unstable and skips by default
  3. **rusticl** (Mesa OpenCL 3.0) — used by your hashcat run (`Device #04`)
  4. **PoCL** (CPU OpenCL)
- **Impact**:
  - Hashcat selected **rusticl** and reported `Speed.#04: 12111 H/s` (see `logs/hashcat.log.txt`).
  - Clover is skipped unless `--force` is used (hashcat warns about possible false negatives).

## Recommended Actions

### 1. GPU Optimization

- For this older KAVERI iGPU, modern ROCm OpenCL typically isn’t an option; focus on Mesa + correct power/memory setup.
- Verify the GPU actually boosts under compute load:
  - Check: `/sys/class/drm/card1/device/power_dpm_force_performance_level`
  - Check: `/sys/class/drm/card1/device/pp_power_profile_mode`
- If clocks/power profile don’t ramp up, consider a udev rule to force a compute/high profile (your `modules/power/performance.nix` already has a commented example).

### 2. Memory Configuration

- Biggest likely win for iGPU compute:
  - Use **matched** DIMMs (same capacity + speed).
  - Populate channels evenly (e.g., 2×8 GB at 1600 MT/s instead of 8+4 vs 4+2).
  - In BIOS/UEFI, ensure memory is running at the highest stable supported speed (XMP/DOCP if available).

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

### 4. OpenCL Benchmarking (Generic)

To compare OpenCL stacks/devices without tying benchmarks to any particular password/audit workflow:

```bash
clinfo
clpeak
```

## Next Steps

1. Benchmark OpenCL with `clpeak` and capture results per platform/device.
2. Verify GPU clocks/power profile during sustained GPU load (to rule out being stuck in a low DPM state).
3. If you want real gains, fix RAM population/speed for dual-channel bandwidth.
4. Re-check logs after changes (focus on amdgpu errors, ring timeouts, resets).

## Additional Notes

- ACPI
- iGPU VRAM is reported as **1024 MB** reserved at boot (see `logs/dmesg.log.txt`), so available system RAM will be reduced accordingly.
- `lact` is active and applies a GPU configuration at login; if benchmarking, consider temporarily disabling it to eliminate it as a variable.
