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




"ACTIVE WLAN END "
"---------------"

"Other WLANs: "

$wifi_connections_all=$(netsh wlan show profiles)




foreach ($wifi in $wifi_connections_all) {

if($wifi.contains( "Benutzer " )){

$profile_name=($wifi -split ":",2)[1].Trim()

$profile_content = & "C:\Windows\System32\netsh.exe"  wlan show profiles  name="$profile_name"  key=clear



foreach ($line in $profile_content) {



if($line.contains( " SSID" )){

$ssid=($line -split ":",2)[1]
}


}


"SSID:" + $ssid
"Profile: " + $profile_name

# WLAN Passwortlänge tracken
#$profile =$profile.Trim()



#$profile_content = & "C:\Windows\System32\netsh.exe"  wlan show profiles  name="$profile"  key=clear
# im Debugger wird trotz key=clear KEIN passwort angezeigt. 

#$profile_content 

foreach ($profile_line in $profile_content) {
#$profile_line
if($profile_line.contains( "inhalt" )){
$passwd=($profile_line -split ":",2)[1]

}}

"PWD: " + $passwd





"---"







}
}

"END"

