# Import with: `tofu import module.bichon.proxmox_virtual_environment_container.this pve2/204`

module "bichon" {
  source = "../../modules/lxc"

  hostname           = "bichon"
  vm_id              = 204
  cores              = 1
  memory             = 1024
  swap               = 512
  disk_size          = 16
  datastore_id       = "local-lvm"
  create_os_template = false
  template_file_name = "debian-13-standard_13.1-2_amd64.tar.zst"
  ssh_keys           = []
  tags               = ["managed-by-tofu", "community-script", "email", "archive"]
  ipv6               = "auto"
  unprivileged       = true
  keyctl             = true
  nesting            = false
}

output "lxc_id" {
  description = "VMID of the LXC container"
  value       = module.bichon.id
}

output "lxc_hostname" {
  description = "Hostname of the LXC container"
  value       = module.bichon.hostname
}

output "lxc_mac_address" {
  description = "MAC address of eth0"
  value       = module.bichon.mac_address
}
