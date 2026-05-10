# Import with: `tofu import module.archivebox.proxmox_virtual_environment_container.this pve2/211`

module "archivebox" {
  source = "../../modules/lxc"

  hostname           = "archivebox"
  vm_id              = 211
  cores              = 2
  memory             = 1024
  swap               = 512
  disk_size          = 64
  datastore_id       = "local-zfs2"
  create_os_template = false
  template_file_name = "debian-12-standard_12.12-1_amd64.tar.zst"
  ssh_keys           = []
  tags               = ["managed-by-tofu", "bookmark", "archive", "community-script"]
  dns_domain         = "192.168.86.220"
  dns_servers        = ["192.168.86.220"]
}

output "lxc_id" {
  description = "VMID of the LXC container"
  value       = module.archivebox.id
}

output "lxc_hostname" {
  description = "Hostname of the LXC container"
  value       = module.archivebox.hostname
}

output "lxc_mac_address" {
  description = "MAC address of eth0"
  value       = module.archivebox.mac_address
}
