{
  description = "A simple NixOS flake";

  inputs = {
    # NixOS official package source, using the nixos-25.11 branch here
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.11";
    nixpkgs-unstable.url = "github:NixOS/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager/release-25.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    nix-vscode-extensions.url = "github:nix-community/nix-vscode-extensions/master";
    catppuccin = {
      url = "github:catppuccin/nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    niri = {
      url = "github:sodiboo/niri-flake/main";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    rust-overlay = {
      url = "github:oxalica/rust-overlay";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    sops-nix = {
      url = "github:Mic92/sops-nix";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs =
    inputs@{
      self,
      nixpkgs,
      home-manager,
      nixpkgs-unstable,
      nix-vscode-extensions,
      niri,
      catppuccin,
      sops-nix,
      ...
    }:
    let
      system = "x86_64-linux";
      pkgs-unstable = import nixpkgs-unstable {
        inherit system;
        config.allowUnfree = true;
      };
      # pkgs = import nixpkgs {
      #   inherit system;
      #   config.allowUnfree = true;
      #   overlays = [
      #     inputs.niri.overlays.niri
      #     nix-vscode-extensions.overlays.default
      #   ];
      # };
    in
    {
      # Please replace my-nixos with your hostname
      nixosConfigurations.nixos = nixpkgs.lib.nixosSystem {
        specialArgs = {
          inherit inputs;
          # inherit pkgs;
          inherit pkgs-unstable;
        };
        modules = [
          {
            nixpkgs = {
              inherit system;
              config.allowUnfree = true;
              overlays = [
                inputs.niri.overlays.niri
                nix-vscode-extensions.overlays.default
              ];
            };
          }
          ./configuration.nix
          catppuccin.nixosModules.catppuccin

          # home manager
          home-manager.nixosModules.home-manager
          {
            home-manager.useGlobalPkgs = true;
            home-manager.useUserPackages = true;

            home-manager.users.luna = {
              imports = [
                ./home
                catppuccin.homeModules.catppuccin
              ];
            };
            home-manager.extraSpecialArgs = {
              inherit nix-vscode-extensions;
              inherit pkgs-unstable;
            };
            home-manager.backupFileExtension = "backup";
          }

          # niri
          niri.nixosModules.niri
          sops-nix.nixosModules.sops
        ];
      };
    };
}
