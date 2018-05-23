#!/bin/bash
c=1
echo -n "{\"departamentos\":["
var=""
while [ $c -le `cat kk.xml | grep -wo 'ProjectDescription' | wc -l` ] 
do
  var=`xpath kk.xml "/s:Envelope/s:Body/RetrieveSetResponse/RetrieveSetResult/a:Entities/a:EntityData[${c}]/a:Properties/a:PropertyData[a:Name = 'ProjectDescription']/a:Value/text()" 2>/dev/null`
  echo -n "{\"ProjectDescription\":\""${var}"\"},"
  if [ $c -lt `cat kk.xml | grep -wo 'ProjectDescription' | wc -l` ]; then
    
    echo -n "{\"ProjectNumber\":\""`xpath kk.xml "/s:Envelope/s:Body/RetrieveSetResponse/RetrieveSetResult/a:Entities/a:EntityData[${c}]/a:Properties/a:PropertyData[a:Name = 'ProjectNumber']/a:Value/text()" 2>/dev/null`"\"},"
  else
    echo -n "{\"ProjectNumber\":\""`xpath kk.xml "/s:Envelope/s:Body/RetrieveSetResponse/RetrieveSetResult/a:Entities/a:EntityData[${c}]/a:Properties/a:PropertyData[a:Name = 'ProjectNumber']/a:Value/text()" 2>/dev/null`"\"}"
  fi
  c=$(( c+1 ))
done
echo -n "]}"
