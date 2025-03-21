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
    ];
}
