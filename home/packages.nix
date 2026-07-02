# home/packages.nix — user-level packages installed into the Home Manager profile.
# Prefer adding programs with their own HM module (shell.nix, editors.nix, etc.)
# and only fall back to raw packages here when no module exists.
{ pkgs, ... }:
{
  home.packages =
    (with pkgs; [
      # ---------------------------------------------------------------- #
      # System / hardware info
      # ---------------------------------------------------------------- #
      hyfetch
      btop
      iotop
      iftop
      sysstat
      lm_sensors
      smartmontools
      pciutils
      usbutils
      ethtool

      # ---------------------------------------------------------------- #
      # Archives
      # ---------------------------------------------------------------- #
      zip
      xz
      unzip
      p7zip
      zstd

      # ---------------------------------------------------------------- #
      # CLI utilities
      # ---------------------------------------------------------------- #
      ripgrep
      jq
      yq-go
      fzf
      file
      which
      tree
      gnused
      gnutar
      gawk

      # ---------------------------------------------------------------- #
      # Networking tools
      # ---------------------------------------------------------------- #
      mtr
      iperf3
      dnsutils
      ldns
      aria2
      socat
      nmap
      ipcalc

      # ---------------------------------------------------------------- #
      # System call / process tracing
      # ---------------------------------------------------------------- #
      strace
      ltrace
      lsof

      # ---------------------------------------------------------------- #
      # Nix tooling
      # ---------------------------------------------------------------- #
      nix-output-monitor
      nixfmt-rfc-style
      nixd

      # ---------------------------------------------------------------- #
      # Development
      # ---------------------------------------------------------------- #
      difftastic

      # ---------------------------------------------------------------- #
      # Desktop / Wayland utilities
      # ---------------------------------------------------------------- #
      xwayland-satellite
      waypaper
      swaybg
      pavucontrol
      bluetui

      # ---------------------------------------------------------------- #
      # Applications
      # ---------------------------------------------------------------- #
      vesktop
      motrix
      mpv
      vivaldi
      ffmpeg
      vlc
      geeqie

      # ---------------------------------------------------------------- #
      # Productivity
      # ---------------------------------------------------------------- #
      hugo
      glow
      texlive.combined.scheme-medium
      gnupg

      # ---------------------------------------------------------------- #
      # Fun
      # ---------------------------------------------------------------- #
      cowsay
      sox

      # ---------------------------------------------------------------- #
      # Communication
      # ---------------------------------------------------------------- #
      signal-desktop
    ])
    ++ (with pkgs.unstable; [
      overskride
      qbittorrent-enhanced
      lazyjj
      lazygit
      telegram-desktop
    ]);
}
