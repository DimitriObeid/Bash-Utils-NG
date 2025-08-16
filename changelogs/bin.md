# bin.md

## Legend:

```
- **ADD** : Addition — Introduced a new file, function, variable, or feature.
- **DEL** : Deletion — Removed a file, function, variable, or feature.
- **DOC** : Documentation — Added or updated comments, inline explanations, or external docs.
- **FIX** : Fix — Corrected a bug, typo, or unexpected behavior.
- **REF** : Refactor — Improved code readability, structure, or performance without changing behavior.
- **TES** : Test — Added or executed tests for specific parts of the source code.
- **UPD** : Update — Modified dependencies, documentation, or file structure.
```

---------------------------------------------------------

## Commits changelogs:

--------------------

### Commit N°6:

#### ID - `3cf159c6d83cc7ae4307e1aa3117b0db27a4e26d`

#### DATE - `2025/08/`

- **ADD** — Implemented the `git push` command in the `bin/git-merge-all-branches-from-dev.sh` script to ensure that the updated code is propagated to remote branches automatically.

---

### Commit N°5:

#### ID - `0a0e8fc07fe66d5a81dcee35200522f7de22846e`

#### DATE - `2025/08/`

- **FIX** — Corrected the file reference in `bin/lib-install.sh` from _`Bash-utils-init-val.path`_ to _`Bash-utils-root-val.path`_.

- **REF** — Updated the global variable `${__BU__BIN__LIB_INSTALL__GLOBVARS__PATHS__BU_INIT_VAL_PATH}` to `${__BU__BIN__LIB_INSTALL__GLOBVARS__PATHS__BU_ROOT_VAL_PATH}` to reflect the aforementioned change.

---

### Commit N°4:

#### ID - `91e0c157a974e7c84d5635426b9148b065e70535`

#### DATE - `2025/08/`

- **ADD** — Introduced _`git-merge-all-branches-from-dev.sh`_ to automatically merge changes from the `dev` branch into all other branches except `master`.

- **REF** — Added a _`Contributors`_ entry to the `DEV-TOOLS EXECUTABLE FILE INFORMATIONS` section of all scripts in `res/dev-tools/dev-bin`.

---

### Commit N°3:

#### ID - `806c7b6f212a5ac60a444dfbaea45595df612ad2`

#### DATE - `2025/08/`

- **FIX** — Corrected message formatting in _`Bash-utils-init-val.path`_ creation: added a space after the _`Creating the %s%s%s file...`_ string.

- **ADD** — Introduced and commented the _`read`_ command to allow testing of the framework's core features; pending implementation of default folder selection in the quick install script.

---

### Commit N°2:

#### ID - `7b8f0fa913b1ba3ab05a38facc326b0697248c16`

#### DATE - `2025/08/`

- **REF** — Removed `dev-translation` directory and migrated its `locale` subdirectories into the respective resources folder of each executable script under `dev-src/`.

- **REF** — Updated `lib-compilerV4.sh` to reflect the new directory structure.

---

### Commit N°1:

#### ID - `c354b451ffcc7f9d010cae0470d3502887a8b20a`

#### DATE - `2025/0`

- **FIX** — Added a safeguard to verify the existence of `Bash-utils-root-val.path` in the user's home directory.

- **REF** — Declared all global variables in `lib-install.sh` as read-only to prevent accidental modifications during execution.
