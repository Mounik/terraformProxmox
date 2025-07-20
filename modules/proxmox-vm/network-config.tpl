# Template cloud-init réseau pour la VM
# Les variables sont remplacées automatiquement par Terraform
#
# - ${ip_address} : adresse IP statique de la VM
# - ${gateway}    : passerelle réseau
# - ${dns_server} : serveur DNS

version: 2
ethernets:
  eth0:
    addresses:
      - ${ip_address}/24
    gateway4: ${gateway}
    nameservers:
      addresses: [${dns_server}]
