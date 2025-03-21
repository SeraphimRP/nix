{ inputs, pkgs, ... }:

{
    services.greetd = {
        enable = true;
        settings = {
            default_session = {
                command = "${pkgs.greetd.tuigreet}/bin/tuigreet --time --time-format '%I:%M %p | %a • %h | %F' --cmd 'eval $(/run/wrappers/bin/gnome-keyring-daemon --start --daemonize); export SSH_AUTH_SOCK; Hyprland'";
                user = "greeter";
            };
        };
    };

    programs.hyprland = {
        enable = true;
        withUWSM = true;
        xwayland.enable = true;
    };
    environment.sessionVariables = {
        NIXOS_OZONE_WL = "1";
        WLR_NO_HARDWARE_CURSORS = "1";
        AQ_NO_ATOMIC="0";
    };

    environment.systemPackages = with pkgs; [
        greetd.tuigreet

        pyprland
        hyprpicker
        hyprcursor
        hyprlock
        hypridle
        hyprpaper
        hyprpolkitagent
        mpvpaper
        waybar-mpris

        xdg-desktop-portal-gtk
        
        brave
        zathura
        mpv
        imv
        plexamp
        vscode
        equibop
	    cinny-desktop
        telegram-desktop 
    ];
}
