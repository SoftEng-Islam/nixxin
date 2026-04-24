{
  config,
  pkgs,
  lib,
  ...
}: {
  programs.gpg = {
    enable = true;

    package = pkgs.gnupg;

    homedir = "${config.home.homeDirectory}/.gnupg";

    mutableKeys = true;
    mutableTrust = true;

    settings = {
      personal-cipher-preferences = "AES256 AES192 AES";
      personal-digest-preferences = "SHA512 SHA384 SHA256";
      personal-compress-preferences = "ZLIB BZIP2 ZIP Uncompressed";
      default-preference-list = "SHA512 SHA384 SHA256 AES256 AES192 AES ZLIB BZIP2 ZIP Uncompressed";

      cert-digest-algo = "SHA512";

      s2k-digest-algo = "SHA512";
      s2k-cipher-algo = "AES256";

      charset = "utf-8";

      fixed-list-mode = true;

      no-comments = true;
      no-emit-version = true;
      no-symkey-cache = true;

      keyid-format = "0xlong";

      list-options = "show-uid-validity";
      verify-options = "show-uid-validity";

      with-fingerprint = true;
      require-cross-certification = true;

      use-agent = true;
    };

    scdaemonSettings = {
      disable-ccid = true;
    };

    publicKeys = [
    ];
  };

  services.gpg-agent = {
    enable = true;
    enableZshIntegration = true;
    enableFishIntegration = true;
    pinentry.package = pkgs.pinentry-curses;
    grabKeyboardAndMouse = true;
  };

  home.packages = with pkgs; [
    gpg-tui
    pinentry-curses
    paperkey
  ];
}
