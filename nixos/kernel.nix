{ pkgs, ... }:

{
    boot.kernelPackages = pkgs.linuxKernel.packages.linux_zen;
    boot.kernelParams = [
        "splash"
        "quiet"
        "fbcon=nodefer"
        "vt.global_cursor_default=0"
        "kernel.modules_disabled=1"
        "lsm=landlock,lockdown,yama,integrity,apparmor,bpf,tomoyo,selinux"
        "video4linux"
        "acpi_rev_override=5"
        "security=selinux"
    ];

    systemd.package = pkgs.systemd.override { withSeLinux = true; };

    environment.systemPackages = with pkgs; [
        policycoreutils
    ];
}
