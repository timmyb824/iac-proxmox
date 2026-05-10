output "vm_id" {
  description = "The VM ID"
  value       = proxmox_virtual_environment_vm.this.vm_id
}

output "vm_name" {
  description = "The VM name"
  value       = proxmox_virtual_environment_vm.this.name
}

output "ip_address" {
  description = "The static IP address of the VM"
  value       = var.ip_address
}
