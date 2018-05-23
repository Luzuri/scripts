c=1
AMBARI_USER="admin"
AMBARI_PASSWD="admin"
AMBARI_HOST="ambari.pib.sb.ejiedes.net"
CLUSER_NAME="PIB"
t_servicios=$(sh -c ./sh1.sh)
echo "---Servicios BIEN---"
for service in ${t_servicios}; do
  warm=$(curl -s -u $AMBARI_USER:$AMBARI_PASSWD -H 'X-Requested-By: ambari' -X GET http://$AMBARI_HOST/api/v1/clusters/$CLUSER_NAME/services/${service} | grep WARNING | sed 's/"WARNING" : //g' | sed 's/ //g')
  crit=$(curl -s -u $AMBARI_USER:$AMBARI_PASSWD -H 'X-Requested-By: ambari' -X GET http://$AMBARI_HOST/api/v1/clusters/$CLUSER_NAME/services/${service} | grep CRITICAL | sed 's/"CRITICAL" : //g' | sed 's/ //g' | sed 's/,//g')
  if [[ $warm -eq 0 && "$crit" -eq 0 ]]; then
    echo $service
  fi
done
echo "---Servicios MAL---"
for service in ${t_servicios}; do
  warm=$(curl -s -u $AMBARI_USER:$AMBARI_PASSWD -H 'X-Requested-By: ambari' -X GET http://$AMBARI_HOST/api/v1/clusters/$CLUSER_NAME/services/${service} | grep WARNING | sed 's/"WARNING" : //g' | sed 's/ //g')
  crit=$(curl -s -u $AMBARI_USER:$AMBARI_PASSWD -H 'X-Requested-By: ambari' -X GET http://$AMBARI_HOST/api/v1/clusters/$CLUSER_NAME/services/${service} | grep CRITICAL | sed 's/"CRITICAL" : //g' | sed 's/ //g' | sed 's/,//g')
  if [[ $warm -ne 0 || "$crit" -ne 0 ]]; then
    while [ $c -lt 'curl -s -u admin:admin -H "X-Requested-By: ambari -X GET http://ambari.pib.sb.ejiedes.net/api/v1/clusters/PIB/services/FLINK | grep /alerts/ | wc -l' ]; then
      error=$(curl -s -u $AMBARI_USER:$AMBARI_PASSWD -H 'X-Requested-By: ambari' -X GET http://$AMBARI_HOST/api/v1/clusters/$CLUSER_NAME/services/${service} | grep /alerts/ | sed -e 's/"href" : "http:\/\/ejld1127.ejgvdns:8080\/api\/v1\/clusters\/PIB\/services\/FLINK\/alerts\///g' | sed 's/ //g' | sed 's/",//g' | head -${c} | tail -1)
      fin=$(curl -s -u $AMBARI_USER:$AMBARI_PASSWD -H 'X-Requested-By: ambari' -X GET http://$AMBARI_HOST/api/v1/clusters/$CLUSER_NAME/services/${service}/alerts/${error} | grep text | sed 's/"text" : "//g' | sed 's/"//g')
      echo "       ---Error: $error      ---Descripcion: $fin"
          ((c++))
  fi
done
