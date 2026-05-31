# home/default.nix — entry point for the Home Manager configuration.
# Each file covers a single concern; add new imports here to extend the config.
{
  imports = [
    ./core.nix
    ./desktop
    ./editors
    ./git.nix
    ./nodejs.nix
    ./packages.nix
    ./shell.nix
    ./default-apps.nix
  ];
}
