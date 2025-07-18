{ inputs, pkgs, ... }:

let
  catppuccin = pkgs.catppuccin-gtk.override {
    accents = [ "mauve" ];
    variant = "macchiato";
  };
in
{
  console = {
    font = "Lat2-Terminus16";
    useXkbConfig = true;
  };

  fonts.packages = with pkgs; [
    jetbrains-mono
    noto-fonts-color-emoji
    lora
    noto-fonts
    nerd-fonts.jetbrains-mono
  ];

  # lots to do here, compare to https://github.com/XNM1/linux-nixos-hyprland-config-dotfiles/blob/main/nixos/theme.nix
  environment.systemPackages = with pkgs; [
    papirus-nord
    nordzy-icon-theme
    nordzy-cursor-theme
    nordic
    inputs.mcmojave-hyprcursor.packages.${pkgs.stdenv.hostPlatform.system}.default
    glib
    gsettings-desktop-schemas
    nwg-look # we do all the configuration in here
    kitty-themes
    wallust
    gruvbox-material-gtk-theme
    capitaine-cursors-themed
    gruvbox-plus-icons
    lutgen
    base16-schemes
  ];
}
