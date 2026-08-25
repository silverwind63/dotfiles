{ lib, ... }:
{
  programs.hyprland.enable = true; # enable Hyprland

  imports = [
    ./awww.nix
    ./kitty.nix
    ./quickshell.nix
    ./wl-clipboard.nix
    ./hyprshot.nix
  ];
  awww.enable = lib.mkDefault true;
  kitty.enable = lib.mkDefault true;
  quickshell.enable = lib.mkDefault true;
  wl-clipboard.enable = lib.mkDefault true;
  hyprshot.enable = lib.mkDefault true;

  # Optional, hint Electron apps to use Wayland:
  # environment.sessionVariables.NIXOS_OZONE_WL = "1";
}
