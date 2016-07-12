# Do not modify this file!  It was generated by ‘nixos-generate-config’
# and may be overwritten by future invocations.  Please make changes
# to /etc/nixos/configuration.nix instead.
{ config, lib, pkgs, ... }:

{
  imports =
    [ <nixpkgs/nixos/modules/installer/scan/not-detected.nix>
    ];

  boot.initrd.availableKernelModules = [ "xhci_pci" "ehci_pci" "ahci" "usb_storage" "sd_mod" "rtsx_pci_sdmmc" ];
  boot.kernelModules = [ "kvm-intel" ];
  boot.extraModulePackages = [ ];

  fileSystems."/" =
    { device = "/dev/disk/by-uuid/aa1a4e00-82f3-45c1-a5ce-8468bc3ce571";
      fsType = "btrfs";
      options = [ "noatime" "nodiratime" "discard" ];
    };

  fileSystems."/boot" =
    { device = "/dev/disk/by-uuid/CA8C-6657";
      fsType = "vfat";
      options = [ "noatime" "nodiratime" "discard" ];
    };

  fileSystems."/nix" =
    { device = "/dev/disk/by-uuid/b38376b0-8690-4940-a904-9cdba6f80941";
      fsType = "btrfs";
      options = [ "noatime" "nodiratime" "discard" ];
    };

  fileSystems."/var" =
    { device = "/dev/disk/by-uuid/f9323fc8-2e5e-4ab8-a5ad-508d2912de91";
      fsType = "btrfs";
      options = [ "noatime" "nodiratime" "discard" ];
    };

  fileSystems."/home" =
    { device = "/dev/disk/by-uuid/35e25482-4ea9-4d9c-b481-4180737fc76a";
      fsType = "btrfs";
      options = [ "noatime" "nodiratime" "discard" ];
    };

  swapDevices = [ ];

  nix.maxJobs = lib.mkDefault 8;
}
