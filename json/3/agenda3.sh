sed  -e 's/</\n</g' agenda3.xml > agendav.xml
sed -e 's/>/>\n/g' agendav.xml > agendaw.xml
grep . agendaw.xml > agendaforma3.xml
rm -f agendav.xml agendaw.xml
cant=$(grep -c "<a:EntityData>" agendaforma3.xml);
c=1
echo "{"error":0,"array":[" > agenday
while [ $cant -ge $c ]
do
echo "$c"
num1=$(grep -nw -m$c "EmailWork" agendaforma3.xml | tail -1 | cut -d : -f 1);
num2=$(grep -nw -m$c "FullName" agendaforma3.xml |  tail -1 | cut -d : -f 1);
num3=$(grep -nw -m$c "PhoneWorkMobile" agendaforma3.xml | tail -1 | cut -d : -f 1);
num4=$(grep -nw -m$c "PhoneWork" agendaforma3.xml | tail -1 | cut -d : -f 1);
email1=$((num1*-1 - 6));
nombre1=$((num2*-1 - 6));
workmo1=$((num3*-1 - 6));
work1=$((num4*-1 - 6));
email=$(head $email1 agendaforma3.xml | tail -1);
nombre=$(head $nombre1 agendaforma3.xml | tail -1);
workmo=$(head $workmo1 agendaforma3.xml | tail -1);
work=$(head $work1 agendaforma3.xml | tail -1);
echo "{"EmailWork":'$email',"FullName":'$nombre',"PhoneWorkMobile":'$workmo',"PhoneWork":'$work'}," | head -1 >> agenday
((c++))
done
echo "]}" >> agenday
sed -e 's/<\/a:PropertyData>//g' agenday > agendaz
echo $(cat agendaz) | sed -e 's/\[ {/\[{/g' |  sed -e 's/, /,/g' > agendafin
sed -e 's/},\]}/}\]}/g' agendafin > agenda3.json
rm -f agenday agendaz agendafin
