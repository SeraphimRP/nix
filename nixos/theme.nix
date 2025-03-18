{ pkgs, ... }:

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
}
