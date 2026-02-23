# modules/nixos/networking.nix — hostname, networking, locale, and timezone.
{ vars, ... }:
{
  networking = {
    hostName = vars.hostname;
    networkmanager.enable = true;
  };

  time.timeZone = vars.timezone;

  i18n.defaultLocale = vars.locale;
}
