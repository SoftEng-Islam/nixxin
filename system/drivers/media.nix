{ pkgs, ... }: {
  # Video & Audio & Images | graphics & Formats
  environment.systemPackages = with pkgs; [
    kdenlive # Video editor
    # davinci-resolve # Professional video editing, color, effects and audio post-processing
    # davinci-resolve-studio
    #__ Media __#
    libvdpau-va-gl # VDPAU driver with OpenGL/VAAPI backend
    # ffmpeg # A complete, cross-platform solution to record, convert and stream audio and video
    ffmpeg-full # A complete, cross-platform solution to record, convert and stream audio and video
    ffmpegthumbnailer # A lightweight video thumbnailer
    playerctl # Command-line utility and library for controlling media players that implement MPRIS
    aalib # ASCII art graphics library
    ab-av1 # AV1 re-encoding using ffmpeg, svt-av1 & vmaf
    alsa-lib # ALSA, the Advanced Linux Sound Architecture libraries
    aribb25 # Sample implementation of the ARIB STD-B25 standard
    avahi # mDNS/DNS-SD implementation
    dav1d # A cross-platform AV1 decoder focused on speed and correctness
    dejavu_fonts # A typeface family based on the Bitstream Vera fonts
    flac # Library and tools for encoding and decoding the FLAC lossless audio file format
    fluidsynth # Real-time software synthesizer based on the SoundFont 2 specifications
    jack2 # JACK audio connection kit, version 2 with jackdbus
    libaom # Alliance for Open Media AV1 codec library
    libass # Portable ASS/SSA subtitle renderer
    libavc1394 # Programming interface for the 1394 Trade Association AV/C (Audio/Video Control) Digital Interface Command Set
    libbluray # Library to access Blu-Ray disks for video playback
    libcaca # A graphics library that outputs text instead of pixels
    libgcrypt # General-purpose cryptographic library
    libjpeg # A faster (using SIMD) libjpeg implementation
    libkate # A library for encoding and decoding Kate streams
    libmicrodns # Minimal mDNS resolver library, used by VLC
    libmodplug # MOD playing library
    libmtp # An implementation of Microsoft's Media Transfer Protocol
    libnfs # NFS client library
    libogg # Media container library to manipulate Ogg files
    libopus # Open, royalty-free, highly versatile audio codec
    libpng # The official reference implementation for the PNG file format with animation patch
    libvpx # WebM VP8/VP9 codec SDK
    lirc # Allows to receive and send infrared signals
    ncurses # Free software emulation of curses in SVR4 and more
    openh264 # A codec library which supports H.264 encoding and decoding
    pcsclite # Middleware to access a smart card using SCard API (PC/SC)
    protobuf # Google's data interchange format
    rav1e # The fastest and safest AV1 encoder
    SDL_image # SDL image library
    smpeg # MPEG decoding library
    speex # An Open Source/Free Software patent-free audio compression format designed for speech
    speexdsp # An Open Source/Free Software patent-free audio compression format designed for speech
    srt # Secure, Reliable, Transport
    svt-av1 # AV1-compliant encoder/decoder library core
    twolame # A MP2 encoder
    udevil # Mount without password
    x264 # Library for encoding H264/AVC video streams
    x265 # Library for encoding H.265/HEVC video streams
    xvidcore # MPEG-4 video codec for PC
    imagemagick # Software suite to create, edit, compose, or convert bitmap images

    # GStreamer
    gst_all_1.gst-libav # FFmpeg/libav plugin for GStreamer
    gst_all_1.gst-plugins-bad # GStreamer Bad Plugins
    gst_all_1.gst-plugins-base # Base GStreamer plug-ins and helper libraries
    gst_all_1.gst-plugins-good # GStreamer Good Plugins
    gst_all_1.gst-plugins-rs # GStreamer plugins written in Rust
    gst_all_1.gst-plugins-ugly # Gstreamer Ugly Plugins
    gst_all_1.gstreamer # Open source multimedia framework
    gst_all_1.gst-vaapi # Set of VAAPI GStreamer Plug-ins

    # Media Players
    # jellyfin
    jellyfin-media-player
    playerctl
    mumble
    ferdium
    # mpv # General-purpose media player, fork of MPlayer and mplayer2
    (mpv.override { scripts = [ mpvScripts.mpris ]; })
    vlc # Cross-platform media player and streaming server
    clapper # A GNOME media player built using GTK4 toolkit and powered by GStreamer with OpenGL rendering
    glide-media-player # Linux/macOS media player based on GStreamer and GTK

    # Images
    graphicsmagick # GraphicsMagick is the swiss army knife of image processing
  ];
}
