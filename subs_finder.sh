#!/bin/sh
domain=$1
threads=$2

if [ -z "$1" ];then
echo "[!] Es necesario agregar un dominio.";
exit 1
fi

if [ -z "$2" ];then
echo "[!] Es necesario especificar el No. de threads."
exit 1
fi

sublister=$(locate sublist3r.py)
if ! [ "$sublister" ]; then
echo "[!] No se encontro Sublist3r instalado.";
exit 1
fi

assetfinder=$(which assetfinder)
if ! [ "$assetfinder" ]; then
echo "[!] No se encontro assetfinder instalado.";
exit 1
fi

subfinder=$(which subfinder)
if ! [ "$subfinder" ]; then
echo "[!] No se encontro subfinder instalado.";
exit 1
fi

mkdir $1
$sublister -d $1 -t $2 -o $1/from_sublister.txt
echo "[+] Buscando subdominios de $1 con assetfinder"
$assetfinder --subs-only $1 > $1/fromassetfinder.txt
echo "[+] Buscando subdominios de $1 con subfinder"
$subfinder -d $1 -t $2 > $1/fromsubfinder.txt

cat $1/*.txt > $1/subs_collection.txt

rm -rf $1/from*

sort -u $1/subs_collection.txt -o $1/$1_subs_not_probed.txt

httprobe=$(which httprobe)
if ! [ "$httprobe" ]; then
echo "[!] No se encontro httprobe instalado.";
echo "[+] Guardando subdominios sin confirmar si responden."
exit 1
fi


echo "[+] Probando respuestas de subdominios."
cat $1/$1_subs_not_probed.txt | httprobe c 10 > $1_live_subs.txt

rm -rf $1
echo "[+] Finalizado."


