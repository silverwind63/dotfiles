{pkgs, ...}: {
  environment.systemPackages = [
    pkgs.obsidian
  ];
  # Optional, hint Electron apps to use Wayland:
  # environment.sessionVariables.NIXOS_OZONE_WL = "1";
}
