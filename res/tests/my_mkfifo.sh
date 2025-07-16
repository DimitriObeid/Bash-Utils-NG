#!/usr/bin/bash

__BU_MAIN_PROJECT_FIFO_DIR_PATH="/usr/local/lib/Bash-utils/projects/lib-tests/FIFO";

# shellcheck disable=
function BU.Main.Decho.Decho { echo -e "$(tput setaf 6)${1}$(tput sgr0)"; }

# ··················································
# This function is called once in the next function.

# shellcheck disable=
function __CreateFIFO
{
    #**** Parameters ****
    local arr=("${@}");

    #**** Variables ****
    local i=0;

    #**** Code ****
    for val in "${arr[@]}"; do
        i=$(( i + 1 ));

        echo -e "$(tput setaf 166)${i}$(tput setaf 196)/$(tput setaf 166)${#arr[@]}$(tput sgr0) : ${val}$(tput sgr0)";
    done
}

# ····························································································································
# Creating a named pipe to get a variable's value instead of declaring it in a sub-shell, and thus, losing its modified value.

# shellcheck disable=
function CreateFIFO
{
    #**** Parameters ****
    local p_path=${1:-$'\0'};

    #**** Code ****
    if [ ! -d "${__BU_MAIN_PROJECT_FIFO_DIR_PATH}" ]; then
        echo -e "Creating the $(BU.Main.Decho.Decho "${__BU_MAIN_PROJECT_FIFO_DIR_PATH}")"; echo;
        mkdir -pv "${__BU_MAIN_PROJECT_FIFO_DIR_PATH}";
    fi

    echo -e "Creating the $(tput setaf 6)${p_path}$(tput sgr0) FIFO.";
    echo;

    if [ ! -p "${p_path}" ]; then
        if mkfifo "${p_path}"; then
            echo -e "Successfully created this FIFO --> $(tput setaf 6)${p_path}$(tput sgr0)." "$(( LINENO - 1 ))";
            echo;
        else
            echo -e "Error : Unable to create this FIFO --> $(BU.Main.Decho.Decho "${p_path}")";
        fi
    else
        echo -e "Existing FIFO --> $(tput setaf 6)${p_path}$(tput sgr0)" "$(( LINENO - 1 ))";
    fi
}

## ==============================================



# /////////////////////////////////////////////////////////////////////////////////////////////// #

#### NAMED PIPES READING

## FIFO READING

# ··························
# Reading from a named pipe.

# shellcheck disable=
function ReadFromFIFO
{
    #**** Parameters ****
    p_fifoPath=${1:-$'\0'};             # FIFO's path.
    p_fifoVarName=${2:-$'\0'};          # Stored variable's name.
    p_fifoCurrentVarValue=${3:-$'\0'};  # Stored variable's value to get.

    #**** Variables ****
    v_varLine="${p_fifoVarName}=\"${p_fifoCurrentVarValue}\"";

    #**** Code ****
    echo -e "Read the ${p_fifoPath} FIFO to find the ${p_fifoCurrentVarValue} value.";
    echo;

    while true; do
        if read -r line < "${p_fifoPath}"; then
            if [[ "${line}" == "${v_varLine}" ]]; then
                # Gathering the wanted value
                echo -e "${p_newVar}";
                break;
            else
                echo -e "${FUNCNAME[0]}() --> Error : the $(BU.Main.Decho.Decho "${v_varLine}") string was not found in the $(BU.Main.Decho.Decho "${p_fifoPath}") FIFO" >&2;
                kill "${$}";
            fi
        fi
    done
}

## ==============================================



# /////////////////////////////////////////////////////////////////////////////////////////////// #

# Writing into a named pipe
function WriteIntoFIFO
{
    #**** Parameters ****
    p_fifoPath=${1:-$'\0'};     # FIFO's path to write into.
    p_fifoVarName=${2:-$'\0'};  # Stored variable's name
    p_newVar=${3:-$'\0'};       # Stored variable's new value.
    p_existingPath=${4:-$'\0'}; # Handling missing FIFO, to define specific instructions.

    #**** Variables ****
    v_varLine="${p_fifoVarName}=\"${p_fifoCurrentVarValue}\"";

    #**** Code ****
    if [ ! -p "${p_fifoPath}" ]; then
        if [ "${p_existingPath}" == "nopath" ]; then
            return;
        else
            echo;

            # As this function is called by the functions called in the "BU.Main.Errors.HandleErrors" function, calling this last function will cause an infinite loop
            # Redefining a part of its behavior was necessary to prevent this situation.
            echo -e "IN $(basename "${BASH_SOURCE[0]}"), FUNCTION ${FUNCNAME[0]}, LINE ${LINENO} --> ERROR :" "-ne";
            echo -e "NO VALUE PASSED IN THE  \"p_existingPath\"  PARAMETER !" "-e";
            echo;

            echo -e "";
        fi
    fi
    # If the file size is equal to 0 (empty file)
    # À FAIRE : Ça bloque par ici
    if [ ! -s "${p_fifoPath}" ]; then
        cat <<-EOF > "${p_fifoPath}";
        ${v_varLine}="${p_newVar}";
EOF
    fi
}

CreateFIFO "${__BU_MAIN_PROJECT_FIFO_DIR_PATH}/test1";
echo -e "//////////////////////////////////////////////////////////////////////////////////////////////////";

WriteIntoFIFO "${__BU_MAIN_PROJECT_FIFO_DIR_PATH}/test1" "COLOR" "6" "";
echo -e "//////////////////////////////////////////////////////////////////////////////////////////////////";

ReadFromFIFO "${__BU_MAIN_PROJECT_FIFO_DIR_PATH}/test1" "COLOR" "";
echo -e "//////////////////////////////////////////////////////////////////////////////////////////////////";
