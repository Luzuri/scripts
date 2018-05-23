#!/bin/sh
reducir_lineas()
{
        TIPO=$1
	var=$(grep -nw -m$c $TIPO agendaforma3.xml | tail -1 | cut -d : -f 1);
	pos=$(($var *-1 -6));
	tex=$(head $pos agendaforma3.xml | tail -1);
	eval "${1}=\"$tex\""
}
sed  -e 's/</\n</g' agenda4 > agendav.xml
sed -e 's/>/>\n/g' agendav.xml > agendaw.xml
grep . agendaw.xml > agendaforma4.xml
rm -f agendav.xml agendaw.xml
cant=$(grep -c "<a:EntityData>" agendaforma4.xml);
c=1
echo "{"error":0,"array":[" > agenday
while [ $cant -ge $c ]
do
reducir_lineas EmailWork
reducir_lineas FullName
reducir_lineas PhoneWorkMobile
reducir_lineas PhoneWork
echo "{"EmailWork":'$EmailWork',"FullName":'$FullName',"PhoneWorkMobile":'$PhoneWorkMobile',"PhoneWork":'$PhoneWork'}," | head -1 >> agenday
((c++))
done
echo "]}" >> agenday
sed -e 's/<\/a:PropertyData>//g' agenday > agendaz
echo $(cat agendaz) | sed -e 's/\[ {/\[{/g' |  sed -e 's/, /,/g' > agendafin
sed -e 's/},\]}/}\]}/g' agendafin > agenda4.json
rm -f agendafin agendaz agenday 
