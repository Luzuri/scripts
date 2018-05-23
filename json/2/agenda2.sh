sed  -e 's/</\n</g' agenda2.xml > agendav.xml
sed -e 's/>/>\n/g' agendav.xml > agendaw.xml
grep . agendaw.xml > agendaforma2.xml
rm -f agendaw.xml agendav.xml agenda2.json
cant=$(grep -c "<a:EntityData>" agendaforma2.xml);
c=1
while [ $cant -ge $c ]
do
	num1=$(grep -nw -m$c "EmailWork" agendaforma2.xml | tail -1 | cut -d : -f 1);
	num2=$(grep -nw -m$c "FullName" agendaforma2.xml |  tail -1 | cut -d : -f 1);
	num3=$(grep -nw -m$c "PhoneWorkMobile" agendaforma2.xml | tail -1 | cut -d : -f 1);
	num4=$(grep -nw -m$c "PhoneWork" agendaforma2.xml | tail -1 | cut -d : -f 1);
	email1=$((num1*-1 - 6));
	nombre1=$((num2*-1 - 6));
	workmo1=$((num3*-1 - 6));
	work1=$((num4*-1 - 6));
	email=$(head $email1 agendaforma2.xml | tail -1);
	nombre=$(head $nombre1 agendaforma2.xml | tail -1);
	workmo=$(head $workmo1 agendaforma2.xml | tail -1);
	work=$(head $work1 agendaforma2.xml | tail -1);
	echo "{"error":0,"array":[{"EmailWork":'$email',"FullName":'$nombre',"PhoneWorkMobile":'$workmo',"PhoneWork":'$work'}]}" | head -1 >> agendaz
	((c++))
done
sed -e 's/<\/a:PropertyData>//g' agendaz > agenda2.json
rm -f agendaz
