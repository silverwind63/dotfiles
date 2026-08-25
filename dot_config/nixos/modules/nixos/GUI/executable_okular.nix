{pkgs, ...}: {
  environment.systemPackages = [
    pkgs.kdePackages.okular
  ];
  # Optional, hint Electron apps to use Wayland:
  # environment.sessionVariables.NIXOS_OZONE_WL = "1";
}
