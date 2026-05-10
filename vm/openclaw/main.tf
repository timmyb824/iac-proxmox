module "openclaw" {
  source = "../../modules/vm"

  node_name         = "pve3"
  vm_id             = 300
  name              = "openclaw"
  storage           = "local-zfs3"
  cloudinit_storage = "local-zfs3"
  disk_interface    = "virtio0"
  disk_size         = 64
  ip_address        = "192.168.86.93"
  memory            = 4096
  cores             = 2
  os_type           = "other"
  tags              = ["managed-by-tofu"]
  ssh_keys          = []
}
