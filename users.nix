{ pkgs, ... }:
{ users = {
    mutableUsers = false;
    defaultUserShell = pkgs.zsh;
    users = {
      root.hashedPassword = "$6$BODlVLZlOPHCm$A4bcOGjOYOlVBftIXu0Fb8Cf7Kna0qUKIcON8F2uNK4SNHjsSuiEq/T5TYd4sR0RAtkK9/rB4t5J0Akm36hmd1";
      alice = {
        isNormalUser = true;
        extraGroups = [ "wheel" "audio" "video" "sway" ];
        hashedPassword = "$6$BODlVLZlOPHCm$A4bcOGjOYOlVBftIXu0Fb8Cf7Kna0qUKIcON8F2uNK4SNHjsSuiEq/T5TYd4sR0RAtkK9/rB4t5J0Akm36hmd1";
      };
    };
  };
}
