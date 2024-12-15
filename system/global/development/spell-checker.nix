{ pkgs, ... }: {
  environment.systemPackages = with pkgs; [
    aspell
    aspellDicts.de
    aspellDicts.fr
    aspellDicts.en
    hunspell
    hunspellDicts.en-gb-ise
  ];
}
