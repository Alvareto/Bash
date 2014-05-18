#!/bin/bash

if [ "$#" -ne 2 ]; then
	echo "-------------------------------------------"
	echo "Greška u pozivanju"
	echo "				"
	echo "-------------------------------------------"
	echo "* Potreban broj argumenata: 2"
	echo "* Dani broj argumenata: $#"
	echo "-------------------------------------------"
	echo "Primjer pozivanja skripte:"
	echo '	/zadatak9.sh "/zadaci-faq.html" localhost_access_log.2008-02-24.txt '
	exit 1
fi

stranica=$1
dadoteka=$2

echo "-------------------------------------------"
echo "Broj pristupa stranici: $stranica"
echo "  IP adrese   |  Br. pristupa"
echo "-------------------------------------------"

for red in $(eval echo $(grep -i $stranica $dadoteka | cut -d '"' -f 1 | cut -d '-' -f 1)); do
	echo $red | sort | uniq -c | sort -nr

	brojPonavljanja=$(grep -i $stranica $dadoteka | cut -d '"' -f 1 | cut -d '-' -f 1 | cut -d ' ' -f 1)
	#echo $brojPonavljanja
	if [ $brojPonavljanja = 1 ]; then
		continue
	fi
	#echo $red
	
done

echo "-------------------------------------------"
