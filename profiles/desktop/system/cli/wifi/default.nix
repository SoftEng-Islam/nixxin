{ pkgs, ... }: {
  environment.systemPackages = with pkgs; [
    linuxPackages.rtl8188eus-aircrack # RealTek RTL8188eus WiFi driver with monitor mode & frame injection support

    hashcat # Fast password cracker
    hashcat-utils # Small utilities that are useful in advanced password cracking
    john # John the Ripper password cracker
    johnny # Open Source GUI frontend for John the Ripper

    aircrack-ng # WiFi security auditing tools suite
    hcxdumptool # Small tool to capture packets from wlan devices
    hcxtools # Tools for capturing wlan traffic and conversion to hashcat and John the Ripper formats
    netcat # Free TLS/SSL implementation
    netop # Network monitor using bpf
    netrw # Simple tool for transporting data over the network
    nettools # Set of tools for controlling the network subsystem in Linux
  ];
}
