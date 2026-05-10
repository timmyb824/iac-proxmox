# Import with: `tofu import module.meilisearch.proxmox_virtual_environment_container.this pve2/213`

module "meilisearch" {
  source = "../../modules/lxc"

  hostname           = "meilisearch"
  vm_id              = 213
  cores              = 2
  memory             = 4096
  swap               = 512
  disk_size          = 10
  datastore_id       = "local-lvm"
  create_os_template = false
  template_file_name = "debian-12-standard_12.12-1_amd64.tar.zst"
  ssh_keys           = []
  tags               = ["managed-by-tofu", "community-script", "full-text-search"]
  ipv6               = "auto"
}

output "lxc_id" {
  description = "VMID of the LXC container"
  value       = module.meilisearch.id
}

output "lxc_hostname" {
  description = "Hostname of the LXC container"
  value       = module.meilisearch.hostname
}

output "lxc_mac_address" {
  description = "MAC address of eth0"
  value       = module.meilisearch.mac_address
}
