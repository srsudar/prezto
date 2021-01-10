#!/usr/bin/zsh
setopt extended_glob

# This prints paths we care about. Source it with $(${path_to_file}) and then
# feed it to FZF. This assumes that the content will be passed to `rg`, which
# means it does things like recursively search the current working directory by
# default.

RELEVANT_FILE_PATHS=(
  "foo/one"
  "bar/two"
)

SEARCH_REL_PATHS=()

# This is somewhat untested, but just gives the general idea. Depends a bit on
# the specifics of the directory we're searching.
# If we are in the HUGE directory, use our relevant files. Otherwise, assume
# we're in something like ~/dotfiles and return everything since we don't need
# to be smart.
if [[ $PWD == (#b)(/path/to/huge/${USER}/[^/]##/root-of-repo)* ]]; then
  # Get the absolute path as a backreference (#b).
  ABS_PATH=${match[1]}
  # Prepend abs_path to get absolute whitelists.
  WHITELIST_ABS_PATHS=(${RELEVANT_FILE_PATHS/#/${ABS_PATH}/})
  # We only search a path if it's either the PWD or descended from it.
  SEARCH_ABS_PATH=(${(M)WHITELIST_ABS_PATHS:#${PWD}(|/*)})
  # Remove hte leading / as well
  SEARCH_REL_PATHS=(${SEARCH_ABS_PATH/${PWD}\//})
fi

# Default to searching the PWD.
if [[ ${#SEARCH_REL_PATHS} == 0 ]]; then
  SEARCH_REL_PATHS=("")
fi

echo $SEARCH_REL_PATHS

