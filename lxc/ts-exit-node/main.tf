# Import with: `tofu import module.ts-exit-node.proxmox_virtual_environment_container.this pve4/105`

module "ts-exit-node" {
  source = "../../modules/lxc"

  hostname           = "ts-exit-node"
  node_name          = "pve4"
  vm_id              = 105
  cores              = 1
  memory             = 512
  swap               = 512
  disk_size          = 16
  datastore_id       = "local-zfs4"
  create_os_template = false
  template_file_name = "debian-12-standard_12.12-1_amd64.tar.zst"
  ssh_keys           = []
  tags               = ["managed-by-tofu", "community-script", "os"]
}

output "lxc_id" {
  description = "VMID of the LXC container"
  value       = module.ts-exit-node.id
}

output "lxc_hostname" {
  description = "Hostname of the LXC container"
  value       = module.ts-exit-node.hostname
}

output "lxc_mac_address" {
  description = "MAC address of eth0"
  value       = module.ts-exit-node.mac_address
}
