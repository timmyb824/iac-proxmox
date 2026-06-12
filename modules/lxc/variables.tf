variable "hostname" {
  description = "Hostname for the LXC container"
  type        = string
}

variable "vm_id" {
  description = "VMID for the LXC container (null = auto-assign by Proxmox)"
  type        = number
  default     = null
}

variable "node_name" {
  description = "Proxmox node to create the container on"
  type        = string
  default     = "pve2"
}

variable "description" {
  description = "Container description (defaults to '<hostname> — managed by OpenTofu')"
  type        = string
  default     = null
}

variable "cores" {
  description = "Number of CPU cores"
  type        = number
  default     = 2
}

variable "cpu_architecture" {
  description = "CPU architecture (e.g. 'amd64', 'arm64')"
  type        = string
  default     = "amd64"
}

variable "cpu_limit" {
  description = "CPU limit as a percentage (e.g. 200 for 2 cores)"
  type        = number
  default     = 0
}

variable "memory" {
  description = "Memory in MB"
  type        = number
  default     = 1024
}

variable "swap" {
  description = "Swap in MB"
  type        = number
  default     = 0
}

variable "disk_size" {
  description = "Root disk size in GB"
  type        = number
  default     = 8
}

variable "datastore_id" {
  description = "Datastore for the root disk"
  type        = string
  default     = "local-lvm"
}

variable "tags" {
  description = "Tags to apply to the container"
  type        = list(string)
  default     = []
}

variable "unprivileged" {
  description = "Run as unprivileged container"
  type        = bool
  default     = false
}

variable "start_on_boot" {
  description = "Start container on Proxmox host boot"
  type        = bool
  default     = true
}

variable "started" {
  description = "Start the container after creation"
  type        = bool
  default     = true
}

variable "bridge" {
  description = "Network bridge for eth0"
  type        = string
  default     = "vmbr0"
}

variable "ssh_keys" {
  description = "SSH public keys to inject into the container"
  type        = list(string)
  default     = []
}

variable "mount_points" {
  description = "Bind mount points: { volume = host_path, path = container_path }"
  type = list(object({
    volume = string
    path   = string
  }))
  default = []
}

variable "nesting" {
  description = "Enable nesting feature (required for helper-script installs)"
  type        = bool
  default     = true
}

variable "nfs_mount" {
  description = "Enable NFS mount feature (required when mounting NFS shares into the container)"
  type        = bool
  default     = false
}

variable "template_url" {
  description = "URL for the OS template to download"
  type        = string
  default     = "http://download.proxmox.com/images/system/debian-12-standard_12.12-1_amd64.tar.zst"
}

variable "template_file_name" {
  description = "Filename of existing template in datastore (used when create_os_template = false)"
  type        = string
  default     = "debian-12-standard_12.12-1_amd64.tar.zst"
}

variable "template_datastore_id" {
  description = "Datastore to store the downloaded template"
  type        = string
  default     = "local"
}

variable "create_os_template" {
  description = "Create an OS template from the container"
  type        = bool
  default     = true
}

variable "os_type" {
  description = "OS type for the container"
  type        = string
  default     = "debian"
}

variable "ipv6" {
  description = "IPv6 address config, e.g. 'auto' or 'dhcp'"
  type        = string
  default     = null
}

variable "dns_domain" {
  description = "DNS domain for the container"
  type        = string
  default     = null
}

variable "dns_servers" {
  description = "DNS servers for the container"
  type        = list(string)
  default     = []
}

variable "keyctl" {
  description = "Enable keyctl feature"
  type        = bool
  default     = false
}

variable "fuse" {
  description = "Enable FUSE support"
  type        = bool
  default     = false
}

variable "protection" {
  description = "Protection status of the container (locked or unlocked)"
  type        = string
  default     = false
}
