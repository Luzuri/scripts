#!/bin/bash
echo "Que desea hacer: [C]Comprimir los logs o [E]Eliminar los logs"
read x
if [ $x == "C" ]; then
  echo "Cuantos dias deseas comprimir a partir de hoy(Hoy no se puede compartir por que esta en uso)?"
  read y
  sh ./script1.sh -c $y
fi;
if [ $x == "E" ]; then
  echo "Cuantos dias deseas eliminar a partir de hoy(Hoy no se puede compartir por que esta en uso)?"
  read z
  sh ./script1.sh -d $z
fi;
