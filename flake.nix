{
  description = "Luna's NixOS configuration";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-25.11";
    nixpkgs-unstable.url = "github:NixOS/nixpkgs/nixos-unstable";

    flake-parts.url = "github:hercules-ci/flake-parts";

    home-manager = {
      url = "github:nix-community/home-manager/release-25.11";
      inputs.nixpkgs.follows = "nixpkgs";
    };

    nix-vscode-extensions.url = "github:nix-community/nix-vscode-extensions/master";

    catppuccin = {
      url = "github:catppuccin/nix/release-25.11";
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

    zed.url = "github:zed-industries/zed";
  };

  outputs =
    inputs:
    inputs.flake-parts.lib.mkFlake { inherit inputs; } {
      systems = [ "x86_64-linux" ];

      # nixosConfigurations live in the flake-level output, not perSystem,
      # because they are tied to a specific host rather than a build platform.
      flake = {
        nixosConfigurations = import ./hosts { inherit inputs; };
      };

      perSystem =
        { pkgs, ... }:
        {
          # `nix fmt` will format the whole repo with nixfmt.
          formatter = pkgs.nixfmt-rfc-style;

          # `nix develop` drops you into a shell with Nix LSP tooling.
          devShells.default = pkgs.mkShell {
            name = "nixos-config";
            packages = with pkgs; [
              nixd
              nil
              nixfmt-rfc-style
            ];
          };
        };
    };
}
