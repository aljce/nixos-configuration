{ config, pkgs, lib, ... }:
{ home-manager.users.alice.config.systemd.user.services.waybar = {
    Unit = {
      Description = "waybar status bar";
      BindsTo = [ "graphical-session.target" ];
      After = [ "graphical-session-pre.target" ];
    };
    Service = {
      ExecStart = "${pkgs.waybar}/bin/waybar --config ${./waybar/config} --style ${./waybar/style.css}";
    };
    # Install = {
    #  WantedBy = [ "graphical-session.target" ];
    # };
  };
}

