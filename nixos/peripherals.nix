{ pkgs, lib, ... }:

{
  services.xserver = {
    xkb.layout = "us";
  };

  #services.ratbagd.enable = true;
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
  services.udev.extraRules = ''
    ACTION=="add", SUBSYSTEM=="usb", ENV{ID_VENDOR_ID}=="0846",	ENV{ID_MODEL_ID}=="9072",	RUN+="/run/current-system/sw/bin/modprobe mt7925u", RUN+="/bin/sh -c 'echo 0846 9072 > /sys/bus/usb/drivers/mt7925u/new_id'"
  '';

  environment.systemPackages = with pkgs; [
    #piper
    openrgb-with-all-plugins
    i2c-tools
    #solaar
    udiskie
    android-tools
    cameractrls-gtk4
    qmk
    qmk-udev-rules
  ];
}
