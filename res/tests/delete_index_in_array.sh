#!/usr/bin/env bash

# Déclaration du tableau
tableau=(valeur1 valeur2 valeur3 valeur4);

echo "Tableau original : ${tableau[*]}";

# La valeur à supprimer
valeur_a_supprimer="VAleur3";

# Filtrer les éléments du tableau pour supprimer la valeur spécifiée
# tableau=($(printf "%s\n" "${tableau[@]}" | grep -i -v "$valeur_a_supprimer"));

mapfile -t tableau < <(printf "%s\n" "${tableau[@]}" | grep -i -v "$valeur_a_supprimer")

# Afficher le tableau mis à jour
echo "Tableau mis à jour : ${tableau[*]}";
