# debian-installer
A bash script to automate an Debian installation

# Requierement
L'outil est fait exclusivement pour Linux. Il vous faut 3 outils basics souvent installés par défaut sur les systèmes :
sudo, wget et isomkfs

# Utilisation
Vous pouvez importer vos propres images de Debian dans le dossier "debian-ori". Si vous ne le faite pas, 
le script va se charger de récupérer la dernière version de Debian sur le site officiel en netinstall.
Les images générées se trouvent dans le dossier "output".

# Implémentations à venir
- Optimisation
- Preseed :
    - Web
    - Desktop
    - Asterisk
