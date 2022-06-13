{ pkgs, config, ... }:
{ users = {
    mutableUsers = false;
    defaultUserShell = pkgs.zsh;
    users = {
      root.passwordFile = config.sops.secrets.rootPassword.path;
      alice = {
        isNormalUser = true;
        extraGroups = [ "wheel" "audio" "video" "sway" "plugdev" "networkmanager" ];
        passwordFile = config.sops.secrets.alicePassword.path;
      };
    };
  };
}
