#!/bin/bash

array=(1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16 17 18 19 20);

array_last_val="${array[${#array[@]} - 1]}";

v_index=0;

for i in "${array[@]}"; do
    echo "Value [${v_index}] : ${i}";

    v_valline=$(( v_index + 1 ));

    if [ $(( v_valline % 5 )) -eq 0 ]; then
        if [ "${i}" -eq "${array[${#array[@]} - 1]}" ]; then
            printf ""; break
        else
            echo "";
        fi
    fi

    v_index=$(( v_index + 1 ));
done
