{ pkgs, ... }:

{
    services.xserver = {
        xkb.layout = "us";
    };

    environment.systemPackages = with pkgs; [
        piper
        openrgb-with-all-plugins
    ];
}
