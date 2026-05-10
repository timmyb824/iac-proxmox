module "openfang" {
  source = "../../modules/lxc"

  hostname           = "openfang"
  vm_id              = 102
  cores              = 1
  memory             = 1024
  swap               = 512
  disk_size          = 32
  datastore_id       = "local-zfs2"
  create_os_template = false
  template_file_name = "debian-12-standard_12.12-1_amd64.tar.zst"
  ssh_keys           = []
  tags               = ["community-script", "os", "managed-by-tofu"]
}

output "lxc_id" {
  description = "VMID of the LXC container"
  value       = module.openfang.id
}

output "lxc_hostname" {
  description = "Hostname of the LXC container"
  value       = module.openfang.hostname
}

output "lxc_mac_address" {
  description = "MAC address of eth0"
  value       = module.openfang.mac_address
}
