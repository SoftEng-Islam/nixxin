{ pkgs, ... }: {
  environment.systemPackages = with pkgs; [
    hashcat # Fast password cracker
    hashcat-utils # Small utilities that are useful in advanced password cracking
    john # John the Ripper password cracker
    johnny # Open Source GUI frontend for John the Ripper
    aircrack-ng # WiFi security auditing tools suite

    wireshark
    airgorah # WiFi security auditing software mainly based on aircrack-ng tools suite
    xterm
    macchanger

    hcxdumptool # Small tool to capture packets from wlan devices
    hcxtools # Tools for capturing wlan traffic and conversion to hashcat and John the Ripper formats
    netcat # Free TLS/SSL implementation
    netop # Network monitor using bpf
    netrw # Simple tool for transporting data over the network
    nettools # Set of tools for controlling the network subsystem in Linux
  ];
}
