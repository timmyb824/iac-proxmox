# Import with: `tofu import module.redis.proxmox_virtual_environment_container.this pve2/214`

module "redis" {
  source = "../../modules/lxc"

  hostname           = "redis"
  vm_id              = 214
  cores              = 1
  memory             = 1024
  swap               = 512
  disk_size          = 8
  datastore_id       = "local-lvm"
  create_os_template = false
  template_file_name = "debian-12-standard_12.12-1_amd64.tar.zst"
  ssh_keys           = []
  tags               = ["managed-by-tofu", "community-script", "database"]
  keyctl             = true
  unprivileged       = true
}

output "lxc_id" {
  description = "VMID of the LXC container"
  value       = module.redis.id
}

output "lxc_hostname" {
  description = "Hostname of the LXC container"
  value       = module.redis.hostname
}

output "lxc_mac_address" {
  description = "MAC address of eth0"
  value       = module.redis.mac_address
}
