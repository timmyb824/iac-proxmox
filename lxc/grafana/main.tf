module "grafana" {
  source = "../../modules/lxc"

  hostname           = "grafana"
  vm_id              = 201
  cores              = 1
  memory             = 1024
  swap               = 1024
  disk_size          = 10
  datastore_id       = "local-lvm"
  create_os_template = false
  template_file_name = "debian-12-standard_12.12-1_amd64.tar.zst"
  ssh_keys           = []
  tags               = ["managed-by-tofu", "community-script", "monitoring", "visualization"]
  ipv6               = "auto"
}

output "lxc_id" {
  description = "VMID of the LXC container"
  value       = module.grafana.id
}

output "lxc_hostname" {
  description = "Hostname of the LXC container"
  value       = module.grafana.hostname
}

output "lxc_mac_address" {
  description = "MAC address of eth0"
  value       = module.grafana.mac_address
}
