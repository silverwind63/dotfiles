{pkgs, ...}: {
  environment.systemPackages = [
    pkgs.kdePackages.qtstyleplugin-kvantum
  ];
  # Optional, hint Electron apps to use Wayland:
  # environment.sessionVariables.NIXOS_OZONE_WL = "1";
}
