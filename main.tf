# =================================
# Configuration du provider Proxmox
# =================================

provider "proxmox" {
  pm_api_url      = "https://<votre-serveur-proxmox>:8006/api2/json" # Adresse de l'API Proxmox (à adapter)
  pm_user         = "root@pam"                                       # Utilisateur Proxmox
  pm_password     = "votre-mot-de-passe"                            # Mot de passe Proxmox
  pm_tls_insecure = true                                             # Désactiver la vérification TLS si auto-signé
}

# =========================
# Déploiement de la VM n°1
# =========================

module "vm1" {
  source      = "./modules/proxmox-vm"           # Chemin du module VM
  target_node = "pmx01"                          # Nom du nœud Proxmox cible
  vmid        = 100                               # ID unique de la VM sur Proxmox
  vm_name     = "vm1"                            # Nom de la VM
  ip_address  = "192.168.1.100"                  # Adresse IP statique de la VM
  cores       = 2                                 # Nombre de cœurs CPU
  sockets     = 1                                 # Nombre de sockets CPU
  memory      = 2048                              # Mémoire RAM (en Mo)
  disk_size   = "30G"                            # Taille du disque principal
}

# =========================
# Déploiement de la VM n°2
# =========================

module "vm2" {
  source      = "./modules/proxmox-vm"           # Chemin du module VM
  target_node = "pmx02"                          # Nom du nœud Proxmox cible
  vmid        = 102                               # ID unique de la VM sur Proxmox
  vm_name     = "vm2"                            # Nom de la VM
  ip_address  = "192.168.1.102"                  # Adresse IP statique de la VM
  cores       = 2                                 # Nombre de cœurs CPU
  sockets     = 2                                 # Nombre de sockets CPU
  memory      = 4096                              # Mémoire RAM (en Mo)
  disk_size   = "50G"                            # Taille du disque principal
}

