{ inputs, pkgs, ... }:

{
  programs.zsh.enable = true;

  users.users.srp = {
    isNormalUser = true;
    shell = pkgs.zsh;
    description = "Seraphim R. Pardee";
    extraGroups = [
      "input"
      "wheel"
      "video"
      "audio"
      "tss"
      "kvm"
      "disk"
    ];
  };

  services.logind.settings.Login = {
    RuntimeDirectorySize = "8G";
  };
}
