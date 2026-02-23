# modules/nixos/fish.nix — enable Fish system-wide so it is a valid login shell.
# The per-user Fish configuration (plugins, functions, etc.) lives in home/shell.nix.
{ pkgs-unstable, ... }:
{
  programs.fish = {
    enable = true;
    # Use the unstable version — it supports dynamic completion loading,
    # which is required for tools like jj to register their completions.
    package = pkgs-unstable.fish;
  };
}
