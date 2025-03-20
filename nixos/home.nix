{ config, inputs, pkgs, nix-colors, nixvim, ... }:

{
    imports = [ nix-colors.homeManagerModules.default nixvim.homeManagerModules.nixvim ];

    colorScheme = nix-colors.colorSchemes.nord;

    # Home Manager needs a bit of information about you and the
    # paths it should manage.
    home.username = "srp";
    home.homeDirectory = "/home/srp";

    programs.zsh = {
        enable = true;
        enableCompletion = true;
        syntaxHighlighting.enable = true;
        initExtra = ''
            eval "$(starship init zsh)"
        '';

        shellAliases = {
            vim = "nvim";
            grep = "rg";
            cat = "bat";
            ls = "eza";
        };
    };

    # note: nixvim needs to be enabled in the NixOS
    # configs *before* it can be enabled here
    programs.nixvim = {
        enable = true;

        plugins.lualine.enable = true;
        colorschemes.nord.enable = true;
    };

    programs.git = {
        enable = true;
        userEmail = "me@srp.life";
        userName = "Seraphim R. Pardee";
        extraConfig = { credential.helper = "store"; };
    };

    home.sessionVariables = {
        EDITOR="nvim";
        XDG_CACHE_HOME="$HOME/.cache";
        XDG_CONFIG_HOME="$HOME/.config";
        XDG_DATA_HOME="$HOME/.local/share";
        XDG_BIN_HOME="$HOME/.local/bin";
        XDG_MUSIC_DIR="$HOME/music";
        XDG_DESKTOP_DIR="$HOME";
        XDG_DOCUMENTS_DIR="$HOME/doc";
        XDG_DOWNLOAD_DIR="$HOME/dl";
        XDG_PICTURES_DIR="$HOME/img";
        XDG_PUBLICSHARE_DIR="$HOME/pub";
        XDG_TEMPLATES_DIR="$HOME/tmpl";
        XDG_VIDEOS_DIR="$HOME/vid";
    };

    programs.kitty = with pkgs; {
        enable = true;
        font.name = "JetBrains Mono";
        themeFile = "Nord";
    };

    programs.starship.enable = true;

    services.udiskie = {
        enable = true;
        automount = true;
        notify = true;
        settings.device_config = [
            {
                id_uuid = "EA3850B038507D8F";
                ignore = false;
                automount = true;
            }
            {
                id_uuid = "72CC3D9BCC3D5B15";
                ignore = false;
                automount = true;
            }
        ];
    };

    services.dunst = {
        enable = true;
        settings = {
            global = {
                frame_color = "#88C0D0";
                separator_color = "frame";
                font = "JetBrains Mono Regular 11";
                corner_radius = 5;
                offset = "(20, 5)";
                origin = "top-right";
                notification_limit = 4;
                gap_size = 7;
                frame_width = 2;
                width = "(0, 700)";
                height = "(0, 100)";
                monitor = 1;
            };

            urgency_low = {
                background = "#2E3440";
                foreground = "#ECEFF4";
                frame_color = "#81A1C1";
            };

            urgency_normal = {
                background = "#2E3440";
                foreground = "#ECEFF4";
                frame_color = "#88C0D0";
            };

            urgency_critical = {
                background = "#2E3440";
                foreground = "#ECEFF4";
                frame_color = "#BF616A";
            };
        };
    };

    wayland.windowManager.hyprland = {
        enable = true;
        package = inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.hyprland;
        portalPackage = inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.xdg-desktop-portal-hyprland;
        extraConfig = ''${builtins.readFile ./hyprland.conf}'';
        plugins = [
            inputs.hyprsplit.packages.${pkgs.system}.hyprsplit
        ];
    };

    # This value determines the Home Manager release that your
    # configuration is compatible with. This helps avoid breakage
    # when a new Home Manager release introduces backwards
    # incompatible changes.
    #
    # You can update Home Manager without changing this value. See
    # the Home Manager release notes for a list of state version
    # changes in each release.
    home.stateVersion = "24.11";

    # Let Home Manager install and manage itself.
    programs.home-manager.enable = true;
}
