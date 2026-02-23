# home/editors/zed.nix — Zed editor configuration.
# The settings file is managed as a dotfile outside the Nix store so it can be
# edited in-place without a rebuild.  Only the symlink itself is declared here.
{
  pkgs,
  inputs,
  ...
}:
{
  programs.zed-editor = {
    enable = true;
    # Pull the very latest Zed from its own flake rather than nixpkgs.
    package = inputs.zed.packages.${pkgs.stdenv.hostPlatform.system}.default;

    extensions = [
      "nix"
      "toml"
      "rust"
    ];
  };
}
