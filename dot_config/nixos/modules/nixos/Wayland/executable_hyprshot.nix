{
  pkgs,
  lib,
  config,
  ...
}:
{
  options = {
    hyprshot.enable = lib.mkEnableOption "enables hyprshot";
  };

  config = lib.mkIf config.hyprshot.enable {
    environment.systemPackages = [
      pkgs.hyprshot
    ];
  };

  # Optional, hint Electron apps to use Wayland:
  # environment.sessionVariables.NIXOS_OZONE_WL = "1";
}
