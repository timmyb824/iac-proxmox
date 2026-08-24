# Import with: `tofu import module.pbs.proxmox_virtual_environment_container.this pve4/101`

module "pbs" {
  source = "../../modules/lxc"

  node_name          = "pve4"
  hostname           = "proxmox-backup-server"
  vm_id              = 101
  cores              = 2
  memory             = 2048
  swap               = 512
  disk_size          = 32
  datastore_id       = "local-lvm"
  create_os_template = false
  template_file_name = "debian-12-standard_12.12-1_amd64.tar.zst"
  ssh_keys           = []
  protection         = true
  tags               = ["backup", "community-script", "managed-by-tofu"]
  fuse               = true
  nfs_mount          = true
  ipv6               = "auto"

  mount_points = [
    { volume = "/mnt/nas/pbs_datastore", path = "/mnt/pbs_datastore" },
  ]

}

output "lxc_id" {
  description = "VMID of the LXC container"
  value       = module.pbs.id
}

output "lxc_hostname" {
  description = "Hostname of the LXC container"
  value       = module.pbs.hostname
}

output "lxc_mac_address" {
  description = "MAC address of eth0"
  value       = module.pbs.mac_address
}
