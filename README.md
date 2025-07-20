

# Déploiement modulaire de machines virtuelles Proxmox avec Terraform

Ce projet permet de déployer facilement des VM sur un cluster Proxmox en utilisant Terraform et le provider telmate/proxmox, avec une architecture modulaire et des paramètres personnalisables.

## Arborescence des dossiers

```
Terraform/
├── main.tf                # Fichier principal, déploiement des VM
├── README.md              # Documentation
└── modules/
    └── proxmox-vm/
        ├── main.tf        # Module VM paramétrable
        └── network-config.tpl # Template cloud-init réseau
```

## Fonctionnement

- Le fichier principal `main.tf` permet de déployer plusieurs VM en appelant le module `proxmox-vm` avec des paramètres différents.
- Le module gère la création de la VM, la configuration réseau, disque, CPU/mémoire et l'intégration cloud-init.
- Le template `network-config.tpl` permet de générer automatiquement la configuration réseau cloud-init pour chaque VM.

## Paramètres disponibles

Dans `modules/proxmox-vm/main.tf` :
- `vmid` : identifiant unique de la VM sur Proxmox
- `target_node` : nom du nœud Proxmox cible
- `vm_name` : nom de la VM
- `ip_address` : adresse IP statique
- `gateway` : passerelle réseau (défaut : 192.168.1.254)
- `dns_server` : serveur DNS (défaut : 8.8.8.8)
- `cores` : nombre de cœurs CPU
- `sockets` : nombre de sockets CPU
- `memory` : mémoire RAM (en Mo)
- `disk_size` : taille du disque principal (ex : "30G")

## Exemple d'utilisation dans le main.tf racine

```hcl
provider "proxmox" {
  pm_api_url      = "https://<votre-serveur-proxmox>:8006/api2/json"
  pm_user         = "root@pam"
  pm_password     = "votre-mot-de-passe"
  pm_tls_insecure = true
}

module "vm1" {
  source      = "./modules/proxmox-vm"
  target_node = "pmx01"
  vmid        = 100
  vm_name     = "vm1"
  ip_address  = "192.168.1.100"
  cores       = 2
  sockets     = 1
  memory      = 2048
  disk_size   = "30G"
}

module "vm2" {
  source      = "./modules/proxmox-vm"
  target_node = "pmx02"
  vmid        = 102
  vm_name     = "vm2"
  ip_address  = "192.168.1.102"
  cores       = 2
  sockets     = 2
  memory      = 4096
  disk_size   = "50G"
}
```

## Déploiement

1. Modifiez les variables dans le module ou dans votre appel de module selon votre environnement (nœud, IP, ressources, etc).
2. Initialisez Terraform :
   ```bash
   terraform init
   ```
3. Vérifiez le plan de déploiement :
   ```bash
   terraform plan
   ```
4. Appliquez la configuration :
   ```bash
   terraform apply
   ```

## Notes et bonnes pratiques
- Le template cloud-init réseau est généré dans le dossier snippets du serveur Proxmox (`/mnt/SSD/snippets/`).
- Adaptez les chemins, le nom du template VM (`clone`), le stockage et le bridge réseau selon votre infrastructure.
- Un template VM doit exister sur Proxmox pour le clonage (ex : "UbuntuServer").
- Les paramètres sont commentés dans chaque fichier pour faciliter la personnalisation.

## Références
- [Provider Telmate/Proxmox](https://registry.terraform.io/providers/Telmate/proxmox/latest/docs)
- [Documentation Proxmox](https://pve.proxmox.com/wiki/Main_Page)
  eth0:
    addresses:
      - 192.168.1.100/24
    gateway4: 192.168.1.1
    nameservers:
      addresses: [8.8.8.8, 8.8.4.4]
```

## Références
- [Provider Telmate/Proxmox](https://registry.terraform.io/providers/Telmate/proxmox/latest/docs)
- [Documentation Proxmox](https://pve.proxmox.com/wiki/Main_Page)