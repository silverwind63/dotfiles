{
  pkgs,
  lib,
  config,
  ...
}: {
  options = {
    awww.enable =
      lib.mkEnableOption "enables awww";
  };

  config = lib.mkIf config.awww.enable {
    environment.systemPackages = [
      pkgs.awww
    ];
  };

  # Optional, hint Electron apps to use Wayland:
  # environment.sessionVariables.NIXOS_OZONE_WL = "1";
}
