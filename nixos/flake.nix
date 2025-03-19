{
    description = "srpnix";

    inputs = {
        nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";

        hyprland.url = "github:hyprwm/Hyprland";
        hyprland-plugins = { url = "github:hyprwm/hyprland-plugins"; inputs.hyprland.follows = "hyprland"; };
        hyprsplit = { url = "github:shezdy/hyprsplit"; inputs.hyprland.follows = "hyprland"; };

        nix-colors.url = "github:misterio77/nix-colors";
	    nixvim = { url = "github:nix-community/nixvim"; inputs.nixpkgs.follows = "nixpkgs"; };

        mcmojave-hyprcursor.url = "github:libadoxon/mcmojave-hyprcursor";

        home-manager = { url = "github:nix-community/home-manager"; inputs.nixpkgs.follows = "nixpkgs"; };
    };

    outputs = { nixpkgs, home-manager, nix-colors, nixvim, ... } @ inputs: {
        nixosConfigurations.nixos = nixpkgs.lib.nixosSystem {
            specialArgs = { inherit inputs nixvim; };
            modules = [
                ./configuration.nix
                ./hardware-configuration.nix
                ./graphics.nix
                ./sound.nix
                ./usb.nix
                ./peripherals.nix
                ./time.nix
                ./bootloader.nix
                ./nix-settings.nix
                ./nixpkgs.nix
                ./kernel.nix
                ./desktop.nix
                ./theme.nix
                ./internationalisation.nix
                ./gaming.nix
                ./security.nix
                ./services.nix
                ./printing.nix
                ./env.nix
                ./network.nix
                ./users.nix
                ./virtualisation.nix
                ./programming.nix
                ./terminal.nix
                ./misc-pkgs.nix
            ];
        };

        homeConfigurations."srp@nixos" = home-manager.lib.homeManagerConfiguration {
            pkgs = nixpkgs.legacyPackages.x86_64-linux;
            extraSpecialArgs = { inherit inputs nix-colors nixvim; };
            modules = [
                ./home.nix
            ];
        };
    };
}
