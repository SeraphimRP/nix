{ ... }:

{
    boot.loader.grub = {
        device = "nodev";
        efiSupport = true;
        useOSProber = true;
    }

    boot.loader.efi.canTouchEfiVariables = true;
    boot.loader.timeout = 2;
    boot.initrd.enable = true;
    boot.initrd.systemd.enable = true;
}
