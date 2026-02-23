# home/editors/default.nix — editor sub-modules.
# Add a new import here for each editor you want to manage declaratively.
{
  imports = [
    ./vscode.nix
    ./zed.nix
  ];
}
