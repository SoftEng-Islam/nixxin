{ settings, lib, pkgs, ... }:
lib.mkIf (settings.modules.media.codex) {
  # Video & Audio & Images | graphics & Formats
  environment.systemPackages = with pkgs; [
    mediainfo # Supplies technical and tag information about a video or audio file

    ffmpeg-full # A complete, cross-platform solution to record, convert and stream audio and video
    ffmpegthumbnailer # A lightweight video thumbnailer
    playerctl # Command-line utility and library for controlling media players that implement MPRIS
    aalib # ASCII art graphics library
    alsa-lib # ALSA, the Advanced Linux Sound Architecture libraries
    aribb25 # Sample implementation of the ARIB STD-B25 standard
    # flac # Library and tools for encoding and decoding the FLAC lossless audio file format
    jack2 # JACK audio connection kit, version 2 with jackdbus
    libass # Portable ASS/SSA subtitle renderer
    libavc1394 # Programming interface for the 1394 Trade Association AV/C (Audio/Video Control) Digital Interface Command Set
    libbluray # Library to access Blu-Ray disks for video playback
    # libcaca # A graphics library that outputs text instead of pixels
    libgcrypt # General-purpose cryptographic library
    libjpeg # A faster (using SIMD) libjpeg implementation
    libmodplug # MOD playing library
    # libmtp # An implementation of Microsoft's Media Transfer Protocol
    # libogg # Media container library to manipulate Ogg files
    # libopus # Open, royalty-free, highly versatile audio codec
    libpng # The official reference implementation for the PNG file format with animation patch
    libvpx # WebM VP8/VP9 codec SDK
    ncurses # Free software emulation of curses in SVR4 and more
    openh264 # A codec library which supports H.264 encoding and decoding
    SDL_image # SDL image library
    smpeg # MPEG decoding library
    srt # Secure, Reliable, Transport
    libde265 # Open h.265 video codec implementation
    ab-av1 # AV1 re-encoding using ffmpeg, svt-av1 & vmaf
    dav1d # A cross-platform AV1 decoder focused on speed and correctness
    libaom # Alliance for Open Media AV1 codec library
    rav1e # The fastest and safest AV1 encoder
    svt-av1 # AV1-compliant encoder/decoder library core
    v4l-utils
    x264 # Library for encoding H264/AVC video streams
    x265 # Library for encoding H.265/HEVC video streams
    xvidcore # MPEG-4 video codec for PC

    ffmpeg-headless # video editing

    # Images
    graphicsmagick # GraphicsMagick is the swiss army knife of image processing
    imagemagick # Software suite to create, edit, compose, or convert bitmap images

  ];
}
