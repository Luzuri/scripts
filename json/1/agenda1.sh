sed -e 's/</\n</g' agenda1.xml > agenda2.xml
sed -e 's/>/>\n/g' agenda2.xml > agendaf.xml
grep . agendaf.xml > agendaforma1.xml
rm -f agendaf.xml agenda2.xml
num1=$(grep -nw -e "EmailWork" agendaforma1.xml | cut -d : -f 1);num2=$(grep -nw -e "FullName" agendaforma1.xml | cut -d : -f 1);
num3=$(grep -nw -e "PhoneWorkMobile" agendaforma1.xml | cut -d : -f 1);
num4=$(grep -nw -e "PhoneWork" agendaforma1.xml | cut -d : -f 1);
email1=$((num1*-1 - 6));
nombre1=$((num2*-1 - 6));
workmo1=$((num3*-1 - 6));
work1=$((num4*-1 - 6));
email=$(head $email1 agendaforma1.xml | tail -1);
nombre=$(head $nombre1 agendaforma1.xml | tail -1);
workmo=$(head $workmo1 agendaforma1.xml | tail -1);
work=$(head $work1 agendaforma1.xml | tail -1);
echo "{"error":0,"array":[{"EmailWork":'$email',"FullName":'$nombre',"PhoneWorkMobile":'$workmo',"PhoneWork":'$work'}]}" > agenda1.json
