{ config, lib, pkgs, ... }:

{ containers.graphite = {
	autoStart = true;
	config = { config, lib, pkgs, ... }: {
                services.graphite.api = {
			enable = true;
			listenAddress = "127.0.0.1";
			port = 8000;
			
	  	};
		services.graphite.web = {
			enable = true;
		};
		services.graphite.carbon = {
			enableCache = true;
			enableRelay = true;
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
