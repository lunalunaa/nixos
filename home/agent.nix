{ ... }:
{
  # alias for hermes agent
  programs.fish.shellAliases = {
    hermes = "nix run github:NousResearch/hermes-agent -- ";
  };
}
