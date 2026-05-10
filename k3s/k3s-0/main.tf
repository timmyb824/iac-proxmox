module "k3s_0" {
  source = "../../modules/k3s"

  node_name  = "pve4"
  vm_id      = 500
  name       = "k3s-0"
  storage    = "local-zfs4"
  ip_address = "192.168.86.180"
  memory     = 6144
  balloon    = 5120
  tags       = ["k3s", "control-plane", "managed-by-tofu"]

  ssh_keys = [
    "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIG2iB7F01dMALwcGHFY9+140neloiAfJ1j5jlBOe+FF1 master-key",
  ]
}
