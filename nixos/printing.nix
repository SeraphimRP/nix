{ pkgs, ... }:

{
  services.printing.enable = true;
  services.printing.drivers = [ pkgs.brlaser ];
  services.printing.logLevel = "debug";
  services.avahi = {
    enable = true;
    nssmdns4 = true;
    openFirewall = true;
    publish = {
      enable = true;
      userServices = true;
    };
  };
}
