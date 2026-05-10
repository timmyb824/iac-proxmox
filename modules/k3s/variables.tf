variable "node_name" {
  description = "Proxmox node to deploy on"
  type        = string
}

variable "vm_id" {
  description = "VM ID"
  type        = number
}

variable "name" {
  description = "VM name"
  type        = string
}

variable "description" {
  description = "VM description (defaults to name — managed by OpenTofu)"
  type        = string
  default     = null
}

variable "tags" {
  description = "Tags to apply to the VM"
  type        = list(string)
  default     = ["k3s", "managed-by-tofu"]
}

variable "cores" {
  description = "Number of CPU cores"
  type        = number
  default     = 3
}

variable "memory" {
  description = "Memory in MB"
  type        = number
  default     = 6144
}

variable "balloon" {
  description = "Minimum memory for ballooning in MB"
  type        = number
  default     = 5120
}

variable "storage" {
  description = "Datastore ID for disk and cloud-init"
  type        = string
}

variable "disk_size" {
  description = "Disk size in GB"
  type        = number
  default     = 96
}

variable "ip_address" {
  description = "Static IP address (without prefix length)"
  type        = string
}

variable "gateway" {
  description = "Default gateway"
  type        = string
  default     = "192.168.86.1"
}

variable "ssh_keys" {
  description = "SSH public keys to inject via cloud-init"
  type        = list(string)
  default     = []
}
