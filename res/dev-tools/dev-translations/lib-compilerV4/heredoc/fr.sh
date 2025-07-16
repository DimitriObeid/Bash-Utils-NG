#!/usr/bin/env bash

# shellcheck disable=SC2154
function BU.DevBin.LibCompilerV4.Functions.WriteCommentCode.Heredoc.fr()
{
cat <<-EOF >> "${v_filename_tmp}"
#!/usr/bin/env bash

# ----------------------------
# INFORMATIONS SUR LE SCRIPT :

# Nom                           : ${__compiled_file_name}
# Auteur(s) du code             : Dimitri OBEID
# Auteur(s) de la compilation   : $([ -n "$__COMPILATION_AUTHOR" ]  && printf "%s" "${__COMPILATION_AUTHOR}"    || printf 'Vous pouvez donner votre / vos nom(s) si vous avez compilé ce fichier par vous-même')
# Version                       : $([ -n "$__COMPILED_VERSION" ]    && printf "%s" "${__COMPILED_VERSION}"      || printf '1.0')


# ------------------------
# DESCRIPTION DU FICHIER :

#


# ------------------------------------
# DÉSACTIVATEUR GLOBAL DE SHELLCHECK :

# Ajoutez une virgule après chaque code d'avertissement pour désactiver plusieurs avertissements en une seule fois.

# Ne décommentez pas la ligne "shellcheck disable", sinon la commande "\$(shellcheck)" sera exécutée pendant l'exécution du script, et ne détectera aucune erreur de programmation pendant un processus de débogage.

# N'AJOUTEZ PAS DE VIRGULE APRÈS UN CODE SHELLCHECK S'IL N'Y A PAS D'AUTRES CODES SHELLCHECK QUI LE SUIT, SINON LA COMMANDE "\$(shellcheck)" RETOURNERA DES ERREURS PENDANT LE PROCESSUS DE DÉBOGAGE !!!


# ------------------------------
# NOTES À PROPOS DE SHELLCHECK :

# Pour afficher le contenu d'une variable dans une chaîne de caractères traduite, l'utilisation de la commande "\$(printf)" est obligatoire dans le but d'interpréter chaque patterne "%s" comme étant la valeur d'une variable.

# Ceci veut dire que l'avertissement au code SC2059 sera de toute façon déclenché, sachant que nous n'avons pas d'autres choix que d'enregsitrer l'intégralité de toutes les chaînes de caractères traduites dans des variables globales, dont un grand nombre contient le patterne sus-mentionné.

# Si vous ajoutez de nouveaux messages à traduire, vous devez appeller la directive "# shellcheck disable=SC2059" avant la ligne où vous appellez la
# commande "\$(printf)" pour afficher le message traduit, sinon Shellcheck affichera de nombreux messages d'avertissement pendant la procédure de déboguage.

# Si le message est affiché à l'intérieur d'une fonction, vous pouvez écrire la directive "# shellcheck disable=SC2059" à la ligne se situant juste au dessus de celle déclarant la fonction en question.


## ----------------------------------------------------------------------------------------
# N'EXÉCUTEZ PAS DIRECTEMENT CE SCRIPT, à la place, incluez-le dans votre script principal.

# /////////////////////////////////////////////////////////////////////////////////////////////// #

# Prévention de l'exécution directe de ce fichier, sachant que ce dernier n'est pas conçu pour être directement exécuté, mais pour être inclus.

EOF
}