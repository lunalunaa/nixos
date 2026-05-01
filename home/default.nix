# home/default.nix — entry point for the Home Manager configuration.
# Each file covers a single concern; add new imports here to extend the config.
{
  imports = [
    ./core.nix
    ./shell.nix
    ./git.nix
    ./editors
    ./packages.nix
    ./nodejs.nix
    ./desktop
    ./default-apps.nix
    ./agent.nix
  ];
}
