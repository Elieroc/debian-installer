# debian-installer
L'objectif de ce projet est de vous faciliter la vie en générant des images iso prêtes de Debian prêtes à l'emploi, c'est à dire qui vont contenir une préconfiguration particulière. Il peut s'agir de paquets supplémentaires ou d'autre configuration. En conséquent, l'installation pourra être configuré de manière automatique ou semi-automatique selon vos besoins. 

# Prérequis
L'outil est fait exclusivement pour Linux. Il vous faut 3 outils basics souvent installés par défaut sur les systèmes :
sudo, wget et isomkfs

# Utilisation
Vous pouvez importer vos propres images de Debian dans le dossier "debian-ori". Si vous ne le faite pas, 
le script va se charger de récupérer la dernière version de Debian 10 sur le site officiel en netinstall.
Les images générées se trouvent dans le dossier "output".
Attention : Debian 11 n'est pas encore compatible avec le générateur.

# Implémentations à venir
- Optimisation
- Preseed :
    - Web
    - Desktop
    - Asterisk
