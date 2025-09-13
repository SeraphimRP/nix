{ pkgs, ... }:

{
  programs.steam = {
    package = pkgs.steam-millennium.override {
      extraEnv = {
        MANGOHUD = true;
        TZ = "America/Detroit";
      };
    };

    enable = true;
    remotePlay.openFirewall = true;
    gamescopeSession.enable = true;

    protontricks.enable = true;
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
    obs-studio-plugins.obs-gstreamer
    obs-studio-plugins.obs-text-pthread
    obs-studio-plugins.obs-pipewire-audio-capture
    vpkedit
    bottles
    prismlauncher
  ];
}
