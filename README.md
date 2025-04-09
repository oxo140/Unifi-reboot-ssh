Utilisation :

Lancez le script avec :
```
./reboot-unifi.sh
```

Le script effectue les actions suivantes :

Vérifie si sshpass est installé et l'installe si besoin.

Parcourt la plage IP définie dans le script (172.16.200.1 à 172.16.200.254 par défaut).

Ping chaque adresse IP pour vérifier la connectivité.

Si la borne est accessible, exécute la commande de redémarrage via SSH.

Vide le fichier ~/.ssh/known_hosts à la fin pour éviter les conflits de fingerprint lors d'une prochaine exécution.

Configuration :

Par défaut, les paramètres sont définis dans le script :
```
start_ip="172.16.200.1"
end_ip="172.16.200.254"
username="admin"
password="password"
```
Modifiez ces variables dans le script pour les adapter à votre environnement.

Notes :

Ce script est conçu pour les bornes UniFi.
L'utilisateur utilisé (admin par défaut) doit disposer des droits suffisants pour exécuter la commande /sbin/reboot.
Le fichier known_hosts est vidé à la fin pour éviter les avertissements SSH lors d'exécutions répétées.
