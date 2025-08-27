{ pkgs, ... }:

{
  hardware.bluetooth = {
    enable = true;
    powerOnBoot = false;
  };

  networking.hostName = "nixos";
  networking.wireless = {
    enable = true;
    networks.Frodo = {
      authProtocols = [ "WPA-PSK" ];
      pskRaw = "ce51bdc23dcfe6d01bbd2ffbb0d80079c4ce7cfa6c4cd8059690a12d002a305e";
    };
  };

  networking.firewall = {
    enable = true;
    allowedTCPPorts = [ 3000 ];
  };

  # todo: custom dns

  environment.systemPackages = with pkgs; [
    overskride
  ];
}
