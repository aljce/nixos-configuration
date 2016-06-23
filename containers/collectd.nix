{ config, lib, pkgs, ... }:

{ containers.collectd = {
    autoStart = true;
    config = { config, lib, pkgs, ... }: {
      environment.systemPackages = with pkgs; [
	net_snmp
      ];
      services.collectd = {
        enable = true;
	extraConfig = ''
		LoadPlugin "logfile"
		<Plugin "logfile">
		  LogLevel "info"
		  File "var/log/collectd.log"
		  Timestamp true
   		</Plugin>
		LoadPlugin snmp
		LoadPlugin write_graphite
		<Plugin snmp>
		  <Data "if_Octets">
		    Type "if_octets"
		    Table true
		    Values "IF-MIB::ifInOctets" "IF-MIB::ifOutOctets"
		  </Data>
		  <Host "controller">
		    Address "10.10.10.1"
		    Version 2
		    Community "opsview"
		    Collect "if_Octets"
		    Interval 60
                  </Host>
		</Plugin>
		<Plugin write_graphite>
		  <Node "collectd">
		    Host "localhost"
		    Port "2003"
		    Protocol "tcp"
		    LogSendErrors true
		    StoreRates true
		    AlwaysAppendDS false
		    SeparateInstances false
		    EscapeCharacter "_"
		  </Node>
 		</Plugin>	
	'';
      };
      services.openssh = {
        enable = true;
      };
    };
  };
}
