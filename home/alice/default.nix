{ pkgs, ... }:
let user = {
      userid = "alice";
      username = "mckeankylej";
      legal-name = "Alice McKean";
      email = "mckean.kylej@gmail.com";
    };
in
{ imports = [
    (import ./programs.nix user)
    (import ./wayland.nix user)
  ];
  users.users.${user.userid} = {
    isNormalUser = true;
    extraGroups = [ "wheel" "audio" "video" "sway" ];
    hashedPassword = "$6$BODlVLZlOPHCm$A4bcOGjOYOlVBftIXu0Fb8Cf7Kna0qUKIcON8F2uNK4SNHjsSuiEq/T5TYd4sR0RAtkK9/rB4t5J0Akm36hmd1";
  };
}
