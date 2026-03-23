{ pkgs-unstable, ... }:
{
  programs.steam = {
    enable = true;
    package = pkgs-unstable.steam;
  };
}
