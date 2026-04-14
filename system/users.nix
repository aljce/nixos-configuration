{ pkgs, config, ... }:
{ users = {
    mutableUsers = false;
    defaultUserShell = pkgs.zsh;
    users = {
      root.hashedPasswordFile = config.sops.secrets.rootPassword.path;
      alice = {
        isNormalUser = true;
        extraGroups = [ "wheel" "audio" "video" "sway" "plugdev" "networkmanager" ];
        hashedPasswordFile = config.sops.secrets.alicePassword.path;
      };
    };
  };
}
