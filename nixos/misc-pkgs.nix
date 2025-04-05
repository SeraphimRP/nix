{ pkgs, ... }:

{
  programs.coolercontrol.enable = true;

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
