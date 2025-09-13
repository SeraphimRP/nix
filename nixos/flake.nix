{
  description = "srpnix";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixpkgs-unstable";

    # hyprland.url = "github:hyprwm/Hyprland";
    # hyprland-plugins = {
    #   url = "github:hyprwm/hyprland-plugins";
    #   inputs.hyprland.follows = "hyprland";
    # };
    # hyprsplit = {
    #   url = "github:shezdy/hyprsplit";
    #   inputs.hyprland.follows = "hyprland";
    # };

    nixvim = {
      url = "github:nix-community/nixvim";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    lanzaboote = {
      url = "github:nix-community/lanzaboote/v0.4.2";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    home-manager = {
      url = "github:nix-community/home-manager/master";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    winapps = {
      url = "github:winapps-org/winapps";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    noctalia = {
      url = "github:noctalia-dev/noctalia-shell";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    quickshell = {
      url = "github:outfoxxed/quickshell";
      inputs.nixpkgs.follows = "nixpkgs";
      inputs.quickshell.follows = "quickshell";
    };

    millennium.url = "git+https://github.com/SteamClientHomebrew/Millennium?ref=v2.28.0&rev=e837940723baec50ff969e5004b46a153ed63c5b";
    bsp-casefolding-workaround.url = "github:SeraphimRP/bsp-casefolding-workaround-nix/stable";
    vicinae.url = "github:vicinaehq/vicinae/v0.8.5";
  };

  outputs =
    {
      nixpkgs,
      home-manager,
      nixvim,
      lanzaboote,
      winapps,
      bsp-casefolding-workaround,
      vicinae,
      noctalia,
      quickshell,
      ...
    }@inputs:
    {
      nixosConfigurations.nixos = nixpkgs.lib.nixosSystem {
        specialArgs = {
          inherit
            inputs
            nixvim
            lanzaboote
            winapps
            noctalia
            quickshell
            ;
        };
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
          #./programming-dotnet.nix
          ./terminal.nix
          ./misc-pkgs.nix
        ];
      };

      homeConfigurations."srp@nixos" = home-manager.lib.homeManagerConfiguration {
        pkgs = nixpkgs.legacyPackages.x86_64-linux;
        extraSpecialArgs = {
          inherit
            inputs
            nixvim
            bsp-casefolding-workaround
            vicinae
            ;
        };
        modules = [
          ./home.nix
          ./nixpkgs.nix
        ];
      };

      home-manager.backupFileExtension = "bak";
      home-manager.useGlobalPkgs = true;
      home-manager.useUserPackages = true;
    };
}
