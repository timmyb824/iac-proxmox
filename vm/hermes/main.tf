module "hermes" {
  source            = "../../modules/vm"
  clone_vm_id       = 9000
  node_name         = "pve2"
  vm_id             = 301
  name              = "hermes"
  storage           = "local-lvm"
  cloudinit_storage = "local-lvm"
  disk_interface    = "scsi0"
  disk_size         = 40
  ip_address        = "192.168.86.108"
  memory            = 4096
  cores             = 2
  os_type           = "l26"
  tags              = ["managed-by-tofu"]

  ssh_keys = [
    "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIG2iB7F01dMALwcGHFY9+140neloiAfJ1j5jlBOe+FF1 master-key",
    "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAINSzbKSzp5tG3vytJiWHlBUV9f1cmqzIWY3CH9Je+tI0 master-key-nopass",
  ]
}
