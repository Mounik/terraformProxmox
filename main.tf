terraform {
  required_providers {
    proxmox = {
      source = "telmate/proxmox"
      version = "2.9.11"
    }
  }
}

provider "proxmox" {
  pm_api_url = "https://192.168.1.100:8006/api2/json"
  pm_user = "root@pam"
  pm_password = "2Ksable$"
  pm_tls_insecure = true
}

resource "proxmox_vm_qemu" "UbuntuVM" {
  name = "UbuntuVM"
  target_node = "pmx01" # Le nom de votre nœud Proxmox

  clone = "UbuntuServer" # Le nom d'un template VM existant

  # Configuration réseau
  network {
    model = "virtio"
    bridge = "vmbr0"
  }

  # Configuration du disque
  disk {
    type = "scsi"
    storage = "local-lvm"
    size = "20G"
  }

  # Configuration CPU et mémoire
  cores = 2
  sockets = 1
  memory = 2048

  # Configuration de l'OS
  os_type = "cloud-init"
  ipconfig0 = "ip=dhcp"
}
