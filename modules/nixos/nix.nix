# modules/nixos/nix.nix — Nix daemon, garbage collection, and store settings.
{ vars, ... }:
{
  nix = {
    settings = {
      experimental-features = [
        "nix-command"
        "flakes"
      ];

      # Allow the primary user to manage the Nix store without sudo.
      trusted-users = [
        "root"
        vars.username
      ];

      # Hard-link identical files in the store to save disk space.
      auto-optimise-store = true;
    };

    # Weekly garbage collection — delete generations older than one week.
    gc = {
      automatic = true;
      dates = "weekly";
      options = "--delete-older-than 1w";
    };
  };
}
