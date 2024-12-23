{ pkgs, ... }: {
  environment.systemPackages = with pkgs; [
    # hashcat # Fast password cracker
    # hashcat-utils # Small utilities that are useful in advanced password cracking
    aircrack-ng # WiFi security auditing tools suite
    hcxdumptool # Small tool to capture packets from wlan devices
    hcxtools # Tools for capturing wlan traffic and conversion to hashcat and John the Ripper formats
    john # John the Ripper password cracker
    johnny # Open Source GUI frontend for John the Ripper
    netcat
    netop
    netrw
    nettools
  ];
}
