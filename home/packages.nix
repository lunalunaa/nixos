# home/packages.nix — user-level packages installed into the Home Manager profile.
# Prefer adding programs with their own HM module (shell.nix, editors.nix, etc.)
# and only fall back to raw packages here when no module exists.
{
  pkgs,
  pkgs-unstable,
  ...
}:
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
      eza
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
      helix

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
      firefox
      telegram-desktop
      webcord-vencord
      motrix
      mpv
      vivaldi

      # ---------------------------------------------------------------- #
      # Productivity
      # ---------------------------------------------------------------- #
      hugo
      glow
      texlive.combined.scheme-full

      # ---------------------------------------------------------------- #
      # Fun
      # ---------------------------------------------------------------- #
      cowsay
      gnupg
    ])
    ++ (with pkgs-unstable; [
      qbittorrent-enhanced
    ]);
}
