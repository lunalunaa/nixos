# modules/nixos/cuda.nix — CUDA compute stack for RTX 4070 (Ada Lovelace, sm_89).
#
# Key decisions:
#   - cudaSupport = true  makes nixpkgs rebuild GPU-aware packages (PyTorch,
#     JAX, etc.) with CUDA enabled.  This is a cache-miss flag — binary cache
#     hits become rare for any package that respects it, so only enable it if
#     you actually need GPU-accelerated ML/compute.
#   - cudaCapabilities = ["8.9"]  narrows code-gen to exactly the RTX 4070's
#     SM version, avoiding fat-binary bloat from compiling for every arch.
#   - cudaForwardCompat = false  drops the fallback PTX blob that lets drivers
#     newer than the toolkit run the binary.  Not needed when the driver and
#     toolkit are both managed by Nix and kept in sync.
{ config, pkgs, ... }:
{
  # ------------------------------------------------------------------ #
  # nixpkgs-wide CUDA flags
  # ------------------------------------------------------------------ #
  nixpkgs.config = {
    cudaSupport = true;
    cudaCapabilities = [ "8.9" ];
    cudaForwardCompat = false;
  };

  # ------------------------------------------------------------------ #
  # NVIDIA driver
  # Pin to the stable production driver so the CUDA runtime version that
  # the toolkit expects matches the one the kernel module exposes.
  # ------------------------------------------------------------------ #
  hardware.nvidia.package = config.boot.kernelPackages.nvidiaPackages.stable;

  # ------------------------------------------------------------------ #
  # Hardware graphics — expose CUDA / OpenGL interop libraries
  # ------------------------------------------------------------------ #
  hardware.graphics.extraPackages = with pkgs; [
    cudaPackages.cudatoolkit
    # VA-API / NVDEC video decode acceleration via NVIDIA driver
    nvidia-vaapi-driver
  ];

  # ------------------------------------------------------------------ #
  # System packages
  # ------------------------------------------------------------------ #
  environment.systemPackages = with pkgs; [
    # Full CUDA toolkit (nvcc, headers, libraries)
    cudaPackages.cudatoolkit
    # GPU monitoring — nvtop with NVIDIA backend
    nvtopPackages.nvidia
  ];

  # ------------------------------------------------------------------ #
  # Environment
  # CUDA_PATH lets build tools (cmake find_package(CUDA), meson, etc.)
  # and Python runtimes locate the toolkit without manual configuration.
  # ------------------------------------------------------------------ #
  environment.variables = {
    CUDA_PATH = "${pkgs.cudaPackages.cudatoolkit}";
    # Ensure the CUDA library path is on LD_LIBRARY_PATH so dynamically-
    # linked binaries (e.g. pip-installed torch) can find libcuda.so.
    LD_LIBRARY_PATH = [
      "${pkgs.cudaPackages.cudatoolkit}/lib"
      "${pkgs.cudaPackages.cudatoolkit}/lib64"
      "/run/opengl-driver/lib"
    ];
  };
}
