# home/editors.nix — VSCodium and Zed editor configuration.
# LSP server paths are derived from vars so they stay correct across renames.
{
  pkgs,
  pkgs-unstable,
  inputs,
  vars,
  ...
}:
{
  # ------------------------------------------------------------------ #
  # VSCodium (VS Code without telemetry)
  # ------------------------------------------------------------------ #
  programs.vscode = {
    enable = true;
    package = pkgs-unstable.vscodium;

    profiles.default = {
      # Disable built-in update machinery — Nix manages the package version.
      enableExtensionUpdateCheck = false;
      enableUpdateCheck = false;

      extensions = with pkgs.nix-vscode-extensions.open-vsx; [
        jnoortheen.nix-ide
        rust-lang.rust-analyzer
        mkhl.direnv
      ];

      userSettings = {
        "editor.fontFamily" = "JetBrainsMono Nerd Font";
        "editor.fontLigatures" = true;
        "editor.fontSize" = 16;
        "editor.formatOnSave" = true;
        "editor.minimap.enabled" = false;
        "terminal.integrated.defaultProfile.linux" = "fish";

        # ------------------------------------------------------------ #
        # nixd language server
        # ------------------------------------------------------------ #
        "nix.enableLanguageServer" = true;
        "nix.serverPath" = "nixd";
        "nix.serverSettings" = {
          "nixpkgs" = {
            # Point nixd at the exact nixpkgs revision locked in the flake
            # so completion results match what the system actually uses.
            "expr" = "import (builtins.getFlake \"${vars.flakePath}\").inputs.nixpkgs { }";
          };
          "nixd" = {
            "options" = {
              # NixOS option completion for this host's configuration.
              "nixos" = {
                "expr" = "(builtins.getFlake \"${vars.flakePath}\").nixosConfigurations.${vars.hostname}.options";
              };
              # Home Manager option completion for this user's configuration.
              "home-manager" = {
                "expr" =
                  "(builtins.getFlake \"${vars.flakePath}\").nixosConfigurations.${vars.hostname}.options.home-manager.users.type.getSubOptions []";
              };
            };
          };
        };
      };
    };
  };

  # ------------------------------------------------------------------ #
  # Zed — GPU-accelerated editor from the Zed flake (latest build)
  # ------------------------------------------------------------------ #
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
