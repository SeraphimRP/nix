{
    description = "srpnix";

    inputs = {
        nixpkgs.url = "github:nixos/nixpkgs?ref=nixos-unstable";

        hyprland.url = "github:hyprwm/Hyprland";
        hyprland-plugins = { url = "github:hyprwm/hyprland-plugins"; inputs.hyprland.follows = "hyprland"; };
        hyprland-split-monitor-workspaces = { url = "github:Duckonaut/split-monitor-workspaces"; inputs.hyprland.follows = "hyprland"; };

        home-manager = { url = "github:nix-community/home-manager"; inputs.nixpkgs.follows = "nixpkgs"; };
    };

    outputs = { nixpkgs, home-manager, ... } @ inputs: {
        nixosConfigurations.nixos = nixpkgs.lib.nixosSystem {
            specialArgs = { inherit inputs; };
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
                ./security.nix
                ./services.nix
                ./printing.nix
                ./env.nix
                ./network.nix
                ./users.nix
                ./virtualisation.nix
                ./programming.nix
                ./terminal.nix
            ];
        };

        homeConfigurations."srp@nixos" = home-manager.lib.homeManagerConfiguration {
            pkgs = nixpkgs.legacyPackages.x86_64-linux;
            extraSpecialArgs = { inherit inputs; };
            modules = [ ./home.nix ];
        };
    };
}
