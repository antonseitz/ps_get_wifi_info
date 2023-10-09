# aktive SSID auslesen und MAC festhalten

"ACTIVE WLAN: "
$wifi_connection_active=$(netsh wlan show interfaces)


#$wifi_connection


foreach ($line in $wifi_connection_active) {

# Router MAC: 
if($line.contains( "BSSID" )){

$bssid=($line -split ":",2)[1]
}

# Profile:
if($line.contains( "Profil" )){
$profile=($line -split ":",2)[1]

}


# SSID:
if($line.contains( " SSID" )){

$ssid=($line -split ":",2)[1]
}


}

"RouterMAC:" + $bssid
"SSID:" + $ssid
"Profile: " + $profile

# WLAN Passwortlänge tracken

$profile =$profile.Trim()

$profile_content = & "C:\Windows\System32\netsh.exe"  wlan show profiles  name="$profile"  key=clear
# im Debugger wird trotz key=clear KEIN passwort angezeigt.  ?!?

#$profile_content 

foreach ($profile_line in $profile_content) {

#$profile_line
# Key suchen 
if($profile_line.contains( "inhalt" )){
$passwd=($profile_line -split ":",2)[1]

}
}

"PWD: " + $passwd
if($passwd.Length -lt 20){


$msg="Der WLAN-Key der aktuellen Verbindung 

" + $profile + " 

ist zu kurz! Die IT Sicherheitsrichtlinie von SD Vybrant schreibt eine Mindestlänge von 20 Zeichen vor!"
$Result = [System.Windows.Forms.MessageBox]::Show($msg,"Sicherheitshinweis IT Policy")
"zu kurz"
}



"ACTIVE WLAN END "
"---------------"
