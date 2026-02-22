{ pkgs, ... }:
{

  imports = [ ./waybar ];
  fonts.fontconfig = {
    enable = true;
  };

  i18n.inputMethod = {
    enable = true;
    type = "fcitx5";
    fcitx5.waylandFrontend = true;
    fcitx5.addons = with pkgs; [ fcitx5-rime ];
  };

  programs.fuzzel = {
    enable = true;
  };

  programs.waybar = {
    enable = true;
    systemd.enable = true;
  };

  services.mako = {
    enable = true;
  };

  programs.swaylock = {
    enable = true;
  };

  programs.niri = {
    config = (builtins.readFile ./config.kdl);
  };

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
}
