{ pkgs, ... }:
{ imports = [ ./screen-sharing.nix ];
  programs.sway.enable = true;
  environment.loginShellInit = ''
    if [[ -z $DISPLAY ]] && [[ $(tty) = /dev/tty1 ]]; then
          sway --unsupported-gpu -V > .sway-log 2>&1
    fi
  '';
}
