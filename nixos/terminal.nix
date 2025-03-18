{ pkgs, ... }:

{
    environment.systemPackages = with pkgs; [
        kitty
        starship
        neofetch
        htop
        wlr-randr
        gpu-viewer
        dig
        speedtest-rs
        file
        git
        curl
        ripgrep
        eza
        neovim
        fd
        jq
        fzf
        bat
        pandoc
        lsof
        cmatrix
        pipes-rs
        rsclock
        cava
        figlet
        nnn
    ];
}
