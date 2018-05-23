#!/bin/bash

#################################################################
#                                                               #
#       Descripcion:  Consulta de las salas salas y sus horas   #
#                                                               #
#       Version: 0.1                                            #
#                                                               #
#################################################################


#
# VARIABLES
#

FECHA=`date +%Y%m%d`
RUTA_BIN=`pwd`
ME=`basename ${0}`
RUTA_LOG=${RUTA_BIN}/log
RUTA_TMP=${RUTA_BIN}/tmp
FICH_LOG="${RUTA_LOG}/${FECHA}_${ME%.*}.log"
UNIQ_ID=`uuidgen -t`

#
# FUNCIONES
#

hora()
 {
         echo -n "[ ${UNIQ_ID} ][ `date +%H:%M:%S\ `]"  >> ${1}
 }

log()
 {
         hora ${3}
         echo "[ ${2} ] ${1}" >> ${3}

 }


#
# CUERPO
#

log "--- INICIO ---" INFO ${FICH_LOG}


cd /home/kide/outsystemRest/
cp plantilla_agenda.xml ficha_persona.xml
sed -i "s/xxPERSONxx/${2}/g" ficha_persona.xml
sed -i "s/xxCAMPOxx/${1}/g" ficha_persona.xml

log "Se llama al servicio para buscar a ${2} por el campo ${1}" INFO ${FICH_LOG}

content=$(curl --header 'Content-Type: text/xml;charset=UTF-8' --header 'SOAPAction: "http://www.exactsoftware.com/services/entities/entityset/RetrieveSet"' --data @ficha_persona.xml --proxy-ntlm --ntlm https://ataria.ejie.eus/services/Exact.Entities.svc -u 'EJGVNET\'${3}':'${4} --insecure -s)

echo $content > /tmp/agenda.xml
if [ `echo $content | xmllint --format - | grep "401 - Unauthorized" | wc -l` -gt 0 ]
then
  http_status=401
else
  http_status=200
fi

if [ ${http_status} -eq 200 ]
then
  linea1=`echo $content | xmllint --format - | egrep -A2 ">(PhoneWorkMobile|PhoneWork|EmailWork|FullName)<" | sed -e 's/<[^>]*>//g' | sed -e "s/^\([[:space:]]\+\)$/\1x/g"`
  linea=`echo ${linea1} | sed -e 's/ -- /\",\"/g' | sed -e 's/ \(true\|false\) /\":\"/g' | sed -e 's/,\(\"EmailWork\"\)/},{\1/g' | recode html..utf-8`
  if [ "${linea}" != "" ]
  then
    echo "{\"error\":0,\"array\":[{\""${linea}"\"}]}"
    echo "{\"error\":0,\"array\":[{\""${linea}"\"}]}" > /tmp/agenda.json
    log "El resultado de la llamada al servicio ha sido ${linea}" INFO ${FICH_LOG}
  else
    echo "{\"error\":0,\"array\":[]}"
    log "La consulta no ha devuelto ningun resultado" INFO ${FICH_LOG}
  fi
elif [ ${http_status} -eq 401 ]
then
  echo "{\"error\":1,\"array\":[]}"
  log "Error de permisos" INFO ${FICH_LOG}
else
  echo "{\"error\":2,\"array\":[]}"
  log "Ha ocurrido un error" INFO ${FICH_LOG}
fi
log "--- FIN ---\n" INFO ${FICH_LOG}
