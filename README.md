---

# Script de Redémarrage Automatique des Bornes UniFi

Ce script PowerShell permet d'automatiser le redémarrage des bornes Wi-Fi UniFi via SSH. Il est particulièrement utile pour maintenir la stabilité du réseau en cas de dysfonctionnements ponctuels ou de problèmes de performances.

## Fonctionnalités  
- Connexion SSH automatique avec identifiants préconfigurés.  
- Exécution de la commande `reboot` sur chaque borne identifiée.  
- Gestion de plusieurs adresses IP pour couvrir l'ensemble de votre infrastructure.  

## Prérequis  
- PowerShell 7 ou version ultérieure.  
- Accès SSH activé sur les bornes UniFi.  
- Identifiants administrateur valides pour l'accès SSH.  

## Utilisation  
1. Clonez ce dépôt :  
   ```bash
   git clone https://github.com/oxo140/Unifi-reboot-ssh/blob/main/reboot%20unifi%20-%20Exemple.git
   ```  
2. Modifiez les paramètres du script (adresses IP, identifiants, etc.).  
3. Exécutez le script via PowerShell :  
   ```powershell
   .\reboot unifi - Exemple.ps1
   ```  

## Remarques  
- Assurez-vous que vos équipements réseau acceptent les connexions SSH avant d'exécuter le script.  
- Il est conseillé de tester sur une seule borne avant de généraliser à l'ensemble du réseau.  

---  
