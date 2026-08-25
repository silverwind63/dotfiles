{
  pkgs,
  lib,
  config,
  ...
}: {
  options = {
    wl-clipboard.enable =
      lib.mkEnableOption "enables wl-clipboard";
  };

  config = lib.mkIf config.wl-clipboard.enable {
    environment.systemPackages = [
      pkgs.wl-clipboard
      pkgs.cliphist
    ];
  };

  # Optional, hint Electron apps to use Wayland:
  # environment.sessionVariables.NIXOS_OZONE_WL = "1";
}
