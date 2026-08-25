{
  pkgs,
  lib,
  config,
  ...
}: {
  options = {
    quickshell.enable =
      lib.mkEnableOption "enables quickshell";
  };

  config = lib.mkIf config.quickshell.enable {
    environment.systemPackages = [
      pkgs.quickshell
      pkgs.kdePackages.qtsvg
      pkgs.kdePackages.qtimageformats
      pkgs.kdePackages.qtmultimedia
      pkgs.kdePackages.qt5compat
    ];
  };

  # Optional, hint Electron apps to use Wayland:
  # environment.sessionVariables.NIXOS_OZONE_WL = "1";
}
