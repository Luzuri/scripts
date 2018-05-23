a=""
b=""
ter=""
AMBARI_USER="admin"
AMBARI_PASSWD="admin"
AMBARI_HOST="ambari.pib.sb.ejiedes.net"
CLUSER_NAME="PIB"
t_servicios=$(sh -c ./sh1.sh)
for service in ${t_servicios}; do
  c=1
  warm=$(curl -s -u $AMBARI_USER:$AMBARI_PASSWD -H 'X-Requested-By: ambari' -X GET http://$AMBARI_HOST/api/v1/clusters/$CLUSER_NAME/services/${service} | grep WARNING | sed 's/"WARNING" : //g' | sed 's/ //g')
  crit=$(curl -s -u $AMBARI_USER:$AMBARI_PASSWD -H 'X-Requested-By: ambari' -X GET http://$AMBARI_HOST/api/v1/clusters/$CLUSER_NAME/services/${service} | grep CRITICAL | sed 's/"CRITICAL" : //g' | sed 's/ //g' | sed 's/,//g')
  if [[ $warm -eq 0 && $crit -eq 0 ]]; then
    a="$a $service"
  else
      aa=$(curl -s -u $AMBARI_USER:$AMBARI_PASSWD -H "X-Requested-By: ambari" -X GET http://$AMBARI_HOST/api/v1/clusters/$CLUSER_NAME/services/${service} | grep /alerts/ | wc -l)
    while [ "$c" -le "$aa" ]
      do
      error=$(curl -s -u $AMBARI_USER:$AMBARI_PASSWD -H 'X-Requested-By: ambari' -X GET http://$AMBARI_HOST/api/v1/clusters/$CLUSER_NAME/services/${service} | grep /alerts/ | sed -e 's/"href" : "//g' | sed 's/ //g' | sed 's/",//g' | head -${c} | tail -1)
      fin=$(curl -s -u $AMBARI_USER:$AMBARI_PASSWD -H 'X-Requested-By: ambari' -X GET $error | grep text | sed 's/"text" : "//g' | sed 's/"//g')
      nombre=$(curl -s -u $AMBARI_USER:$AMBARI_PASSWD -H 'X-Requested-By: ambari' -X GET $error | grep service_name | sed 's/"service_name" : "//g' | sed 's/",//g')
      ter=$" $ter $service :    ---Num_Error: ${error##*/}  ---Description: ${fin}#"
      ((c++))
    done
  fi
done
echo "---Servicios BIEN---"
echo ${a} | sed -e 's/ /\n/g'
echo "---Servicios MAL---"
echo ${ter} | sed -e 's/#/\n/g' | sed -e 's/^[ \t]*//'
