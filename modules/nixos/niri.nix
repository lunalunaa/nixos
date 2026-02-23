# modules/nixos/niri.nix — system-level niri compositor and UWSM session config.
{ pkgs, vars, ... }:
{
  programs.niri = {
    enable = true;
    package = pkgs.niri;
  };

  # UWSM (Universal Wayland Session Manager) wraps niri in a proper systemd
  # user session, giving you clean session tracking and DBus activation.
  programs.uwsm = {
    enable = true;
    waylandCompositors = {
      niri = {
        prettyName = "Niri";
        comment = "Niri compositor managed by UWSM";
        binPath = "/run/current-system/sw/bin/niri-session";
      };
    };
  };

  # greetd + tuigreet: minimal TUI login manager that launches niri via UWSM.
  services.greetd = {
    enable = true;
    settings.default_session = {
      command = "${pkgs.tuigreet}/bin/tuigreet --time --cmd 'uwsm start default' --greeting 'welcome back'";
      user = vars.username;
    };
  };

  # XDG desktop portals for screen sharing, file pickers, etc.
  xdg.portal = {
    enable = true;
    config.common.default = "*";
    wlr.enable = true;
    extraPortals = with pkgs; [
      xdg-desktop-portal-gtk
      xdg-desktop-portal-gnome
    ];
  };
}
