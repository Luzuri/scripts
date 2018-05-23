#!/bin/bash
export AMBARI_USER="admin"
export AMBARI_PASSWD="admin"
export AMBARI_HOST="ambari.pib.sb.ejiedes.net"
export CLUSER_NAME="PIB"
content=$(curl -s -u $AMBARI_USER:$AMBARI_PASSWD -H 'X-Requested-By: ambari' -X GET http://$AMBARI_HOST/api/v1/clusters/$CLUSER_NAME/services/ | grep 'service_name' | sed -e 's/"service_name" : "/Servicio: /g')
echo -e $content | sed -e "s/\" /\n/g" | sed '/"$/d'
