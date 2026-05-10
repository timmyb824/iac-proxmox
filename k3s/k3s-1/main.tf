module "k3s_1" {
  source = "../../modules/k3s"

  node_name  = "pve4"
  vm_id      = 501
  name       = "k3s-1"
  storage    = "local-zfs4"
  ip_address = "192.168.86.185"
  memory     = 6144
  balloon    = 5120
  tags       = ["k3s", "control-plane", "managed-by-tofu"]

  ssh_keys = [
    "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIG2iB7F01dMALwcGHFY9+140neloiAfJ1j5jlBOe+FF1 master-key",
  ]
}
