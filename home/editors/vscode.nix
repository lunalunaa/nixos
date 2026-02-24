# home/editors/vscode.nix — VSCodium (telemetry-free VS Code) configuration.
# Extensions are pinned via nix-vscode-extensions; the nixd LSP is wired up
# to the exact nixpkgs revision and host config locked in this flake.
{
  pkgs,
  pkgs-unstable,
  vars,
  ...
}:
{
  programs.vscode = {
    enable = true;
    # VSCodium — identical to VS Code but with Microsoft telemetry stripped out.
    package = pkgs-unstable.vscode;

    profiles.default = {
      # Let Nix own the version; disable the editor's built-in update checks.
      enableExtensionUpdateCheck = false;
      enableUpdateCheck = false;

      extensions = with pkgs.nix-vscode-extensions.open-vsx; [
        jnoortheen.nix-ide
        rust-lang.rust-analyzer
        mkhl.direnv
      ];

      userSettings = {
        # ---------------------------------------------------------------- #
        # Editor appearance
        # ---------------------------------------------------------------- #
        "editor.fontFamily" = "JetBrainsMono Nerd Font";
        "editor.fontLigatures" = true;
        "editor.fontSize" = 16;
        "editor.formatOnSave" = true;
        "editor.minimap.enabled" = false;

        # ---------------------------------------------------------------- #
        # Terminal
        # ---------------------------------------------------------------- #
        "terminal.integrated.defaultProfile.linux" = "fish";

        # ---------------------------------------------------------------- #
        # nixd language server
        # Expressions point at this flake so completions reflect the exact
        # nixpkgs revision and host/HM options that are actually in use.
        # ---------------------------------------------------------------- #
        "nix.enableLanguageServer" = true;
        "nix.serverPath" = "nixd";
        "nix.serverSettings" = {
          "nixpkgs" = {
            "expr" = "import (builtins.getFlake \"${vars.flakePath}\").inputs.nixpkgs { }";
          };
          "nixd" = {
            "options" = {
              "nixos" = {
                "expr" = "(builtins.getFlake \"${vars.flakePath}\").nixosConfigurations.${vars.hostname}.options";
              };
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
}
