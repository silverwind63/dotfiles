{
  services = {
    syncthing = {
      enable = true;
      openDefaultPorts = true;
      group = "users";
      user = "chj";
      configDir = "/home/chj/.config/syncthing"; # Folder for Syncthing's settings and keys
    };
  };

  networking.firewall.allowedTCPPorts = [
    8384
    22000
  ];
  networking.firewall.allowedUDPPorts = [
    22000
    21027
  ];
}
