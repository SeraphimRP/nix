{ pkgs, winapps, ... }:

{
  virtualisation.podman = {
    enable = true;

    dockerCompat = true;
    dockerSocket.enable = true;

    defaultNetwork.settings.dns_enabled = true;
  };

  environment.variables.DBX_CONTAINER_MANAGER = "podman";
  users.extraGroups.podman.members = [ "srp" ];

  environment.systemPackages = with pkgs; [
    distrobox
    qemu

    podman-compose
    podman-tui

    docker-compose
    winapps.packages.x86_64-linux.winapps
    winapps.packages.x86_64-linux.winapps-launcher
  ];
}
