{ pkgs, lib, ... }:

{
  services.xserver = {
    xkb.layout = "us";
  };

  services.ratbagd.enable = true;
  boot.kernelModules = [
    "i2c-dev"
    "i2c-piix4"
  ];
  hardware.i2c.enable = true;

  services.hardware.openrgb = {
    enable = true;
    motherboard = "amd";
  };

  services.udisks2.enable = true;

  environment.systemPackages = with pkgs; [
    piper
    openrgb-with-all-plugins
    i2c-tools
    solaar
    udiskie
    android-tools
    cameractrls-gtk4
  ];
}
