{ pkgs, lib, ... }:

{
  programs.mtr.enable = true;
  services.gnome.gnome-keyring.enable = true;
  security.pam.services.greetd.enableGnomeKeyring = true;
  security.pam.services.tuigreet.enableGnomeKeyring = true;
  programs.seahorse.enable = true;

  users.users.root.hashedPassword = "!";

  programs.gnupg.agent = {
    enable = true;
    pinentryPackage = pkgs.pinentry-gnome3;
    enableSSHSupport = true;
  };

  security.tpm2 = {
    enable = true;
    pkcs11.enable = true;
    tctiEnvironment.enable = true;
  };

  security.apparmor = {
    enable = true;
    packages = with pkgs; [
      apparmor-utils
      apparmor-profiles
    ];
  };

  security.pam.services.hyprlock = { };
  security.polkit = {
    enable = true;
    extraConfig = ''
      polkit.addRule(function(action, subject) {
        var YES = polkit.Result.YES;
        var permission = {
          // required for udisks1:
          "org.freedesktop.udisks.filesystem-mount": polkit.Result.YES,
          "org.freedesktop.udisks.luks-unlock": YES,
          "org.freedesktop.udisks.drive-eject": YES,
          "org.freedesktop.udisks.drive-detach": YES,
          // required for udisks2:
          "org.freedesktop.udisks2.filesystem-mount": YES,
          "org.freedesktop.udisks2.filesystem-mount-system": YES,
          "org.freedesktop.udisks2.encrypted-unlock": YES,
          "org.freedesktop.udisks2.eject-media": YES,
          "org.freedesktop.udisks2.power-off-drive": YES,
          // required for udisks2 if using udiskie from another seat (e.g. systemd):
          "org.freedesktop.udisks2.filesystem-mount-other-seat": YES,
          "org.freedesktop.udisks2.filesystem-unmount-others": YES,
          "org.freedesktop.udisks2.encrypted-unlock-other-seat": YES,
          "org.freedesktop.udisks2.encrypted-unlock-system": YES,
          "org.freedesktop.udisks2.eject-media-other-seat": YES,
          "org.freedesktop.udisks2.power-off-drive-other-seat": YES
        };
        if (subject.isInGroup("wheel")) {
          return permission[action.id];
        }
      });
    '';
  };

  services.clamav = {
    daemon.enable = true;
    fangfrisch = {
      enable = true;
      interval = "daily";
    };
    updater = {
      enable = true;
      interval = "daily";
      frequency = 12;
    };
  };

  # programs.firejail = {
  #   enable = true;
  #   wrappedBinaries = {
  #     mpv = {
  #       executable = "${lib.getBin pkgs.mpv}/bin/mpv";
  #       profile = "${pkgs.firejail}/etc/firejail/mpv.profile";
  #     };
  #     imv = {
  #       executable = "${lib.getBin pkgs.imv}/bin/imv";
  #       profile = "${pkgs.firejail}/etc/firejail/imv.profile";
  #     };
  #     zathura = {
  #       executable = "${lib.getBin pkgs.zathura}/bin/zathura";
  #       profile = "${pkgs.firejail}/etc/firejail/zathura.profile";
  #     };
  #     #discord = {
  #     #    executable = "${lib.getBin pkgs.discord}/bin/discord";
  #     #    profile = "${pkgs.firejail}/etc/firejail/discord.profile";
  #     #};
  #     #telegram-desktop = {
  #     #    executable = "${lib.getBin pkgs.tdesktop}/bin/telegram-desktop";
  #     #    profile = "${pkgs.firejail}/etc/firejail/telegram-desktop.profile";
  #     #};
  #     #brave = {
  #     #    executable = "${lib.getBin pkgs.brave}/bin/brave";
  #     #    profile = "${pkgs.firejail}/etc/firejail/brave.profile";
  #     #};
  #   };
  # };

  environment.systemPackages = with pkgs; [
    vulnix # scan command: vulnix --system
    clamav # scan command: sudo freshclam; clamscan [options] [file/directory/-]
    bitwarden-desktop
    gnupg1compat
  ];
}
