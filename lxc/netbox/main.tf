module "netbox" {
  source = "../../modules/lxc"

  hostname           = "netbox"
  vm_id              = 112
  cores              = 2
  memory             = 2048
  swap               = 512
  disk_size          = 8
  datastore_id       = "local-zfs2"
  create_os_template = false
  template_file_name = "debian-12-standard_12.12-1_amd64.tar.zst"
  ssh_keys           = []
  tags               = ["community-script", "os", "managed-by-tofu"]
  ipv6               = "auto"
}

output "lxc_id" {
  description = "VMID of the LXC container"
  value       = module.netbox.id
}

output "lxc_hostname" {
  description = "Hostname of the LXC container"
  value       = module.netbox.hostname
}

output "lxc_mac_address" {
  description = "MAC address of eth0"
  value       = module.netbox.mac_address
}
