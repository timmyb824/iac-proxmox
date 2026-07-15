module "wazuh" {
  source = "../../modules/lxc"

  hostname           = "wazuh"
  vm_id              = 100
  cores              = 4
  memory             = 4096
  swap               = 2048
  disk_size          = 25
  datastore_id       = "local-zfs2"
  create_os_template = false
  template_file_name = "ubuntu-24.04-standard_24.04-2_amd64.tar.zst"
  ssh_keys = [
    "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIG2iB7F01dMALwcGHFY9+140neloiAfJ1j5jlBOe+FF1 master-key",
    "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAINSzbKSzp5tG3vytJiWHlBUV9f1cmqzIWY3CH9Je+tI0 master-key-nopass",
  ]
  tags         = ["wazuh", "managed-by-tofu"]
  ipv6         = "auto"
  unprivileged = true
  os_type      = "ubuntu"
}

output "lxc_id" {
  description = "VMID of the LXC container"
  value       = module.wazuh.id
}

output "lxc_hostname" {
  description = "Hostname of the LXC container"
  value       = module.wazuh.hostname
}

output "lxc_mac_address" {
  description = "MAC address of eth0"
  value       = module.wazuh.mac_address
}
