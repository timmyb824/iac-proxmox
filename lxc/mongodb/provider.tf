provider "proxmox" {
  endpoint = "https://pve.local.timmybtech.com"
  username = var.proxmox_username
  password = var.proxmox_password
  insecure = false
}
