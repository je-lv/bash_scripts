#!/bin/bash

#colores para el echo
GR="\e[1;32m"
ENDC="\e[0m"
ROJ="\e[1;31m"
BCK_ROJ="\e[1;41m"

echo -e "\n$BCK_ROJ Informacion Basica de sistema$ENDC\n"

title () { if [ -n $2 ]; then echo -e "\n$GR$1 $ROJ$2$ENDC\n"; else echo -e "$GR$1 $ENDC\n"; fi }


F="tmp0.txt"
T=$(title "[+] Usuario Actual User y Group IDs")
echo -e "$T\n" > $F && id >> $F && cat $F


F="tmp1.txt"
T=$(title "[+] Hora local e idioma configurado en sistema")
echo -e "$T\n" > $F && echo -e "Hora Local: $LC_TIME\nIdioma: $LANG" >> $F && cat $F


F="tmp2.txt"
T=$(title "[+] OS y version de Kernel")
echo -e "$T\n" > $F && uname -a >> $F && cat $F


F="tmp3.txt"
T=$(title "[+] Distribucion y version")
echo -e "$T\n" > $F && lsb_release -a >> $F && cat $F


F="tmp4.txt"
T=$(title "[+] Grupos a los que pertenece el usuario" $USER)
echo -e "$T\n" > $F && id -Gn|tr ' ' '|' >> $F && cat $F


F="tmp5.txt"
T=$(title "[+] Primeros 10 archivos del grupo del usuario" $USER)
echo -e "$T\n" > $F && find / -group $USER 2>/dev/null| head -n 10 >> $F && cat $F


F="tmp6.txt"
T=$(title "[+] Grupos de cada usuario en /etc/passwd")
echo -e "$T\n" > $F && grep -o '^[^:]*' /etc/passwd >> $F && cat $F


F="tmp7.txt"
T=$(title "[+] Usuarios con Shell")
echo -e "$T\n" > $F && cat /etc/passwd 2>/dev/null | grep -i "sh$" | cut -d ":" -f 1 >> $F && cat $F


F="tmp8.txt"
T=$(title "[+] Informacion del CPU")
echo -e "$T\n" > $F && lscpu >> $F && cat $F


F="tmp9.txt"
T=$(title "[+] RAM disponible y en uso")
echo -e "$T\n" > $F && free -m -h >> $F && cat $F


F="tmp10.txt"
T=$(title "[+] Espacio en disco")
echo -e "$T\n" > $F && df -H >> $F && cat $F


F="tmp11.txt"
T=$(title "[+] Informacion de NICs")
if [ -e /sbin/ifconfig ]; then
        echo -e "$T\n" > $F && ifconfig >> $F && cat $F
else
        echo -e "$T\n" > $F && ip a >> $F && cat $F
fi


F="tmp12.txt"
T=$(title "[+] Conexiones Activas")
echo -e "$T\n" > $F && ss -tulpn >> $F && cat $F


F="tmp13.txt"
T=$(title "[+] Arbol de Procesos activos")
echo -e "$T\n" > $F && ps -aef --forest >> $F && cat $F


F="tmp14.txt"
T=$(title "[+] Procesos del usuario" $USER)
echo -e "$T\n" > $F && ps -U $USER -u $USER u  >> $F && cat $F


F="tmp15.txt"
T=$(title "[+] Procesos de root")
echo -e "$T\n" > $F && ps -U root -u root u  >> $F && cat $F


F="tmp16.txt"
T=$(title "[+] Servicios activos")
echo -e "$T\n" > $F && systemctl --type=service --state=active >> $F && cat $F


#contatenacion de archivos temporales en final
cat $(ls -1v tmp*.txt) > informacion_final.txt
#borrado de archivos temporales
rm tmp*.txt
