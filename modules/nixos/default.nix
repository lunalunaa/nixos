# modules/nixos/default.nix — imports every NixOS module in this directory.
# Add a new file here and reference it below to extend the system configuration.
{
  imports = [
    ./boot.nix
    # ./cuda.nix
    ./fish.nix
    ./fonts.nix
    ./graphics.nix
    ./networking.nix
    ./niri.nix
    ./nix.nix
    ./services.nix
    ./sound.nix
    ./users.nix
  ];
}
