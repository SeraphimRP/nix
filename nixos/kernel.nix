{ pkgs, ... }:

{
  #boot.kernelPackages = pkgs.linuxPackages_latest;
  boot.kernelPackages = pkgs.linuxPackagesFor (
    pkgs.linuxPackages_latest.kernel.override {
      src = pkgs.fetchLocal {
        path = "/linux.tar.xz";
        sha256 = "";
      };
    }
  );

  boot.kernelParams = [
    "splash"
    "quiet"
    "fbcon=nodefer"
    "vt.global_cursor_default=0"
    "lsm=apparmor,tomoyo,selinux"
    "video4linux"
    "acpi_rev_override=5"
  ];

  systemd.package = pkgs.systemd.override { withSelinux = true; };

  environment.systemPackages = with pkgs; [
    policycoreutils
  ];
}
