module "pialert" {
  source = "../../modules/lxc"

  hostname           = "pialert"
  vm_id              = 107
  cores              = 1
  memory             = 512
  swap               = 512
  disk_size          = 16
  datastore_id       = "local-zfs2"
  create_os_template = false
  template_file_name = "debian-12-standard_12.12-1_amd64.tar.zst"
  ssh_keys           = []
  tags               = ["community-script", "network", "managed-by-tofu"]
  ipv6               = "auto"
}

output "lxc_id" {
  description = "VMID of the LXC container"
  value       = module.pialert.id
}

output "lxc_hostname" {
  description = "Hostname of the LXC container"
  value       = module.pialert.hostname
}

output "lxc_mac_address" {
  description = "MAC address of eth0"
  value       = module.pialert.mac_address
}
