#!/usr/bin/env bash

# shellcheck disable=SC2154
function BU.DevBin.LibCompilerV4.Functions.WriteCommentCode.Heredoc.en()
{
cat <<-EOF >> "${v_filename_tmp}"
#!/usr/bin/env bash

# -----------------------
# SCRIPT'S INFORMATIONS :

# Name                  : ${__compiled_file_name}
# Code's Author(s)      : Dimitri OBEID
# Compilation author(s) : $([ -n "$__COMPILATION_AUTHOR" ]  && printf "%s" "${__COMPILATION_AUTHOR}"    || printf 'Feel free to give your name(s) if you have compiled this file by yourself')
# Version               : $([ -n "$__COMPILED_VERSION" ]    && printf "%s" "${__COMPILED_VERSION}"      || printf '1.0')


# ----------------------
# SCRIPT'S DESCRIPTION :

# This file contains the compiled version of the framework initializer script and the main module.

# This script declares every global variables, defines useful functions, and initializes all the extra modules

# you need for your scripts, from their configuration files to their initializer file, which are all included into this file.


# ----------------------------
# SHELLCHECK GLOBAL DISABLER :

# Add a coma after each warning code to disable multiple warnings at one go.

# Do not uncomment the "shellcheck disable" line, or else the "\$(shellcheck)" command will be executed during the script's execution, and will not detect any coding mistake during a debugging process.

# DO NOT ADD A COMA AFTER A SHELLCHECK CODE IF THERE'S NO OTHER SHELLCHECK CODE FOLLOWING IT, OR ELSE THE "\$(shellcheck)" COMMAND WILL RETURN ERRORS DURING THE DEBUGGING PROCESS !!!

# IF YOU WANT TO ADD ANOTHER SHELLCHECK CODE, WRITE THIS CODE DIRECTLY AFTER THE COMMA, WITHOUT ADDING A BLANK SPACE AFTER IT !!!

# shellcheck disable=SC1090


# ------------------------
# NOTES ABOUT SHELLCHECK :

# To display the content of a variable in a translated string, the use of the "\$(printf)" command is mandatory in order to interpret each "%s" pattern as the value of a variable.

# This means that the Shellcheck warning code SC2059 will be triggered anyway, since we have no choice but to store the entirety of every translated strings into global variables, many of which contain the above-mentioned pattern.

# If you add new messages to translate, you must call the "# shellcheck disable=SC2059" directive before the line where you call the
# "\$(printf)" command to display the translated message, otherwise Shellcheck will display many warnings during the debugging procedure.

# If the message is displayed inside a function, you can write the "# shellcheck disable=SC2059" directive on the line above the declaration of the said function.

# You can also write this directive at the beginning of a Bash script, but I would not recommand you to do so, since you may use the "\$(printf)" command in another context, without the same purpose.


# --------------------------------------------------------------------------------------
# DO NOT EXECUTE THIS SCRIPT DIRECTLY, instead, just source it in your main script file.

# /////////////////////////////////////////////////////////////////////////////////////////////// #

# Preventing the direct execution of this file, as it is not meant to be directly executed, but sourced.
EOF
}