{
  pkgs,
  lib,
  config,
  ...
}:
{
  imports = [ ./docker.nix ];
  environment.systemPackages = with pkgs; [
    btop
    unzip
    zip
    ripgrep
    jq
    fzf
    zoxide
    yazi
    tmux
    mpv
    youtube-tui
    rmpc
    mpd
    cava
    bat
    delta
    bandwhich
    gdu
    fend
    upower
    pipes
    kew
    docker
    #qemu_full
    sshfs
    yt-dlp
    ffmpeg
    tldr
    smassh
    ghostty
    cbonsai
  ];
  # Optional, hint Electron apps to use Wayland:
  # environment.sessionVariables.NIXOS_OZONE_WL = "1";
}
