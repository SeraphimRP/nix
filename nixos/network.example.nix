{ pkgs, ... }:

{
    hardware.bluetooth = {
        enable = true;
        powerOnBoot = false;
    };

    networking.hostName = "nixos";
    networking.wireless = {
        enable = true;
        networks.SSID_HERE = {
            authProtocols = [ "WPA-PSK" ];
            pskRaw = "PSK_HERE";
        };
    };

    networking.firewall.enable = true;

    # todo: custom dns

    environment.systemPackages = with pkgs; [
        overskride
    ];
}
