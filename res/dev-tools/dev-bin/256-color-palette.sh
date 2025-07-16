#!/bin/bash

# ----------------------------------------
# DEV-TOOLS EXECUTABLE FILE INFORMATIONS :

# Name          : 256-color-palette.sh
# Author(s)     : A Stack Overflow user (initial author of the code in the "else" condition), Dimitri OBEID (rest of the script)
# Version       : 2.0


# ----------------------
# SCRIPT'S DESCRIPTION :

# This script prints every color code of an XTERM palette table in a 6 * 40 table, with the corresponding color of each code printed in the background.

# ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;; #

######################################################### CODE ########################################################

# Help argument
if [ "${0,,}" == '-h' ] || [ "${0,,}" == '--help' ]; then
    case "${LANG,,}" in
        de_*)   echo "Anzeige der ANSI-Escape-Sequenz-Farbcodetabelle, mit Hintergrundwiedergabe.";;
        en_*)   echo "Display of the ANSI escape sequence color code table, with background rendering";;
        es_*)   echo "Visualización de la tabla de códigos de colores de secuencias de escape ANSI con visualización de fondo";;

        fr_*)   echo "Affichage de la table des codes couleurs des séquences d'échappement ANSI, avec leur rendu en arrière plan";;
        id_*)   echo "Tampilan tabel kode warna urutan pelarian ANSI, dengan rendering latar belakang";;
        pt_*)   echo "Visualização da tabela de códigos de cores da sequência de fuga ANSI, com renderização de fundo";;

        ru_*)   echo "Визуализация таблицы цветовых кодов ANSI управляющих последовательностей с отрисовкой фона";;
        sv_*)   echo "Visar tabellen med färgkoder för ANSI-sekvenser, med deras rendering i bakgrunden";;
        tr_*)   echo "Arka plan görüntüleri içeren ANSI dizileri için renk kodları tablosunu görüntüler";;

        uk_*)   echo "Візуалізація таблиці кольорових кодів ANSI послідовностей керування з відображенням фону";;
        zh_*)   echo "带背景显示的控制序列 ANSI 颜色代码表可视化";;

        *)      echo "Display of the ANSI escape sequence color code table, with background rendering";;
    esac;       echo;

# Code
else
    for((i=16; i<256; i++)); do
        printf "\e[48;5;${i}m%03d" "${i}";
        printf '\e[0m';
        [ ! $((( i - 15) % 6)) -eq 0 ] && printf ' ' || printf '\n';
    done
fi
