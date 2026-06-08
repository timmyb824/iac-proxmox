resource "proxmox_virtual_environment_vm" "ollama" {
  node_name  = "pve5"
  vm_id      = 700
  name       = "ollama"
  tags       = ["ai", "ollama", "managed-by-tofu"]
  on_boot    = true
  boot_order = ["virtio0"]

  machine = "q35"

  bios = "ovmf"

  efi_disk {
    datastore_id = "local-lvm"
    file_format  = "raw"
    type         = "4m"
  }

  cpu {
    cores   = 8
    sockets = 1
    type    = "host"
  }

  memory {
    dedicated = 20480
  }

  disk {
    datastore_id = "local-lvm"
    interface    = "virtio0"
    size         = 100
  }

  network_device {
    bridge = "vmbr0"
    model  = "virtio"
  }

  hostpci {
    device = "hostpci0"
    id     = "0000:01:00"
    pcie   = true
    rombar = true
    xvga   = false
  }

  operating_system {
    type = "l26"
  }

  agent {
    enabled = true
  }

  lifecycle {
    prevent_destroy = true
  }
}
