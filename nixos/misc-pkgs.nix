{ pkgs, ... }:

{
    environment.systemPackages = with pkgs; [
        cmake
        gcc
        ninja
        gnumake
        meson
        pkg-config
        cpio
    ];
}
