module "k3s_3_worker" {
  source            = "../../modules/vm"
  clone_vm_id       = 3000
  clone_node_name   = "pve3"
  node_name         = "pve3"
  vm_id             = 606
  name              = "k3s-3-worker"
  storage           = "local-lvm"
  cloudinit_storage = "local-lvm"
  ip_address        = "192.168.86.193"
  memory            = 7168
#  balloon           = 5120
  cores             = 3
  os_type           = "other"
  disk_interface    = "scsi0"
  disk_size         = 64
  tags              = ["k3s", "worker", "managed-by-tofu"]

  ssh_keys = [
    "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIG2iB7F01dMALwcGHFY9+140neloiAfJ1j5jlBOe+FF1 master-key",
    "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAINSzbKSzp5tG3vytJiWHlBUV9f1cmqzIWY3CH9Je+tI0 master-key-nopass",
  ]
}
