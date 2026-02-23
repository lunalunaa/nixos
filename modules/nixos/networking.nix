# modules/nixos/networking.nix — hostname, networking, locale, and timezone.
{ vars, config, ... }:
{
  networking = {
    hostName = vars.hostname;
    networkmanager.enable = true;
  };

  time.timeZone = vars.timezone;

  i18n.defaultLocale = vars.locale;

  networking.nftables.enable = true;
  networking.firewall = {
    enable = true;
    # Always allow traffic from your Tailscale network
    trustedInterfaces = [ "tailscale0" ];
    # Allow the Tailscale UDP port through the firewall
    allowedUDPPorts = [ config.services.tailscale.port ];
  };
}
