# Import with: `tofu import module.CHANGEME.proxmox_virtual_environment_container.this pve2/IDME`

module "CHANGEME" {
  source = "../../modules/lxc"

  hostname           = "CHANGEME"
  vm_id              = IDME
  cores              = 1
  memory             = 512
  swap               = 512
  disk_size          = 16
  datastore_id       = "local-zfs2"
  create_os_template = false
  template_file_name = "debian-12-standard_12.12-1_amd64.tar.zst"
  ssh_keys           = []
  tags               = ["managed-by-tofu"]
  ipv6               = "auto"
}

output "lxc_id" {
  description = "VMID of the LXC container"
  value       = module.CHANGEME.id
}

output "lxc_hostname" {
  description = "Hostname of the LXC container"
  value       = module.CHANGEME.hostname
}

output "lxc_mac_address" {
  description = "MAC address of eth0"
  value       = module.CHANGEME.mac_address
}
