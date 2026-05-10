# Import with: `tofu import module.unbound-secondary.proxmox_virtual_environment_container.this pve2/210`

module "unbound-secondary" {
  source = "../../modules/lxc"

  hostname           = "unbound-secondary"
  vm_id              = 210
  cores              = 1
  memory             = 512
  swap               = 512
  disk_size          = 8
  datastore_id       = "local-zfs2"
  create_os_template = false
  template_file_name = "debian-12-standard_12.12-1_amd64.tar.zst"
  ssh_keys           = []
  tags               = ["managed-by-tofu", "proxmox-helper-scripts"]
  os_type            = "ubuntu"
}

output "lxc_id" {
  description = "VMID of the LXC container"
  value       = module.unbound-secondary.id
}

output "lxc_hostname" {
  description = "Hostname of the LXC container"
  value       = module.unbound-secondary.hostname
}

output "lxc_mac_address" {
  description = "MAC address of eth0"
  value       = module.unbound-secondary.mac_address
}
