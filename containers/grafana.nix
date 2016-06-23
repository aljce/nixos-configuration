{ config, lib, pkgs, ... }:

{ containers.grafana = {
	autoStart = true;
	config = { config, lib, pkgs, ... }: {
                services.grafana = {
			enable = true;
			/*
			database = {
				password = "layer3";
				type = "postgresql";
			};
			users.allowSignUp = true;
			*/
	  	};
		services.openssh = {
			enable = true;
		};
	  	users = {
			mutableUsers = true;
			extraUsers.layer3 = {
				createHome = true;
				home = "/home/layer3";
				description = "Company Account";
				extraGroups = [ "wheel" ];
				initialPassword = "layer3";
				isNormalUser = true;
			};
  		};
	};
  };

}
