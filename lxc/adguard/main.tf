# Import with: `tofu import module.adguard.proxmox_virtual_environment_container.this pve2/109`

module "adguard" {
  source = "../../modules/lxc"

  hostname           = "adguard"
  vm_id              = 109
  cores              = 1
  memory             = 1024
  swap               = 512
  disk_size          = 32
  datastore_id       = "local-zfs2"
  create_os_template = false
  template_file_name = "debian-12-standard_12.12-1_amd64.tar.zst"
  ssh_keys           = []
  tags               = ["managed-by-tofu", "proxmox-helper-scripts"]
}

output "lxc_id" {
  description = "VMID of the LXC container"
  value       = module.adguard.id
}

output "lxc_hostname" {
  description = "Hostname of the LXC container"
  value       = module.adguard.hostname
}

output "lxc_mac_address" {
  description = "MAC address of eth0"
  value       = module.adguard.mac_address
}
