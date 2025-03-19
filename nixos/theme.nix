{ inputs, pkgs, ... }:

{
    console = {
        font = "Lat2-Terminus16";
        useXkbConfig = true;
    };

    fonts.packages = with pkgs; [
        jetbrains-mono
        nerd-font-patcher
        noto-fonts-color-emoji
    ];
    
    # lots to do here, compare to https://github.com/XNM1/linux-nixos-hyprland-config-dotfiles/blob/main/nixos/theme.nix
    environment.systemPackages = with pkgs; [
        nordic
        inputs.mcmojave-hyprcursor.packages.${pkgs.stdenv.hostPlatform.system}.default
        glib
        gsettings-desktop-schemas
        nwg-look
        kitty-themes
    ];
}
