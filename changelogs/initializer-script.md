# changelogs/initializer-script.md

## Legend

```text
- ADD : Addition — Introduced a new file, function, variable, or feature.
- DEL : Deletion — Removed a file, function, variable, or feature.
- DOC : Documentation — Added or updated comments, inline explanations, or external docs.
- FIX : Fix — Corrected a bug, typo, or unexpected behavior.
- REF : Refactor — Improved code readability, structure, or performance without changing behavior.
- TES : Test — Added or executed tests for specific parts of the source code.
- UPD : Update — Modified dependencies, documentation, or file structure.
```

---------------------------------------------------------

## Commits changelogs

### Commit N°5

#### ID - ``

#### DATE - `2025/09/XX - XX:XX`

- **ADD** : Added the following global variable in the `Bash-utils-init.sh` script before the call of the `BU.ModuleInit.GetModuleInitLanguage()` function:
  - `__BU_MODULE_INIT__LOCALE_INIT__BAD_FMT_NAMEVARS_ARR`   GLOBAL  ARRAY   EMPTY

- **FIX** : Changed the type of the following global variables from an array to an integer, and initialized them to 0:
  - `__BU_MODULE_INIT__LOCALE_INIT__BAD_FMT_NAMEVARS_NB`
  - `__BU_MODULE_INIT__LOCALE_INIT__UNNAMED_VARS_NB`

- **ADD** : Transfert from the `initializer-locale` branch, since the function should be in the `Bash-utils-init.sh` script, and it was a hassle to regulary switch between these two branches while the `BU.ModuleInit.SetInitLocale."${__BU_MODULE_INIT__USER_LANG}"()` functions' tests haven't even started yet:
  - Added a function named `BU.ModuleInit.DeclareLocaleString()` to manage the missing texts and ensure the integrity of the messages to display when sourcing a Beta version of a translation file.

- **REF** : Moved all the `__BU_MODULE_INIT__LOCALE_INIT__` variables into the `BU.ModuleInit.DefineBashUtilsGlobalVariablesBeforeInitializingTheModules()` function.

- **ADD** : Added the following global variable in the "_Bash-utils-init.sh_" script into the `BU.ModuleInit.DefineBashUtilsGlobalVariablesBeforeInitializingTheModules()` function:
  - `__BU_MODULE_INIT__LOCALE_INIT__COUNTER`                GLOBAL  INT     0
  - `__BU_MODULE_INIT__LOCALE_INIT__DEFINED_VARS`           GLOBAL  ARRAY   EMPTY
  - `__BU_MODULE_INIT__LOCALE_INIT__REDEFINED_VARS`         GLOBAL  ARRAY   EMPTY

- **FIX** : Set the the name of the ISO 639-1 code in lowercase when calling the `BU.ModuleInit.SetInitLocale."${__BU_MODULE_INIT__USER_LANG,,}"()` function, in order to avoid any error while checking its name in the `BU.ModuleInit.BU.ModuleInit.DeclareLocaleString()` function.

- **REF** :

### Commit N°4

#### ID - `39682c61b6c0bef85a8ef56cf2f0d39c34aac594`

#### DATE - `2025/08/16 - 10:42`

- **ADD** : Added the following global variables in the `Bash-utils-init.sh` script before the call of the `BU.ModuleInit.GetModuleInitLanguage()` function, in order to manage the errors that might occur during the inclusion of a locale file via the call of its associated function:
  - `__BU_MODULE_INIT__LOCALE_INIT__HAS_ERROR_OCCURED`      GLOBAL  BOOL    FALSE
  - `__BU_MODULE_INIT__LOCALE_INIT__UNNAMED_VARS_NB`        GLOBAL  ARRAY   EMPTY
  - `__BU_MODULE_INIT__LOCALE_INIT__BAD_FMT_NAMEVARS_NB`    GLOBAL  ARRAY   EMPTY

### Commit N°3

#### ID - `717ba9fa7ff05cdd1ab01e7866e0729bbd948926`

#### DATE - `2025/08/13 - 16:49`

- **ADD** : Added multiple messages into the `BU.ModuleInit.GetModuleInitLanguage()` function to warn the user if they select a translation file in a Beta stage.

- **ADD** : Added missing Korean and Turkish translations in the same function.

### Commit N°2

#### ID - `94c18150ff379535488d1d78d90329cc22f73195`

#### DATE - `2025/08/12 - 00:08`

- **FIX** : Corrected the return code in case of an error in the `BU.ModuleInit.CheckPathIntegrity()` function.

- **ADD** : Imported the `BU.ModuleInit.SourceEnglishTranslationFiles()` function from the old `Bash-utils-init.sh` script.

- **FIX** : Removed a rogue star characher (*) which was accidentally written in the line 377 of the `install/.Bash-utils/config/initializer/locale/fr.locale` file.

- **REF** : Simplified the following variable's value in the `BU.ModuleInit.GetModuleInitLanguage_SetEnglishAsDefaultLanguage()` function:
  - `__BU_MODULE_INIT__USER_LANG="$(echo "${LANG}" | cut -d _ -f1)`    -> `__BU_MODULE_INIT__USER_LANG="${LANG%%_*}"`

- **FIX** : Added the simplified version of the previous variable into the `BU.ModuleInit.GetModuleInitLanguage()` function, right after the redefinition of the `${LANG}` environment variable.

### Commit N°1

#### ID - `fc883411b4688f203acee23e6a974a2bede4dd96`

#### DATE - `2025/08/11 - 18:02`

- **REF** : Remade the categories and sub-categories of the `Bash-utils-initializer.sh` script before the `BEGINNING OF THE INITIALIZATION PROCESS` category:
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

- **TES** : Testing the creation of the `tmp/.Bash-utils` directory if the `${__BU_MODULE_PRE_INIT__IS_FRAMEWORK_INSTALLED}` boolean is true.

- **TES** : Commented the `if [ -n "${v_specific_var}" ]; then` condition and its code, as this feature is not needed right now.

- **REF** : Changed the structure of the `BU.ModuleInit.FindPath()` function.

- **ADD** : Created the `BU.ModuleInit.CheckPathIntegrity()` function to check the integrity of the paths after calling the `BU.ModuleInit.FindPath()` function.

- **REF** : Changed the order of the condition which checked the existence of the `${HOME}/.Bash-utils` folder when the framework is not being installed, in order to make the reading more understandable.

- **REF** : Renamed the `BU.ModuleInit.IsTranslated()` function to `BU.ModuleInit.IsFrameworkTranslated()`.

- **ADD** : Added a new sub-sub-category in the locale files :
  - FUNCTION : "BU.ModuleInit.CheckPathIntegrity()"

- **REF** : Renamed the following variables in the locale files and changed their position to the `FUNCTION : "BU.ModuleInit.CheckPath()` sub-sub-section.
  - `__BU_MODULE_INIT_MSG__FIND_PATH__PATH_NOT_FOUND`         -> `__BU_MODULE_INIT_MSG__CHECKPATHINTEGRITY__PATH_NOT_FOUND`
  - `__BU_MODULE_INIT_MSG__FIND_PATH__TOP_LEVEL_FUNCTION`     -> `__BU_MODULE_INIT_MSG__CHECKPATHINTEGRITY__TOP_LEVEL_FUNCTION`

- **ADD** : Added a new global variable in the locale files : `__BU_MODULE_INIT_MSG__CHECKPATHINTEGRITY__PATH_MISSING`   STRING

- **ADD** : Added the `install/.Bash-utils/config/initializer/Status.conf` file.
