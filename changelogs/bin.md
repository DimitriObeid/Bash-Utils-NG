Legend :
    - **ADD** : Added a new file / function / variable/ etc...
    - **DEL** : Deleted a file / function / variable, etc...
    - **FIX** : Fixed a bug
    - **REF** : Code refactoring (for better lisibility)
    - **TES** : Testing the code of a specific part of a source file

---------------------------------------------------------
Commits changelogs :
--------------------

Commit ID - :

<<<<<<< HEAD
\-


Commit ID - 91e0c157a974e7c84d5635426b9148b065e70535:
=======
\- **ADD** : Added the "_git-merge-all-branches-from-dev.sh_" script to automatically merge any changes pulled in the "_dev_" branch to every branches, except the master one.

\- **REF** : Added the "_Contributors_" line in the "_DEV-TOOLS EXECUTABLE FILE INFORMATIONS_" section of every scripts in the "_res/dev-tools/dev-bin_" directory.


Commit ID - 806c7b6f212a5ac60a444dfbaea45595df612ad2:
>>>>>>> bin

\- **FIX** : Added a space after the "_Creating the %s%s%s file..._" message in the process of creating the "_Bash-utils-init-val.path_" file.

\- **ADD** : Added and commented the "_read_" command and its associated code, since I'm not sure to implement the default folder selection in this quick installation file, as I use it to test the presence of the framework's core features.


Commit ID - 7b8f0fa913b1ba3ab05a38facc326b0697248c16 :

\- **REF** : Deleted the "_dev-translation_" directory after moving its "_locale_" sub-directories into their respective executable file's resources folder in the "_dev-src/_" directory.

\- **REF** : Adapted the aforementioned change into the "_lib-compilerV4.sh_" script.


Commit ID - c354b451ffcc7f9d010cae0470d3502887a8b20a :

\- **FIX** : Added a condition to check if the "Bash-utils-root-val.path" file is present

\- **REF** : Set all the global variables in the "lib-install.sh" file in read-only during their declaration.
