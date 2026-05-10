output "id" {
  description = "VMID of the LXC container"
  value       = proxmox_virtual_environment_container.this.id
}

output "hostname" {
  description = "Hostname of the LXC container"
  value       = proxmox_virtual_environment_container.this.initialization[0].hostname
}

output "mac_address" {
  description = "MAC address of eth0 — use this to find the DHCP lease in AdGuard"
  value       = proxmox_virtual_environment_container.this.network_interface[0].mac_address
}
