{ pkgs, ... }:

{
  boot.kernelPackages = pkgs.linuxPackages_latest;
  # boot.kernelPackages =
  #   let
  #     linux_mtp_pkg =
  #       { fetchurl, buildLinux, ... }@args:
  #       buildLinux (
  #         args
  #         // rec {
  #           version = "6.16.3-mtp";
  #           modDirVersion = "6.16.3";
  #           src = fetchurl {
  #             url = "https://dump.hl.srp.life/linux.tar.gz";
  #             hash = "sha256-qt2T0ISH6BFET79eb2pBJHdMvwmtpBsquwT3L+tPClA=";
  #           };
  #           kernelPatches = [ ];

  #           extraMeta.branch = "6.16";
  #         }
  #         // (args.argsOverride or { })
  #       );
  #     linux_mtp = pkgs.callPackage linux_mtp_pkg { };
  #   in
  #   pkgs.recurseIntoAttrs (pkgs.linuxPackagesFor linux_mtp);
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
