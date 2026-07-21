# NVIDIA for Albedo (RTX 5080 / Blackwell). Albedo-specific — do NOT use the
# shared ../common/nvidia.nix here:
#   * Blackwell (RTX 50-series) REQUIRES the open kernel module (open = true);
#     the closed module does not support these GPUs at all.
#   * Uses 25.05 option names (hardware.graphics, not the removed hardware.opengl).
{ config, lib, pkgs, ... }:
{
  hardware.graphics = {
    enable = true;
    enable32Bit = true;
  };

  services.xserver.videoDrivers = [ "nvidia" ];

  environment.variables = {
    GBM_BACKEND = "nvidia-drm";
    __GLX_VENDOR_LIBRARY_NAME = "nvidia";
  };

  boot.kernelParams = [ "nvidia-drm.fbdev=1" ];

  hardware.nvidia = {
    modesetting.enable = true;
    powerManagement.enable = true;
    powerManagement.finegrained = false;

    # REQUIRED for Blackwell / RTX 50-series.
    open = true;

    nvidiaSettings = true;

    # On 25.05 this is a 575.x driver, which supports Blackwell. If the very
    # newest card revision needs a beta, use `nvidiaPackages.beta` instead.
    package = config.boot.kernelPackages.nvidiaPackages.latest;
  };
}
