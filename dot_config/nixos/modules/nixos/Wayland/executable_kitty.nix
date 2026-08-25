{
  pkgs,
  lib,
  config,
  ...
}: {
  options = {
    kitty.enable =
      lib.mkEnableOption "enables kitty";
  };

  config = lib.mkIf config.kitty.enable {
    environment.systemPackages = [
      pkgs.kitty
    ];
  };

  # Optional, hint Electron apps to use Wayland:
  # environment.sessionVariables.NIXOS_OZONE_WL = "1";
}
