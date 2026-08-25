{pkgs, ...}: {
  environment.systemPackages = [
    pkgs.firefox
    pkgs.librewolf
    pkgs.chromium
    pkgs.thunderbird
    pkgs.freetube
  ];
  # Optional, hint Electron apps to use Wayland:
  # environment.sessionVariables.NIXOS_OZONE_WL = "1";
}
