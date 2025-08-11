Legend :
    - **ADD** : Added a new file / function / variable/ etc...
    - **DEL** : Deleted a file / function / variable, etc...
    - **FIX** : Fixed a bug
    - **REF** : Code refactoring (for better lisibility)
    - **TES** : Testing the code of a specific part of a source file

---------------------------------------------------------
Commits changelogs :
--------------------


Commit ID - fc883411b4688f203acee23e6a974a2bede4dd96:

\- **REF** : Remade the categories and sub-categories of the _Bash-utils-initializer.sh_ script before the _BEGINNING OF THE INITIALIZATION PROCESS_ category:
    - INITIALIZER RESOURCES - FUNCTIONS REQUIRED TO INITIALIZE AND CONFIGURE MODULE ENGINE
        - BASH VERSION HANDLING
        - RUNTIME'S CORE CONFIGURATION

    - INITIALIZER RESOURCES - MULTILINGUAL MANAGEMENT AND TRANSLATIONS
        - LANGUAGE DETECTION
        - PRE-FILE INCLUSION LOGIC
        - STRING TRANSLATION

    - INITIALIZER RESOURCES - DEBUGS AND TESTS
        - DEBUG & TESTING FUNCTIONS
        - LOGGING FUNCTIONS

    - INITIALIZER RESOURCES - FRAMEWORK INITIALIZER'S CORE UTILITIES
        - EXIT FUNCTIONS

    - INITIALIZER RESOURCES - MODULES ENGINE'S FUNCTIONS
        - FILESYSTEM MANAGEMENT

\- **TES** : Testing the creation of the _/tmp/.Bash-utils_ directory if the **${__BU_MODULE_PRE_INIT__IS_FRAMEWORK_INSTALLED}** boolean is true.

\- **TES** : Commented the _if [ -n "${v_specific_var}" ]; then_ condition and its code, as this feature is not needed right now.

\- **REF** : Changed the structure of the "*BU.ModuleInit.FindPath()*" function.

\- **ADD** : Created the "*BU.ModuleInit.CheckPathIntegrity()*" function to check the integrity of the paths after calling the "*BU.ModuleInit.FindPath()*" function.

\- **REF** : Changed the order of the condition which checked the existence of the "${HOME}/.Bash-utils" folder when the framework is not being installed, in order to make the reading more understandable.

\- **REF** : Renamed the "*BU.ModuleInit.IsTranslated()*" function to "*BU.ModuleInit.IsFrameworkTranslated()*".

\- **ADD** : Added a new sub-sub-category in the locale files : FUNCTION : "BU.ModuleInit.CheckPathIntegrity()"

\- **REF** : Renamed the following variables in the locale files and changed their position to the "FUNCTION : "BU.ModuleInit.CheckPath()" sub-sub-section.
    - __BU_MODULE_INIT_MSG__FIND_PATH__PATH_NOT_FOUND       -> __BU_MODULE_INIT_MSG__CHECKPATHINTEGRITY__PATH_NOT_FOUND
    - __BU_MODULE_INIT_MSG__FIND_PATH__TOP_LEVEL_FUNCTION   -> __BU_MODULE_INIT_MSG__CHECKPATHINTEGRITY__TOP_LEVEL_FUNCTION

\- **ADD** : Added a new global variable in the locale files : __BU_MODULE_INIT_MSG__CHECKPATHINTEGRITY__PATH_MISSING

\- **ADD** : Added the "_install/.Bash-utils/config/initializer/Status.conf_" file.






