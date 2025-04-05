{
  pkgs,
  lib,
  lanzaboote,
  ...
}:

{
  imports = [ lanzaboote.nixosModules.lanzaboote ];

  # boot.loader.grub = {
  #     device = "nodev";
  #     efiSupport = true;
  #     useOSProber = true;
  # };
  boot.loader.systemd-boot.enable = lib.mkForce false;

  boot.lanzaboote = {
    enable = true;
    pkiBundle = "/var/lib/sbctl";
  };

  boot.loader.efi.canTouchEfiVariables = true;
  boot.loader.timeout = 2;
  boot.initrd.enable = true;
  boot.initrd.systemd.enable = true;

  environment.systemPackages = with pkgs; [
    sbctl
  ];
}
