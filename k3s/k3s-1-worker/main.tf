module "k3s_1_worker" {
  source = "../../modules/k3s"

  node_name  = "pve3"
  vm_id      = 504
  name       = "k3s-1-worker"
  storage    = "local-lvm"
  ip_address = "192.168.86.191"
  memory     = 7168
  balloon    = 5120
  tags       = ["k3s", "worker", "managed-by-tofu"]

  ssh_keys = [
    "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIG2iB7F01dMALwcGHFY9+140neloiAfJ1j5jlBOe+FF1 master-key",
  ]
}
