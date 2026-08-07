module "k3s_0_worker" {
  source = "../../modules/k3s"

  node_name  = "pve4"
  vm_id      = 503
  name       = "k3s-0-worker"
  storage    = "local-lvm"
  ip_address = "192.168.86.190"
  memory     = 7168
  balloon    = 5120
  tags       = ["k3s", "worker", "managed-by-tofu"]

  ssh_keys = [
    "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIG2iB7F01dMALwcGHFY9+140neloiAfJ1j5jlBOe+FF1 master-key",
  ]
}
