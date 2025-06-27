{ settings, config, pkgs, ... }: {
  #* OpenGL (Open Graphics Library) is a cross-platform,
  #* open standard API for rendering 2D and 3D vector graphics.
  #* It allows developers to communicate with the GPU to create visually rich applications such as:
  # => Games
  # => CAD software
  # => Desktop environments and compositors (like Hyprland or GNOME)

  #* Key Points:
  # => Written in C; has bindings in many languages (C++, Python, Rust, etc.)
  # => Managed by the Khronos Group
  # => Often used with GLSL (OpenGL Shading Language) for writing shaders
  # => Alternative APIs: Vulkan, DirectX, Metal

  environment.systemPackages = with pkgs; [ freeglut glew glfw libGL libGLU ];
}
