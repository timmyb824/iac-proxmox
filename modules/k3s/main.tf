resource "proxmox_virtual_environment_vm" "this" {
  node_name   = var.node_name
  vm_id       = var.vm_id
  name        = var.name
  description = var.description != null ? var.description : "${var.name} — managed by OpenTofu"
  tags        = var.tags
  on_boot     = true

  cpu {
    cores   = var.cores
    sockets = 1
    type    = "host"
  }

  memory {
    dedicated = var.memory
    floating  = var.balloon
  }

  disk {
    datastore_id = var.storage
    interface    = "scsi0"
    iothread     = true
    size         = var.disk_size
  }

  network_device {
    bridge = "vmbr0"
    model  = "virtio"
  }

  initialization {
    datastore_id = var.storage

    ip_config {
      ipv4 {
        address = "${var.ip_address}/24"
        gateway = var.gateway
      }
    }

    user_account {
      keys = var.ssh_keys
    }
  }

  agent {
    enabled = true
  }

  bios    = "seabios"
  machine = "pc"

  serial_device {}

  vga {
    type = "serial0"
  }

  operating_system {
    type = "l26"
  }

  # lifecycle {
  #   ignore_changes = [
  #     disk[0].file_id,
  #     initialization[0].datastore_id,
  #     vm_id,
  #   ]
  #   prevent_destroy = true
  # }

  # lifecycle {
  #   ignore_changes = [
  #     disk[0].file_id,
  #     disk[0].iothread,
  #     initialization[0].datastore_id,
  #     vm_id,
  #     vga,
  #     machine,
  #     operating_system,
  #     keyboard_layout,
  #     agent[0].type,
  #     description,
  #     tags,
  #   ]
  #   prevent_destroy = true
  # }

  lifecycle {
    ignore_changes = [
      disk,
      cpu,
      memory,
      vga,
      machine,
      operating_system,
      keyboard_layout,
      agent,
      initialization,
      vm_id,
    ]
    prevent_destroy = true
  }
}
