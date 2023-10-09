#


# aktive SSID auslesen und MAC festhalten

$wifi_connection=$(netsh wlan show interfaces)

#$wifi_connection


# ist aus MAC Router ablesbar?
foreach ($line in $wifi_connection) {

if($line.contains( "BSSID" )){

$bssid=($line -split ":",2)[1]
}


if($line.contains( "Profil" )){
$profile=($line -split ":",2)[1]

}

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
# im Debugger wird trotz key=clear KEIN passwort angezeigt. 

#$profile_content 

foreach ($profile_line in $profile_content) {
#$profile_line
if($profile_line.contains( "inhalt" )){
$passwd=($profile_line -split ":",2)[1]

}}

"PWD: " + $passwd



"END"

