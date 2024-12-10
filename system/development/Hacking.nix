{ pkgs, ... }: {
  environment.systemPackages = with pkgs; [
    aircrack-ng # WiFi security auditing tools suite
    hashcat # Fast password cracker
    hashcat-utils # Small utilities that are useful in advanced password cracking
    hcxtools # Tools for capturing wlan traffic and conversion to hashcat and John the Ripper formats
    john # John the Ripper password cracker
    johnny # Open Source GUI frontend for John the Ripper
  ];
}
