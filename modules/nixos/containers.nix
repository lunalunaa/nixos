# modules/nixos/containers.nix — rootless Podman with Docker CLI compatibility.
{ pkgs, ... }:
{
  virtualisation.podman = {
    enable = true;
    # Installs a `docker` → `podman` shim so Docker CLI commands work.
    dockerCompat = true;
    # Enable DNS so containers in the same network resolve each other by name.
    defaultNetwork.settings.dns_enabled = true;
  };

  environment.systemPackages = [ pkgs.podman-compose ];

  # Generate a CDI spec on boot so rootless Podman can access the NVIDIA GPU.
  hardware.nvidia-container-toolkit.enable = true;
}
