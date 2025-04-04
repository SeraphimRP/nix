{ pkgs, ... }:

{
    programs.steam = {
        enable = true;
        remotePlay.openFirewall = true;
        gamescopeSession.enable = true;
    };

    environment.systemPackages = with pkgs; [
        protonup-qt
        lutris
        wine
        mangohud
        protontricks
        gamemode
        obs-studio
        obs-studio-plugins.wlrobs
        obs-studio-plugins.obs-vaapi
        obs-studio-plugins.obs-webkitgtk
        obs-studio-plugins.obs-gstreamer
        obs-studio-plugins.obs-text-pthread
        obs-studio-plugins.obs-pipewire-audio-capture
    ];
}
