# modules/nixos/fish.nix — enable Fish system-wide so it is a valid login shell.
# The per-user Fish configuration (plugins, functions, etc.) lives in home/shell.nix.
{ pkgs, ... }:
{
  programs.fish = {
    enable = true;
    # Use the unstable version — it supports dynamic completion loading,
    # which is required for tools like jj to register their completions.
    package = pkgs.unstable.fish;
    # fish 4.8.0 dropped share/fish/tools/create_manpage_completions.py,
    # which breaks NixOS's auto-generated manpage completions build
    # (nix-community/home-manager#8178). Disable until upstream adapts.
    generateCompletions = false;
  };
}
