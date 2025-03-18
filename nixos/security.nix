{ pkgs, lib, ... }:

{
    programs.mtr.enable = true;
    programs.gnupg.agent = {
        enable = true;
        enableSSHSupport = true;
    };

    users.users.root.hashedPassword = "!";
    
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
  
    security.pam.services.hyprlock = {};
    # security.polkit.enable = true;
    programs.bitwarden.enable = true;
    
    services.clamav = {
        daemon.enable = true;
        fangfrisch = { enable = true; interval = "daily"; };
        updater = { enable = true; interval = "daily"; frequency = 12; };
    };

    programs.firejail = {
        enable = true;
        wrappedBinaries = { 
            mpv = {
                executable = "${lib.getBin pkgs.mpv}/bin/mpv";
                profile = "${pkgs.firejail}/etc/firejail/mpv.profile";
            };
            imv = {
                executable = "${lib.getBin pkgs.imv}/bin/imv";
                profile = "${pkgs.firejail}/etc/firejail/imv.profile";
            };
            zathura = {
                executable = "${lib.getBin pkgs.zathura}/bin/zathura";
                profile = "${pkgs.firejail}/etc/firejail/zathura.profile";
            };
            discord = {
                executable = "${lib.getBin pkgs.discord}/bin/discord";
                profile = "${pkgs.firejail}/etc/firejail/discord.profile";
            };
            telegram-desktop = {
                executable = "${lib.getBin pkgs.tdesktop}/bin/telegram-desktop";
                profile = "${pkgs.firejail}/etc/firejail/telegram-desktop.profile";
            };
            brave = {
                executable = "${lib.getBin pkgs.brave}/bin/brave";
                profile = "${pkgs.firejail}/etc/firejail/brave.profile";
            };
            vscode = {
                executable = "${lib.getBin pkgs.vscode}/bin/code";
                profile = "${pkgs.firejail}/etc/firejail/vscode.profile";
            };
        };
    };

    environment.systemPackages = with pkgs; [
        vulnix       # scan command: vulnix --system
        clamav       # scan command: sudo freshclam; clamscan [options] [file/directory/-]
        chkrootkit   # scan command: sudo chkrootkit
    ];
}
