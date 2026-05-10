# Import with: `tofu import module.logging.proxmox_virtual_environment_container.this pve3/206`

module "logging" {
  source = "../../modules/lxc"

  hostname           = "logging"
  node_name          = "pve3"
  vm_id              = 206
  cores              = 2
  memory             = 2048
  swap               = 512
  disk_size          = 16
  datastore_id       = "local-lvm"
  create_os_template = false
  template_file_name = "debian-12-standard_12.12-1_amd64.tar.zst"
  ssh_keys           = []
  tags               = ["managed-by-tofu", "proxmox-helper-scripts"]
}

output "lxc_id" {
  description = "VMID of the LXC container"
  value       = module.logging.id
}

output "lxc_hostname" {
  description = "Hostname of the LXC container"
  value       = module.logging.hostname
}

output "lxc_mac_address" {
  description = "MAC address of eth0"
  value       = module.logging.mac_address
}
