# ============================
# Variables d'entrée du module
# ============================

variable "vmid" {
  description = "Identifiant unique de la VM sur Proxmox (doit être différent pour chaque VM déployée)"
  type        = number
}

variable "target_node" {
  description = "Nom du nœud Proxmox sur lequel la VM sera créée (ex: pmx01, pmx02)"
  type        = string
}

variable "vm_name" {
  description = "Nom de la machine virtuelle (affiché dans Proxmox)"
}

variable "ip_address" {
  description = "Adresse IP statique attribuée à la VM (ex: 192.168.1.100)"
}

variable "gateway" {
  description = "Adresse de la passerelle réseau (ex: 192.168.1.254)"
  type        = string
  default     = "192.168.1.254"
}

variable "dns_server" {
  description = "Serveur DNS utilisé par la VM (ex: 8.8.8.8)"
  type        = string
  default     = "8.8.8.8"
}

variable "cores" {
  description = "Nombre de cœurs CPU alloués à la VM"
  type        = number
}

variable "sockets" {
  description = "Nombre de sockets CPU alloués à la VM"
  type        = number
}

variable "memory" {
  description = "Quantité de mémoire RAM (en Mo) allouée à la VM"
  type        = number
}

variable "disk_size" {
  description = "Taille du disque principal (ex: '30G', '50G')"
  type        = string
}

# ========================================================
# Génération du fichier de configuration réseau cloud-init
# ========================================================

data "template_file" "network_config" {
  template = file("${path.module}/network-config.tpl") # Utilise le template réseau cloud-init
  vars = {
    ip_address = var.ip_address
    gateway    = var.gateway
    dns_server = var.dns_server
  }
}

resource "local_file" "custom_network_config" {
  content  = data.template_file.network_config.rendered # Génère le contenu YAML pour cloud-init
  filename = "/mnt/SSD/snippets/${var.vm_name}-network-config.yml" # Chemin du fichier sur le serveur Proxmox
}

# =============================================
# Déploiement de la VM avec le provider Proxmox
# =============================================

resource "proxmox_vm_qemu" "vm" {
  vmid        = var.vmid         # ID unique de la VM
  name        = var.vm_name      # Nom de la VM
  target_node = var.target_node  # Nœud Proxmox cible

  clone       = "UbuntuServer"   # Nom du template VM à cloner (à adapter selon votre infra)

  network {
    model  = "virtio"           # Modèle de carte réseau (virtio recommandé)
    bridge = "vmbr0"            # Bridge réseau utilisé (à adapter si besoin)
  }

  disk {
    type    = "scsi"            # Type de disque (SCSI recommandé pour performances)
    storage = "SSD100"           # Nom du stockage Proxmox (à adapter selon votre infra)
    size    = var.disk_size       # Taille du disque principal
  }

  cores   = var.cores            # Nombre de cœurs CPU
  sockets = var.sockets          # Nombre de sockets CPU
  memory  = var.memory           # Mémoire RAM (en Mo)

  os_type  = "cloud-init"        # Active cloud-init pour la VM
  cicustom = "user=local:/mnt/SSD/snippets/${var.vm_name}-network-config.yml" # Fichier custom cloud-init généré
}
