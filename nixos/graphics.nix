{ pkgs, ... }:

{
  hardware.graphics = {
    enable = true;
    enable32Bit = true;
    extraPackages = with pkgs; [
      mesa
      rocmPackages.clr.icd # OpenCL
    ];
    extraPackages32 = with pkgs.pkgsi686Linux; [
      mesa
    ];
  };
  hardware.amdgpu.opencl.enable = true;
  hardware.amdgpu.amdvlk.enable = true;
  services.xserver.videoDrivers = [ "amdgpu" ];

  boot.kernelParams = [
    "video=DP-2:2560x1440@144"
    "video=HDMI-A-2:2560x1440@60"
  ];
}
