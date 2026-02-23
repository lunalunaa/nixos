# home/desktop/niri/default.nix — Home Manager config for the niri desktop session.
# Covers the app launcher, notifications, screen locker, status bar, and IME.
{ pkgs, ... }:
{
  imports = [ ./waybar ];

  # Font rendering — ensure fontconfig picks up Home Manager-managed fonts.
  fonts.fontconfig.enable = true;

  # ------------------------------------------------------------------ #
  # Niri — the scrollable-tiling Wayland compositor
  # ------------------------------------------------------------------ #
  programs.niri = {
    # Load the KDL config file verbatim.  Keep it as a separate file so
    # it can be edited without touching any Nix expressions.
    config = builtins.readFile ./config.kdl;
  };

  # ------------------------------------------------------------------ #
  # Fuzzel — Wayland-native application launcher
  # ------------------------------------------------------------------ #
  programs.fuzzel = {
    enable = true;
  };

  # ------------------------------------------------------------------ #
  # Waybar — status bar (settings live in ./waybar/default.nix)
  # ------------------------------------------------------------------ #
  programs.waybar = {
    enable = true;
    # Run waybar as a systemd user service so it starts with the session
    # and is automatically restarted if it crashes.
    systemd.enable = true;
  };

  # ------------------------------------------------------------------ #
  # Mako — Wayland notification daemon
  # ------------------------------------------------------------------ #
  services.mako = {
    enable = true;
  };

  # ------------------------------------------------------------------ #
  # Swaylock — screen locker for Wayland
  # ------------------------------------------------------------------ #
  programs.swaylock = {
    enable = true;
  };

  # ------------------------------------------------------------------ #
  # Fcitx5 — input method framework (Chinese — Rime engine)
  # ------------------------------------------------------------------ #
  i18n.inputMethod = {
    enable = true;
    type = "fcitx5";
    fcitx5.waylandFrontend = true;
    fcitx5.addons = with pkgs; [
      fcitx5-rime
    ];
  };
}
