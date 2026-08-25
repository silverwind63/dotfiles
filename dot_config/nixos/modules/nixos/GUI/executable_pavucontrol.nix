{pkgs, ...}: {
  environment.systemPackages = [
    pkgs.pavucontrol
  ];
  # Optional, hint Electron apps to use Wayland:
  # environment.sessionVariables.NIXOS_OZONE_WL = "1";
}
