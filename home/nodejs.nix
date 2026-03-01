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
  # home.sessionPath isn't sourced by fish, so set it explicitly there too.
  home.sessionPath = [
    "$HOME/.npm-global/bin"
    "$HOME/.local/bin"
  ];
  programs.fish.shellInit = ''
    fish_add_path --prepend --global "$HOME/.npm-global/bin"
    fish_add_path --prepend --global "$HOME/.local/bin"
  '';
}
