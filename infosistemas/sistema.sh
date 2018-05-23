#!/bin/bash
c1=$(mpstat | tail -1 | awk '{ print $3 }' | sed 's/,/./g');
c2=$(mpstat | tail -1 | awk '{ print $5 }' | sed 's/,/./g');
c3=$(df | head -2 | tail -1 | awk '{printf $5}' | sed 's/%//g')
echo "   Equipo: $(hostname)"
echo "      Num. Procesadores:        $(grep -c ^processor /proc/cpuinfo)"
echo "      Memoria:	                $(grep ^MemTotal /proc/meminfo | sed 's/ //g' | sed 's/MemTotal://g')"
echo "      Estado:"
echo "         Memoria:"
echo "            Libre:              $(grep ^MemFree /proc/meminfo | sed 's/ //g' | sed 's/MemFree://g')"
echo "            Swap:               $(free -m | grep Swap | awk '{ print $2 }')"
echo "            Proc. mas memoria:  $(ps -eo pid,ppid,cmd,%mem,%cpu --sort=-%mem | head -2 | tail -1 | awk '{ print $3 " " $4 "%" }')"
echo "         CPU: "                  
echo "            Uso:		$(echo "$c2 + $c1" | bc | sed 's/^\./0./')%"
echo "            Proces mas cpu: "
echo "               PID:	        $(ps aux | sort -nrk 3,3 | head -n 1 | awk '{ printf $2 }')"
echo "               %CPU:	        $(ps aux | sort -nrk 3,3 | head -n 1 | awk '{ printf $3 }')"
echo "      Inodos Libres:            $(df -i | head -2 | tail -1 | awk '{printf $4}')"
echo "      %Disco Libre:             $((100-c3))%"
