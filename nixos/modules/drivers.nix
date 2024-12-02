{ pkgs, ... }:
{
  environment.systemPackages = with pkgs; [
    amdvlk # AMD Open Source Driver For Vulkan
    clinfo # Print all known information about all available OpenCL platforms and devices in the system
    driversi686Linux.amdvlk
    driversi686Linux.amdvlk # AMD Open Source Driver For Vulkan
    driversi686Linux.mesa # An open source 3D graphics library
    driversi686Linux.mesa # Open source 3D graphics library
    dxvk # A Vulkan-based translation layer for Direct3D
    glaxnimate # Simple vector animation program.
    glmark2 # OpenGL (ES) 2.0 benchmark
    gpu-viewer # A front-end to glxinfo, vulkaninfo, clinfo and es2_info
    hwdata # Hardware Database, including Monitors, pci.ids, usb.ids, and video cards
    khronos-ocl-icd-loader # Official Khronos OpenCL ICD Loader
    libdrm # Direct Rendering Manager library and headers
    libplacebo # Reusable library for GPU-accelerated video/image rendering primitives
    libva # An implementation for VA-API (Video Acceleration API)
    libva-utils # A collection of utilities and examples for VA-API
    mesa # An open source 3D graphics library
    mesa-demos # Collection of demos and test programs for OpenGL and Mesa
    ocl-icd # OpenCL ICD Loader for opencl-headers-2023.12.14
    openal # OpenAL alternative
    opencl-clang # A clang wrapper library with an OpenCL-oriented API and the ability to compile OpenCL C kernels to SPIR-V modules
    opencl-clhpp # OpenCL Host API C++ bindings
    opencl-headers # Khronos OpenCL headers version 2023.12.14
    vkbasalt # Vulkan post processing layer for Linux
    vkd3d # Direct3D to Vulkan translation library
    vkquake # Vulkan Quake port based on QuakeSpasm
    vulkan-extension-layer # Layers providing Vulkan features when native support is unavailable
    vulkan-headers # Vulkan Header files and API registry
    vulkan-tools # Khronos official Vulkan Tools and Utilities
    vulkan-utility-libraries # Set of utility libraries for Vulkan

  ];
}
