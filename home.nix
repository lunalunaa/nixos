{ config, pkgs, ... }:

{
  home.username = "luna";
  home.homeDirectory = "/home/luna";

  home.packages = with pkgs; [
    htop
    git
  ];

  programs.vim.enable = true;
  programs.vscode.enable = true;

  home.stateVersion = "25.11";

  # Let Home Manager install and manage itself.
  programs.home-manager.enable = true;
}
