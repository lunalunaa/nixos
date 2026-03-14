# modules/nixos/bluetooth.nix — Bluetooth hardware support and daemon.
{ ... }:
{
  hardware.bluetooth = {
    enable = true;
    powerOnBoot = true;
  };

  services.blueman.enable = true;
}
