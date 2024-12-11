{ pkgs, ... }: {
  environment.systemPackages = with pkgs;
    [
      #__ ASUS ROG Laptops __#
      # asusctl # A control daemon, CLI tools, and a collection of crates for interacting with ASUS ROG laptops
      # supergfxctl # A GPU switching utility, mostly for ASUS laptops
    ];
}
