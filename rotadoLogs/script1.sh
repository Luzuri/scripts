#!/usr/bin/ksh
LOG_FILE="/home/unai/scripts/rotadoLogs/el.log"
rm -f $LOG_FILE
touch $LOG_FILE
logit()
  {
    echo "[ `date +%H:%M:%S\ `] $1" | tee -a "$LOG_FILE"
  }
logit "El script comienza a ejecutarse"
while getopts "hc:d:l:" opcion; do
case $opcion in
c) 
    logit "Se va a proceder a comprimir los archivos de hace $OPTARG dias";
    find /home/unai/scripts/rotadoLogs/logs -mtime +4 -exec gzip {} \;
    ;;
d)
    logit "Se va a proceder a eliminar los archivos de hace $OPTARG dias"
    find /home/unai/scripts/rotadoLogs/logs -mtime +1 -exec rm -f {} \;
    ;;
l)
    logit "Se va a proceder a guardar el log donde tu definiste: $OPTARG"
    LOG_FILE=$OPTARG
    ;;
h)
    echo "AYUDA:"
    echo "-c : dias a comprimir"
    echo "-d : dias a borrar"
    echo "-l : fichero log del script"
    echo "-h : ayuda"
    ;;
:)  
    echo "Opcion -$OPTARG requiere un argumento"
    exit 1 
    ;;
esac
done
logit "El script ha finalizado"
