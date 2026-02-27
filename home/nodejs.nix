# home/nodejs.nix — Node.js runtime and npm global package configuration.
{ pkgs, ... }:
{
  home.packages = with pkgs; [
    nodejs
  ];

  # Set npm global prefix to ~/.npm-global so packages installed with
  # `npm install -g` land in the home directory rather than the Nix store.
  home.file.".npmrc".text = ''
    prefix=${"\${HOME}"}/.npm-global
  '';

  # Expose globally-installed npm binaries in PATH.
  home.sessionPath = [ "$HOME/.npm-global/bin" ];
}
