# home/core.nix — base identity, theming, and Home Manager bootstrap.
# Everything that doesn't belong to a specific program category lives here.
{
  pkgs,
  vars,
  ...
}:
{
  # ------------------------------------------------------------------ #
  # Identity
  # ------------------------------------------------------------------ #
  home.username = vars.username;
  home.homeDirectory = "/home/${vars.username}";
  home.stateVersion = vars.stateVersion;

  # Let Home Manager manage itself so `home-manager` CLI is always available.
  programs.home-manager.enable = true;

  # ------------------------------------------------------------------ #
  # Theming — Catppuccin Mocha across all supported programs
  # ------------------------------------------------------------------ #
  catppuccin = {
    flavor = "mocha";
    enable = true;
  };

  # Waybar has its own hand-crafted style sheet, so disable the
  # generated Catppuccin one to avoid conflicts.
  catppuccin.waybar.enable = false;

  # ------------------------------------------------------------------ #
  # Cursor
  # ------------------------------------------------------------------ #
  home.pointerCursor = {
    gtk.enable = true;
    x11.enable = true;
    package = pkgs.graphite-cursors;
    name = "graphite-dark";
  };

  # ------------------------------------------------------------------ #
  # GTK dark mode
  # ------------------------------------------------------------------ #
  gtk = {
    enable = true;
    theme = {
      name = "Adwaita-dark";
      package = pkgs.gnome-themes-extra;
    };
    gtk2.extraConfig = "gtk-error-bell = 0";
    gtk3.extraConfig = {
      gtk-error-bell = 0;
      gtk-application-prefer-dark-theme = 1;
    };
    gtk4.extraConfig = {
      gtk-error-bell = 0;
      gtk-application-prefer-dark-theme = 1;
    };
  };

  # ------------------------------------------------------------------ #
  # Nix tooling
  # ------------------------------------------------------------------ #

  # nix-index: fast `nix-locate` / comma command-not-found handler.
  programs.nix-index.enable = true;

  # direnv: auto-load per-project .envrc files; nix-direnv caches the
  # evaluation so shell entry stays instant even for large flakes.
  programs.direnv = {
    enable = true;
    enableBashIntegration = true;
    nix-direnv.enable = true;
  };
}
