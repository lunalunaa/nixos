# vars.nix — single source of truth for system-wide variables.
# Passed to both NixOS modules and Home Manager via specialArgs.
{
  username = "luna";
  hostname = "tsuki";
  system = "x86_64-linux";
  timezone = "America/Toronto";
  locale = "en_CA.UTF-8";
  stateVersion = "25.11";

  # Absolute path to the flake on disk — used by editor LSP configs.
  flakePath = "/home/luna/dotfiles/nixos";

  git = {
    name = "Luna Xin";
    email = "luna.xin@outlook.com";
  };
}
