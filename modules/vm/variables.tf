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
  description = "VM description"
  type        = string
  default     = null
}

variable "tags" {
  description = "Tags to apply to the VM"
  type        = list(string)
  default     = ["managed-by-tofu"]
}

variable "cores" {
  description = "Number of CPU cores"
  type        = number
  default     = 2
}

variable "memory" {
  description = "Memory in MB"
  type        = number
}

variable "storage" {
  description = "Datastore ID for primary disk"
  type        = string
}

variable "cloudinit_storage" {
  description = "Datastore ID for cloud-init drive (may differ from primary disk)"
  type        = string
}

variable "disk_interface" {
  description = "Disk interface type (scsi0, virtio0, etc)"
  type        = string
  default     = "virtio0"
}

variable "disk_size" {
  description = "Disk size in GB"
  type        = number
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

variable "os_type" {
  description = "OS type (l26 for Linux, other, etc)"
  type        = string
  default     = "other"
}

variable "cloud_image_id" {
  description = "File ID of the cloud image to use as the base disk (e.g. from proxmox_download_file). Null for imported VMs."
  type        = string
  default     = null
}

variable "clone_vm_id" {
  description = "VMID of the template to clone from. Null for imported VMs."
  type        = number
  default     = null
}

variable "clone_node_name" {
  description = "Node where the template lives"
  type        = string
  default     = "pve2"
}
