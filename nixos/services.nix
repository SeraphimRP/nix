{ pkgs, lib, ... }:

{
  systemd.packages = with pkgs; [
    auto-cpufreq
  ];

  programs.dconf.enable = true;

  services.dbus = {
    enable = true;
    implementation = "broker";
  };

  services.fwupd.enable = true;
  services.fwupd.daemonSettings.espLocation = lib.mkForce "/boot";
  services.auto-cpufreq.enable = true;

  environment.systemPackages = with pkgs; [
    at-spi2-atk
    qt6.qtwayland
    psi-notify
    playerctl
    psmisc
    ffmpeg_6-full
    wl-screenrec
    wl-clipboard
    wl-clip-persist
    xdg-utils
    wtype
    wlrctl
    waybar
    wlogout
  ];
}
