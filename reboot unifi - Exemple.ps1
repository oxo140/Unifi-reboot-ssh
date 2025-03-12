Install-Module -Name POSH-SSH -Force

# Variables
$startIP = [System.Net.IPAddress]::Parse("172.16.0.1")
$endIP = [System.Net.IPAddress]::Parse("172.16.80.80")

# Fonction pour convertir une IP en entier
function Convert-IPToInt($ip) {
    $bytes = $ip.GetAddressBytes()
    [Array]::Reverse($bytes)
    return [System.BitConverter]::ToUInt32($bytes, 0)
}

# Crédentiels SSH
$username = "admin"
$password = ConvertTo-SecureString "mot de passe" -AsPlainText -Force
$creds = New-Object System.Management.Automation.PSCredential ($username, $password)

# Boucle pour parcourir les adresses IP
function Get-NextIP ($ip) {
    $bytes = $ip.GetAddressBytes()
    [Array]::Reverse($bytes)
    $nextIP = [System.BitConverter]::ToUInt32($bytes, 0) + 1
    $nextBytes = [System.BitConverter]::GetBytes($nextIP)
    [Array]::Reverse($nextBytes)
    [System.Net.IPAddress]::Parse($nextBytes -join '.')
}

$currentIP = $startIP
while ((Convert-IPToInt $currentIP) -le (Convert-IPToInt $endIP)) {
    Write-Host "Tentative de connexion à $currentIP..."
    try {
        $session = New-SSHSession -ComputerName $currentIP.ToString() -Credential $creds -AcceptKey -ErrorAction Stop
        Write-Host "Connexion réussie à $currentIP"
        Invoke-SSHCommand -SessionId $session.SessionId -Command "reboot"
        Write-Host "Commande 'reboot' exécutée sur $currentIP"
        Remove-SSHSession -SessionId $session.SessionId
    } catch {
        Write-Host "Échec de la connexion à $currentIP"
    }
    $currentIP = Get-NextIP $currentIP
}
