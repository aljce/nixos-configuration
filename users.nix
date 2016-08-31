{ config, pkgs, ... }:
{
  users = {
    defaultUserShell = "/run/current-system/sw/bin/zsh";
    users.kyle = {
      isNormalUser = true;
      extraGroups = [ "wheel" ];
      initialPassword = "password";
      openssh.authorizedKeys.keyFiles = [ ./public-keys/kyle.pub ];
    };
  };
}
