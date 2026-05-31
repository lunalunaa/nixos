# modules/nixos/tailscale.nix — Tailscale mesh VPN.
{ pkgs, ... }:

{
  # 1. Enable the service and the firewall
  services.tailscale = {
    enable = true;
    package = pkgs.unstable.tailscale;
  };

  # 2. Force tailscaled to use nftables (Critical for clean nftables-only systems)
  # This avoids the "iptables-compat" translation layer issues.
  systemd.services.tailscaled.serviceConfig.Environment = [
    "TS_DEBUG_FIREWALL_MODE=nftables"
  ];
}
