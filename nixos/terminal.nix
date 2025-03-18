{ pkgs, ... }:

{
    services.envfs.enable = true;

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
