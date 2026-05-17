module "patchmon" {
  source = "../../modules/lxc"

  hostname           = "patchmon"
  vm_id              = 216
  cores              = 2
  memory             = 2048
  swap               = 512
  disk_size          = 10
  datastore_id       = "local-lvm"
  create_os_template = false
  template_file_name = "debian-12-standard_12.12-1_amd64.tar.zst"
  tags               = ["community-script", "monitoring", "patchmon", "managed-by-tofu"]
  unprivileged       = true
  ipv6               = "auto"
  keyctl             = true
}

output "lxc_id" {
  description = "VMID of the LXC container"
  value       = module.patchmon.id
}

output "lxc_hostname" {
  description = "Hostname of the LXC container"
  value       = module.patchmon.hostname
}

output "lxc_mac_address" {
  description = "MAC address of eth0"
  value       = module.patchmon.mac_address
}
