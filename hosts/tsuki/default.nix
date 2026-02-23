# hosts/tsuki/default.nix — entry point for the "tsuki" machine.
# Wires together NixOS modules, Home Manager, and all third-party flake modules.
{ inputs }:
let
  vars = import ../../vars.nix;

  pkgs-unstable = import inputs.nixpkgs-unstable {
    inherit (vars) system;
    config.allowUnfree = true;
  };

  # Shared specialArgs passed to both NixOS modules and Home Manager.
  specialArgs = { inherit inputs vars pkgs-unstable; };
in
inputs.nixpkgs.lib.nixosSystem {
  inherit (vars) system;
  inherit specialArgs;

  modules = [
    # ------------------------------------------------------------------ #
    # nixpkgs configuration
    # ------------------------------------------------------------------ #
    {
      nixpkgs = {
        config.allowUnfree = true;
        overlays = [
          inputs.niri.overlays.niri
          inputs.nix-vscode-extensions.overlays.default
        ];
      };
    }

    # ------------------------------------------------------------------ #
    # Hardware
    # ------------------------------------------------------------------ #
    ./hardware-configuration.nix

    # ------------------------------------------------------------------ #
    # NixOS modules
    # ------------------------------------------------------------------ #
    ../../modules/nixos

    # ------------------------------------------------------------------ #
    # Third-party NixOS modules
    # ------------------------------------------------------------------ #
    inputs.catppuccin.nixosModules.catppuccin
    inputs.niri.nixosModules.niri
    inputs.sops-nix.nixosModules.sops

    # ------------------------------------------------------------------ #
    # Home Manager
    # ------------------------------------------------------------------ #
    inputs.home-manager.nixosModules.home-manager
    {
      home-manager = {
        useGlobalPkgs = true;
        useUserPackages = true;
        backupFileExtension = "backup";
        extraSpecialArgs = specialArgs;

        users.${vars.username} = {
          imports = [
            ../../home
            inputs.catppuccin.homeModules.catppuccin
          ];
        };
      };
    }
  ];
}
