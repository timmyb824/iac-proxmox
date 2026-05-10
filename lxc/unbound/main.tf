# Import with: `tofu import module.unbound.proxmox_virtual_environment_container.this pve3/104`

module "unbound" {
  source = "../../modules/lxc"

  hostname           = "unbound"
  node_name          = "pve3"
  vm_id              = 104
  cores              = 1
  memory             = 512
  swap               = 512
  disk_size          = 8
  datastore_id       = "local-zfs3"
  create_os_template = false
  template_file_name = "debian-12-standard_12.12-1_amd64.tar.zst"
  ssh_keys           = []
  tags               = ["managed-by-tofu", "proxmox-helper-scripts"]
  os_type            = "ubuntu"
}

output "lxc_id" {
  description = "VMID of the LXC container"
  value       = module.unbound.id
}

output "lxc_hostname" {
  description = "Hostname of the LXC container"
  value       = module.unbound.hostname
}

output "lxc_mac_address" {
  description = "MAC address of eth0"
  value       = module.unbound.mac_address
}
