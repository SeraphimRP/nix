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

        shellAliases = {
            vim = "nvim";
            grep = "rg";
            cat = "bat";
            ls = "eza";
        };
    };

    programs.nixvim = {
    	enable = true;
        plugins.lualine.enable = true;
        #colorschemes.nord.enable = true;
    };

    programs.git = {
        enable = true;
        userEmail = "me@srp.life";
        userName = "Seraphim R. Pardee";
        extraConfig = { credential.helper = "store"; };
    };

    programs.kitty.settings = {
        foreground = "#${config.colorScheme.palette.base05}";
        background = "#${config.colorScheme.palette.base00}";
    };

    wayland.windowManager.hyprland = {
        enable = true;
        package = inputs.hyprland.packages.${pkgs.stdenv.hostPlatform.system}.hyprland;
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
