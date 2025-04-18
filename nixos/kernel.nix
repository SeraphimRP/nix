{ pkgs, ... }:

{
  boot.kernelPackages = pkgs.linuxKernel.packages.linux_zen;
  boot.kernelParams = [
    "splash"
    "quiet"
    "fbcon=nodefer"
    "vt.global_cursor_default=0"
    "lsm=apparmor,tomoyo,selinux"
    "video4linux"
    "acpi_rev_override=5"
    "security=selinux"
  ];

  systemd.package = pkgs.systemd.override { withSelinux = true; };

  environment.systemPackages = with pkgs; [
    policycoreutils
  ];
}
