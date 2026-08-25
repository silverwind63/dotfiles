{pkgs, ...}: {
  environment.systemPackages = [
    pkgs.libreoffice-qt-fresh
  ];
  # Optional, hint Electron apps to use Wayland:
  # environment.sessionVariables.NIXOS_OZONE_WL = "1";
}
