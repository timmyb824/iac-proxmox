# Import with: `tofu import module.mariadb.proxmox_virtual_environment_container.this pve2/207`

module "mariadb" {
  source = "../../modules/lxc"

  hostname           = "mariadb"
  vm_id              = 207
  cores              = 1
  memory             = 1024
  swap               = 512
  disk_size          = 16
  datastore_id       = "local-zfs2"
  create_os_template = false
  template_file_name = "debian-12-standard_12.12-1_amd64.tar.zst"
  ssh_keys           = []
  tags               = ["managed-by-tofu", "community-script", "database"]
  ipv6               = "auto"
}

output "lxc_id" {
  description = "VMID of the LXC container"
  value       = module.mariadb.id
}

output "lxc_hostname" {
  description = "Hostname of the LXC container"
  value       = module.mariadb.hostname
}

output "lxc_mac_address" {
  description = "MAC address of eth0"
  value       = module.mariadb.mac_address
}
