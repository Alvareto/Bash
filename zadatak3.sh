for log in $(find . -regextype posix-extended -regex '.*localhost_access_log\.([0-9]{4})-02-([0-9]{2}).*')

do

	# datum možemo dobiti tako da razdvojimo ime dadoteke
	# po tockicama i uzmemo treæi stupac (jer je prvi iz nekog razloga --, a drugi tek ime, al dobro :D )
	datum=$(echo $log | cut -d '.' -f 3)
	
	g=$(echo $datum | cut -d '-' -f 1)	# godina
	m=$(echo $datum | cut -d '-' -f 2) 	# mjesec
 	d=$(echo $datum | cut -d '-' -f 3)	# dan	


	echo "datum: "$d'-'$m'-'$g
	echo "----------------------------------------"


	# za svaku akciju koja se pojavljuje u logovima treba ispisati koliko se puta dogodila toga dana
	# podatke o akcijama sortirati prema silaznom broj ponavljanja,
	# broj ponavljanja ispisati prije same akcije
	# iz:	217.14.220.162 - - [25/Feb/2008:00:01:23 +0100] "GET / HTTP/1.1" 200 15118
	#		217.14.220.162 - - [25/Feb/2008:00:01:23 +0100] "GET /images/java-color100.png HTTP/1.1" 200 11698
	#											...
	#		217.14.220.162 - - [25/Feb/2008:00:01:23 +0100] "GET /images/tomcat-1.png HTTP/1.1" 200 5641
	# treba dobit:
	# 	693 : GET /burza/b/Main.action HTTP/1.1
	# 	603 : GET /favicon.ico HTTP/1.1
	#					...
	# 	567 : GET /burza/css/default.css HTTP/1.1
	
	cut $log -d '"' -f 2 | sort | uniq -c | sort -nr

	# uniq -c
	#			-c := count, prefix lines by the number of occurences
	# sort -nr
	#			-n := numeric-sort, compare according to string numerical value
	#			-r := reverse, reverse the result of comparisons
done