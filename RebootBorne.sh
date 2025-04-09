#!/bin/bash

# Vérification si sshpass est installé
if ! command -v sshpass >/dev/null 2>&1; then
  echo "sshpass n'est pas installé. Installation en cours..."
  sudo apt-get update
  sudo apt-get install -y sshpass

  if [ $? -ne 0 ]; then
    echo "Erreur : installation de sshpass échouée. Arrêt du script."
    exit 1
  fi
else
  echo "sshpass est déjà installé."
fi


# ===========================
# Script Bash - Reboot des bornes UniFi
# ===========================

# IP range à scanner
start_ip="172.16.200.0"
end_ip="172.16.200.254"

# Identifiants SSH
username="$username"
password="$password"

# Convertir une IP en entier
ip2int() {
  local IFS=.
  read -r i1 i2 i3 i4 <<< "$1"
  echo "$(( (i1 << 24) + (i2 << 16) + (i3 << 8) + i4 ))"
}

# Convertir un entier en IP
int2ip() {
  local ip=$1
  echo "$(( (ip >> 24) & 0xFF )).$(( (ip >> 16) & 0xFF )).$(( (ip >> 8) & 0xFF )).$(( ip & 0xFF ))"
}

# Tester la connectivité avec ping
ping_check() {
  ping -c 1 -W 1 "$1" > /dev/null 2>&1
  return $?
}

# Début du traitement
current_ip=$(ip2int "$start_ip")
end_ip_int=$(ip2int "$end_ip")

while [ "$current_ip" -le "$end_ip_int" ]; do
  ip_address=$(int2ip "$current_ip")
  echo "Tentative de connexion à $ip_address"

  if ping_check "$ip_address"; then
    echo "Ping OK pour $ip_address, envoi de la commande reboot..."

    sshpass -p "$password" ssh -o StrictHostKeyChecking=no -o UserKnownHostsFile=/dev/null "$username@$ip_address" "/sbin/reboot"

    if [ $? -eq 0 ]; then
      echo "Reboot envoyé à $ip_address"
    else
      echo "Erreur SSH vers $ip_address"
    fi
  else
    echo "$ip_address est injoignable (ping KO)"
  fi

  current_ip=$((current_ip + 1))
done

# Nettoyage des clés SSH à la fin
echo "Nettoyage du fichier known_hosts..."
> ~/.ssh/known_hosts
echo "Fichier known_hosts vidé."

echo "Script terminé."
