{ inputs, pkgs, ... }:

{
  services.greetd = {
    enable = true;
    settings = {
      default_session = {
        command = "${pkgs.greetd.tuigreet}/bin/tuigreet --time --time-format '%I:%M %p | %a • %h | %F' --cmd Hyprland";
        user = "greeter";
      };
    };
  };

  #services.displayManager.sddm.enable = true;
  #services.displayManager.sddm.wayland.enable = true;
  #services.desktopManager.plasma6.enable = true;
  #services.displayManager.sddm.settings.General.DisplayServer = "wayland";
  #services.power-profiles-daemon.enable = false;

  programs.noisetorch.enable = true;

  programs.hyprland = {
    enable = true;
    withUWSM = true;
    xwayland.enable = true;
  };
  environment.sessionVariables = {
    NIXOS_OZONE_WL = "1";
    WLR_NO_HARDWARE_CURSORS = "1";
    AQ_NO_ATOMIC = "0";
  };

  programs.nh = {
    enable = true;
    clean.enable = true;
    clean.extraArgs = "--keep-since 4d --keep 3";
    flake = "/etc/nixos";
  };

  services.flatpak.enable = true;
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

    google-chrome
    brave
    thunderbird-latest
    zathura
    mpv
    imv
    plexamp
    plex-desktop
    vscode
    (discord-canary.override {
      withVencord = true;
      vencord = vencord;
    })
    equibop
    cinny-desktop
    telegram-desktop
    vscode.fhs
    grimblast
    unzip
    xfce.thunar
  ];
}
