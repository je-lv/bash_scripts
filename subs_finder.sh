#!/bin/sh
domain=$1
out_file=$2
threads=$3

mkdir $1

echo "[+] Buscando subdominios de $1 con Sublist3r"
python3 /home/jelv/tools/Sublist3r/sublist3r.py -d $1 -t $3 -o $1/from_sublister.txt
echo "[+] Buscando subdominios de $1 con assetfinder"
assetfinder --subs-only $1 > $1/fromassetfinder.txt
echo "[+] Buscando subdominios de $1 con subfinder"
subfinder -d $1 -t $3 > $1/fromsubfinder.txt

cat $1/*.txt > $1/subs_collection.txt

rm -rf $1/from*

sort -u $1/subs_collection.txt -o $1/$1_subs.txt

echo "\n[+] Probando respuestas de subdominios."
cat $1/$1_subs.txt | httprobe c 10 > $1_live_subs.txt

rm -rf $1
echo "Finalizando..."


