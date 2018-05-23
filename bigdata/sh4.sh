#!/bin/bash

SERVER=ambari.pib.sb.ejiedes.net
PORT=8080
USERNAME=admin
PASSWORD=admin
CLUSTERNAME=PIB
SERVICE=$1

ENDPOINT="http://${SERVER}:${PORT}/api/v1/clusters/${CLUSTERNAME}/services/${SERVICE}"

case "$2" in
  start|START)
        echo "Starting $SERVICE"
        curl -u $USERNAME:$PASSWORD -i -H 'X-Requested-By: ambari' -X PUT -d '{"RequestInfo": {"context" :"Starting service via REST"}, "Body": {"ServiceInfo": {"state": "STARTED"}}}' $ENDPOINT
        ;;
  stop|STOP)
        echo "Stopping $SERVICE"
        curl -u $USERNAME:$PASSWORD -i -H 'X-Requested-By: ambari' -X PUT -d '{"RequestInfo": {"context" :"Starting service via REST"}, "Body": {"ServiceInfo": {"state": "INSTALLED"}}}' $ENDPOINT
        ;;
  check|CHECK)
        echo "Checking $SERVICE"
        curl --silent -u ${USERNAME}:${PASSWORD} -X GET ${ENDPOINT}?fields=ServiceInfo | grep state
        ;;
  *)
        echo 'Usage: ambari-service.sh [HDFS|MAPREDUCE2|YARN|TEZ|HIVE|HBASE|PIG|ZOOKEEPER|AMBARI_METRICS|FLINK|KAFKA|MAHOUT|SLIDER|SMARTSENSE] [start|stop]'
        echo
        echo 'Available services:'
        curl --silent -u $USERNAME:$PASSWORD -X GET http://${SERVER}:${PORT}/api/v1/clusters/${CLUSTERNAME}/services | grep service_name| awk -F":" '{print $2}'
        ;;
esac
