# Terraform et Proxmox

## Explications et modifications nécessaires

### Provider Configuration:
`pm_api_url`: Remplacez <votre-serveur-proxmox> par l'adresse IP ou le nom de domaine de votre serveur Proxmox. </br>
`pm_user` et `pm_password`: Remplacez par vos identifiants de connexion Proxmox. </br>
`pm_tls_insecure`: Mettez à true si vous utilisez un certificat auto-signé. </br>

### Ressource VM:
`target_node`: Remplacez "pve" par le nom de votre nœud Proxmox. </br>
`clone`: Spécifiez le nom d'un template VM existant sur votre serveur Proxmox. </br>
`network`: Configurez le modèle de réseau et le bridge selon votre configuration réseau. </br>
`disk`: Ajustez le type, le stockage et la taille du disque selon vos besoins. </br>
`cores`, `sockets`, et `memory`: Modifiez ces valeurs pour définir le nombre de cœurs CPU, de sockets et la quantité de mémoire allouée à la VM. </br>
`os_type` et `ipconfig0`: Configurez ces options en fonction de votre système d'exploitation et de votre configuration réseau. </br>

### Étapes pour utiliser le fichier Terraform

Installer Terraform: Assurez-vous que Terraform est installé sur votre machine. </br>
Initialiser Terraform: Exécutez `terraform init` pour initialiser le projet et télécharger le fournisseur Proxmox. </br>
Appliquer la configuration: Exécutez `terraform apply` pour créer la VM. </br>

Assurez-vous d'avoir un template VM déjà configuré sur votre serveur Proxmox, car le fichier Terraform ci-dessus utilise un template pour créer la nouvelle VM. Vous pouvez créer un template à partir d'une VM existante en utilisant l'interface web de Proxmox.