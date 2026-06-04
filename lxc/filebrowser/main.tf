module "filebrowser" {
  source = "../../modules/lxc"

  hostname           = "filebrowser"
  description        = "filebrowser — managed by OpenTofu -- To update re-run the install script"
  vm_id              = 215
  cores              = 2
  memory             = 1024
  disk_size          = 8
  create_os_template = false
  template_file_name = "debian-12-standard_12.12-1_amd64.tar.zst"
  tags               = ["filebrowser", "managed-by-tofu"]

  mount_points = [
    { volume = "/mnt/nas/filebrowser", path = "/mnt/files" },
  ]
  nfs_mount = true
}

output "lxc_id" {
  description = "VMID of the LXC container"
  value       = module.filebrowser.id
}

output "lxc_hostname" {
  description = "Hostname of the LXC container"
  value       = module.filebrowser.hostname
}

output "lxc_mac_address" {
  description = "MAC address of eth0"
  value       = module.filebrowser.mac_address
}
