{pkgs, ...}: {
  environment.systemPackages = [
    pkgs.discord
  ];
  # Optional, hint Electron apps to use Wayland:
  # environment.sessionVariables.NIXOS_OZONE_WL = "1";
}
