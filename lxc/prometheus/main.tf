module "prometheus" {
  source = "../../modules/lxc"

  hostname           = "prometheus"
  vm_id              = 203
  cores              = 1
  memory             = 3072
  swap               = 1024
  disk_size          = 20
  datastore_id       = "local-lvm"
  create_os_template = false
  template_file_name = "debian-12-standard_12.12-1_amd64.tar.zst"
  ssh_keys           = []
  tags               = ["managed-by-tofu", "proxmox-helper-scripts"]
  unprivileged       = true
  keyctl             = true
}

output "lxc_id" {
  description = "VMID of the LXC container"
  value       = module.prometheus.id
}

output "lxc_hostname" {
  description = "Hostname of the LXC container"
  value       = module.prometheus.hostname
}

output "lxc_mac_address" {
  description = "MAC address of eth0"
  value       = module.prometheus.mac_address
}
