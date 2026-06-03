data "proxmox_file" "os_template" {
  count        = var.create_os_template ? 0 : 1
  content_type = "vztmpl"
  datastore_id = "local"
  node_name    = var.node_name
  file_name    = var.template_file_name
}

resource "proxmox_download_file" "os_template" {
  count        = var.create_os_template ? 1 : 0
  content_type = "vztmpl"
  datastore_id = var.template_datastore_id
  node_name    = var.node_name
  url          = var.template_url
}

resource "proxmox_virtual_environment_container" "this" {
  node_name    = var.node_name
  description  = var.description != null ? var.description : "${var.hostname} — managed by OpenTofu"
  tags         = var.tags
  vm_id        = var.vm_id
  unprivileged = var.unprivileged

  #  operating_system {
  #    template_file_id = proxmox_download_file.os_template.id
  #    type             = var.os_type
  #  }

  operating_system {
    template_file_id = var.create_os_template ? proxmox_download_file.os_template[0].id : data.proxmox_file.os_template[0].id
    type             = var.os_type
  }

  initialization {
    hostname = var.hostname

    dynamic "dns" {
      for_each = var.dns_domain != null || length(var.dns_servers) > 0 ? [1] : []
      content {
        domain  = var.dns_domain
        servers = var.dns_servers
      }
    }

    ip_config {
      ipv4 {
        address = "dhcp"
      }
      dynamic "ipv6" {
        for_each = var.ipv6 != null ? [1] : []
        content {
          address = var.ipv6
        }
      }
    }

    #    user_account {
    #      keys = var.ssh_keys
    #    }
    dynamic "user_account" {
      for_each = length(var.ssh_keys) > 0 ? [1] : []
      content {
        keys = var.ssh_keys
      }
    }
  }

  cpu {
    cores        = var.cores
    architecture = var.cpu_architecture
    limit        = var.cpu_limit
  }

  memory {
    dedicated = var.memory
    swap      = var.swap
  }

  disk {
    datastore_id = var.datastore_id
    size         = var.disk_size
  }

  network_interface {
    name   = "eth0"
    bridge = var.bridge
  }

  dynamic "mount_point" {
    for_each = var.mount_points
    content {
      volume = mount_point.value.volume
      path   = mount_point.value.path
    }
  }

  features {
    nesting = var.nesting
    mount   = var.nfs_mount ? ["nfs"] : []
    keyctl  = var.keyctl
  }

  lifecycle {
    ignore_changes = [
      operating_system[0].template_file_id,
      vm_id,
    ]
  }

  start_on_boot = var.start_on_boot
  started       = var.started
}
