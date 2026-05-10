resource "proxmox_virtual_environment_vm" "this" {
  node_name   = var.node_name
  vm_id       = var.vm_id
  name        = var.name
  description = var.description != null ? var.description : "${var.name} — managed by OpenTofu"
  tags        = var.tags
  on_boot     = true

  dynamic "clone" {
    for_each = var.clone_vm_id != null ? [1] : []
    content {
      vm_id     = var.clone_vm_id
      node_name = var.clone_node_name
      full      = true
    }
  }

  cpu {
    cores   = var.cores
    sockets = 1
    type    = "host"
  }

  memory {
    dedicated = var.memory
  }

  disk {
    datastore_id = var.storage
    interface    = var.disk_interface
    size         = var.disk_size
    file_id      = var.cloud_image_id
  }

  network_device {
    bridge = "vmbr0"
    model  = "virtio"
  }

  initialization {
    datastore_id = var.cloudinit_storage

    ip_config {
      ipv4 {
        address = "${var.ip_address}/24"
        gateway = var.gateway
      }
    }

    dynamic "user_account" {
      for_each = length(var.ssh_keys) > 0 ? [1] : []
      content {
        keys = var.ssh_keys
      }
    }
  }

  agent {
    enabled = true
  }

  operating_system {
    type = var.os_type
  }

  lifecycle {
    ignore_changes = [
      disk[0].file_id,
      initialization[0].datastore_id,
      vm_id,
    ]
    prevent_destroy = true
    # To destroy a VM: comment this out, apply in ALL vm directories, destroy, then restore
  }
}
