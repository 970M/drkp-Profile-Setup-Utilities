#!/bin/bash

# Remplace X par le pourcentage seuil
SEUIL=90

# Obtenir l'utilisation actuelle de la RAM en pourcentage


# Comparer avec le seuil

while true; do

    USAGE=$(free | grep Mem | awk '{print $3/$2 * 100.0}')
    if (( $(echo "$USAGE > $SEUIL" | bc -l) )); then

        notify-send "/!\ Alerte RAM" "L'utilisation de la RAM est de ${USAGE}%"
    fi
    
    sleep 10
done
