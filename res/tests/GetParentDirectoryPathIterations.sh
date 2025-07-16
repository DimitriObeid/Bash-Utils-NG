#!/usr/bin/env bash

# Getting parent folder's path from the root directory, then printing it
function BU.Main.Directories.GetParentDirectoryPath()
{
    #**** Parameters ****
    local p_path=${1:-$'\0'};       # ARG TYPE : String     - REQUIRED | DEFAULT VAR : NULL     - DESC : Path of the child file or folder.
    local p_iterations=${2:-$'\0'}; # ARG TYPE : Int        - OPTIONAL | DEFAULT VAR : NULL     - DESC : Number of iterations, corresponding to the number of folders to go up in the directory tree.

    #**** Code ****
	if [ -z "${p_iterations}" ]; then
        p_iterations='0';
	fi

    for (( i=0; i<p_iterations; i++)); do
	   	parent="$( cd "$(dirname "${p_path}")" > /dev/null 2>&1 \
        	|| {
       	    	BU.Main.Errors.HandleErrors "1" "UNABLE TO GET THE PARENT DIRECTORY'S NAME" "Please check if the provided path is correct." "${p_path}" \
           	    	"$(basename "${BASH_SOURCE[0]}")" "${FUNCNAME[0]}" "${LINENO}";
     		}; pwd -P )"
		p_path="${parent}";
	done

    shopt -s extglob;       # enable +(...) glob syntax
    result=${p_path%%+(/)}; # trim however many trailing slashes exist

    echo -e "${result}";
}

BU.Main.Directories.GetParentDirectoryPath "${0}" "4";
