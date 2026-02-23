# home/editors/zed.nix — Zed editor configuration.
# The settings file is managed as a dotfile outside the Nix store so it can be
# edited in-place without a rebuild.  Only the symlink itself is declared here.
{
  pkgs,
  inputs,
  config,
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

  # Link the Zed settings file from the dotfiles repo directly into
  # ~/.config/zed/settings.json.  mkOutOfStoreSymlink creates a plain
  # filesystem symlink rather than a Nix store path, so you can edit the
  # file and have Zed pick up changes without running `home-manager switch`.
  xdg.configFile."zed/settings.json".source =
    config.lib.file.mkOutOfStoreSymlink "${config.home.homeDirectory}/dotfiles/home/editors/zed/settings.json";
}
