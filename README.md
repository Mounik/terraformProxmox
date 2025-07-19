# Terraform et Proxmox

## Explications et modifications nécessaires

### Provider Configuration:
pm_api_url: Remplacez <votre-serveur-proxmox> par l'adresse IP ou le nom de domaine de votre serveur Proxmox. \n
pm_user et pm_password: Remplacez par vos identifiants de connexion Proxmox.
pm_tls_insecure: Mettez à true si vous utilisez un certificat auto-signé.

### Ressource VM:
target_node: Remplacez "pve" par le nom de votre nœud Proxmox.
clone: Spécifiez le nom d'un template VM existant sur votre serveur Proxmox.
network: Configurez le modèle de réseau et le bridge selon votre configuration réseau.
disk: Ajustez le type, le stockage et la taille du disque selon vos besoins.
cores, sockets, et memory: Modifiez ces valeurs pour définir le nombre de cœurs CPU, de sockets et la quantité de mémoire allouée à la VM.
os_type et ipconfig0: Configurez ces options en fonction de votre système d'exploitation et de votre configuration réseau.

### Étapes pour utiliser le fichier Terraform

Installer Terraform: Assurez-vous que Terraform est installé sur votre machine.
Initialiser Terraform: Exécutez terraform init pour initialiser le projet et télécharger le fournisseur Proxmox.
Appliquer la configuration: Exécutez terraform apply pour créer la VM.

Assurez-vous d'avoir un template VM déjà configuré sur votre serveur Proxmox, car le fichier Terraform ci-dessus utilise un template pour créer la nouvelle VM. Vous pouvez créer un template à partir d'une VM existante en utilisant l'interface web de Proxmox.