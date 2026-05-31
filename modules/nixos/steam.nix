# modules/nixos/steam.nix — Steam client (unstable for latest fixes and Proton).
{ pkgs, ... }:
{
  programs.steam = {
    enable = true;
    package = pkgs.unstable.steam;
  };
}
