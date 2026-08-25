{ pkgs, ... }: {
  environment.systemPackages = [
    pkgs.kdePackages.kdenlive
    pkgs.davinci-resolve
  ];
  # Optional, hint Electron apps to use Wayland:
  # environment.sessionVariables.NIXOS_OZONE_WL = "1";
}
