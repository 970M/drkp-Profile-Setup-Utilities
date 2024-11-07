#!/bin/bash

# Pourcentage seuil
SEUIL=90

while true; do
    # Obtenir l'utilisation actuelle de la RAM en pourcentage
    USAGE=$(free | grep Mem | awk '{print $3/$2 * 100.0}')
    # Comparer avec le seuil    
    if (( $(echo "$USAGE > $SEUIL" | bc -l) )); then
        notify-send "/!\ Alerte RAM" "L'utilisation de la RAM est de ${USAGE}%"
    fi
    sleep 10
done
