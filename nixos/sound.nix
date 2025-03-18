{ pkgs, ... }:

{
    services.pulseaudio.enable = false;
    security.rtkit.enable = true; # realtime audio support
    services.pipewire = {
        enable = true;
        alsa = { enable = true; support32Bit = true; };
        pulse.enable = true;
        wireplumber.enable = true;
    };

    environment.systemPackages = with pkgs; [
        pamixer
        pavucontrol
    ];
}
