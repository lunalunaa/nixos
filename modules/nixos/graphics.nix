# modules/nixos/graphics.nix — NVIDIA GPU and hardware graphics configuration.
{ ... }:
{
  hardware.graphics.enable = true;

  services.xserver.videoDrivers = [ "nvidia" ];

  hardware.nvidia = {
    # Required for Wayland compositors.
    modesetting.enable = true;

    # Full suspend/resume power management (finegrained = dynamic power off,
    # disabled here for stability on a desktop-class GPU).
    powerManagement.enable = true;
    powerManagement.finegrained = false;

    # Use the open-source kernel module (Turing/Ampere/Ada and newer).
    open = true;

    # Install the nvidia-settings GUI utility.
    nvidiaSettings = true;
  };
}
