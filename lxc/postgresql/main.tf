# Import with: `tofu import module.postgresql.proxmox_virtual_environment_container.this pve4/114`

module "postgresql" {
  source = "../../modules/lxc"

  hostname           = "postgresql"
  node_name          = "pve4"
  vm_id              = 114
  cores              = 1
  memory             = 1024
  swap               = 512
  disk_size          = 96
  datastore_id       = "local-zfs4"
  create_os_template = false
  template_file_name = "debian-12-standard_12.12-1_amd64.tar.zst"
  ssh_keys           = []
  tags               = ["proxmox-helper-scripts", "managed-by-tofu"]
}

output "lxc_id" {
  description = "VMID of the LXC container"
  value       = module.postgresql.id
}

output "lxc_hostname" {
  description = "Hostname of the LXC container"
  value       = module.postgresql.hostname
}

output "lxc_mac_address" {
  description = "MAC address of eth0"
  value       = module.postgresql.mac_address
}
