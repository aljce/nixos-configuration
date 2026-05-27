{ pkgs, ... }: {
  services.sentinelone = {
    enable = true;
    sentinelOneManagementTokenPath = ./s1token;          # Point to the file with the enrollment key
    customerId = "alice@mercury.venus";            # USE: emailAddress-hostname
    package = pkgs.sentinelone.overrideAttrs (old: {
      pname = "sentinelagent";
      version = "25.4.1.24";                             # Match the package version
      src = ./SentinelAgent_linux_x86_64_v25_4_1_24.deb; # Point to the package you've downloaded
    });
  };
}
