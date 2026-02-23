# modules/nixos/boot.nix — bootloader, kernel, and early init settings.
{ pkgs, ... }:
{
  boot = {
    loader = {
      systemd-boot = {
        enable = true;
        # Keep the last 10 generations to avoid filling the EFI partition.
        configurationLimit = 10;
      };
      efi.canTouchEfiVariables = true;
    };

    # Track the latest stable kernel.
    kernelPackages = pkgs.linuxPackages_6_18;
  };
}
