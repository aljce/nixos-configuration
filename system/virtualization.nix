{ pkgs, ... }:
{ 
  virtualisation.docker = {
    enable = true;
  };

  # programs.virt-manager.enable = true;

  # users.groups.libvirtd.members = ["alice"];

  # virtualisation.libvirtd = {
  #   enable = true;
  #   qemu = {
  #     swtpm.enable = true;  # Enable software TPM emulation
  #     ovmf.enable = true;   # Enable UEFI firmware support (required for TPM)
  #   };
  # };

  # virtualisation.spiceUSBRedirection.enable = true;
}
