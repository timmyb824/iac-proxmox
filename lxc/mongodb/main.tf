module "mongodb" {
  source = "../../modules/lxc"

  hostname           = "mongodb"
  vm_id              = 200
  cores              = 1
  memory             = 1024
  swap               = 512
  disk_size          = 10
  datastore_id       = "local-lvm"
  create_os_template = false
  template_file_name = "debian-12-standard_12.12-1_amd64.tar.zst"
  ssh_keys           = []
  tags               = ["proxmox-helper-scripts", "managed-by-tofu"]
}

output "lxc_id" {
  description = "VMID of the LXC container"
  value       = module.mongodb.id
}

output "lxc_hostname" {
  description = "Hostname of the LXC container"
  value       = module.mongodb.hostname
}

output "lxc_mac_address" {
  description = "MAC address of eth0"
  value       = module.mongodb.mac_address
}
