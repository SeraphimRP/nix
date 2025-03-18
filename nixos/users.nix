imports = [ <home-manager/nixos> ];

{ pkgs, ... }:

{
    users.users.srp = {
        isNormalUser = true;
        description = "Seraphim R. Pardee";
        extraGroups = [ "input" "wheel" "video" "audio" "tss" ];
    };

    home-manager.useGlobalPkgs = true;

    services.logind.extraConfig = "RuntimeDirectorySize=8G";
}
