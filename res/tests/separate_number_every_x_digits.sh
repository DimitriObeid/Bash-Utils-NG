#!/bin/bash

# Function for formatting numbers in groups of X digits.
separate_number_every_x_digits() {
    #**** Parameters ****
    local num=${1};            # ARG TYPE : Float   - REQUIRED | DEFAULT VAL : NULL - DESC : Number to format.
    local separator=${2:-','}; # ARG TYPE : Char    - OPTIONAL | DEFAULT VAL : ,    - DESC : Separator to add between the groups.
    local group_size=${3:-3};  # ARG TYPE : Int     - OPTIONAL | DEFAULT VAL : 3    - DESC : Number of digits per group.

    #**** Variables ****
    local integer_part;        # VAR TYPE : String  - DESC : Integer part of the number to process.
    local decimal_part;        # VAR TYPE : String  - DESC : Decimal part of the number to process (if it is a decimal number).
    local formatted_integer;   # VAR TYPE : String  - DESC : String that stores the integer part of the number being formatted.

    declare -i count;          # VAR TYPE : Int     - DESC : Counter of digits into a group.
    declare -i i;              # VAR TYPE : Int     - DESC : Number of digits making up the number transmitted as a value for the "${num}" argument.

    #**** Code ****
    # If the separator is longer than a single character, then only the first character is kept.
    if [ "${#separator}" -ge 1 ]; then
        separator="${separator:0:1}";
    fi

    # If the separator is a number, then the separator is replaced by the default character : a coma.
    if [[ "${separator}" == [0-9] ]]; then
        separator=',';
    fi

    # Extracting the integer part and the decimal part.
    integer_part=$(echo "${num}" | cut -d '.' -f 1);
    decimal_part=$(echo "${num}" | cut -d '.' -f 2);

    # \\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\\
    # Formatting the whole part into groups of X digits.

    # Storing the newly reformatted integer part of the number being formatted.
    formatted_integer="";

    # Initialization of the counter of digits into a group.
    count=0;

    # Getting the number of digits making up the number transmitted as a value for the "${num}" argument.
    i=$(( ${#integer_part} - 1 ));

    # While the main number's first digit is not processed yet, every digit composing the aforementioned number will be grouped.
    while [ "${i}" -ge 0 ]; do
        formatted_integer="${integer_part:$i:1}$formatted_integer";
        count=$((count + 1));

        # If the number of digits in a group is equal to the number set by the value of the "${group_size}" argument AND if the first number's digit is not reached yet,
        if [ "${count}" -eq "${group_size}" ] && [ "${i}" -ne 0 ]; then
            formatted_integer="${separator}${formatted_integer}";

            # Reinitializing the counter of digits into a group, so that the next group can be created.
            count=0;
        fi

        # Moving to the next main number's digit to process.
        i=$((i - 1));
    done

    # Add the decimal part if it exists.
    if [ -n "${decimal_part}" ]; then
        formatted_number="${formatted_integer}.${decimal_part}";
    else
        formatted_number="${formatted_integer}";
    fi

    echo "${formatted_number}";

    return 0;
}

# Using the function.
number="125475865775974757597547534567.896467";
separator=" ";
group_size=5;

formatted_number=$(separate_number_every_x_digits "${number}" "${separator}" "${group_size}");
echo "Formatted number : ${formatted_number}";
