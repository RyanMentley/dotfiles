# Common to both zsh and bash

# ===================
#  Utility functions 
# ===================

latest_versioned_dir() {
    local parent_dir="$1"
    local name_glob="${2:-*}"

    [ -d "$parent_dir" ] || return 1

    find "$parent_dir" -mindepth 1 -maxdepth 1 -type d -name "$name_glob" -print 2>/dev/null |
        awk '
            {
                # `find` gives us one full path per line.
                # Keep the full path for final output, and also derive the basename
                # because that is the part we want to inspect for a version number.
                full_path = $0
                name = $0
                sub(".*/", "", name)

                # Find the first version-like substring in the basename.
                # Examples that match:
                #   36.1.0
                #   12_0_4
                #   1-2-3
                # This lets names like `ghidra_12.0.4_PUBLIC` work.
                if (match(name, /[0-9]+([._-][0-9]+)*/)) {
                    # Extract just the matched version text.
                    version = substr(name, RSTART, RLENGTH)

                    # Split the version into numeric components on `.`, `_`, or `-`.
                    # Example:
                    #   "36.1.0" -> [36, 1, 0]
                    count = split(version, parts, /[._-]/)

                    # Build a sortable string by zero-padding each numeric component.
                    # That turns:
                    #   9.10.0  -> 000000009.000000010.000000000.
                    #   36.1.0  -> 000000036.000000001.000000000.
                    #
                    # Once normalized this way, a plain lexicographic sort gives the
                    # same ordering we want from a numeric version comparison.
                    key = ""
                    for (i = 1; i <= count; i++) {
                        key = key sprintf("%09d.", parts[i] + 0)
                    }

                    # Emit the sortable key plus the original full path.
                    # The shell pipeline after `awk` sorts by the key, keeps the last
                    # row, and strips the key back off to recover the winning path.
                    print key "\t" full_path
                }
            }
        ' |
        LC_ALL=C sort |
        tail -n 1 |
        cut -f2-
}


# Add a directory to $PATH if it exists
add_to_path_end() {
    [ -d "$1" ] && export PATH="$PATH:$1"
}
add_to_path_start() {
    [ -d "$1" ] && export PATH="$1:$PATH"
}
add_latest_to_path_end() {
    local latest_dir
    latest_dir=$(latest_versioned_dir "$1" "$2") || return 1
    [ -n "$latest_dir" ] && add_to_path_end "$latest_dir"
}
add_latest_to_path_start() {
    local latest_dir
    latest_dir=$(latest_versioned_dir "$1" "$2") || return 1
    [ -n "$latest_dir" ] && add_to_path_start "$latest_dir"
}


# ===================
#  OS-specific stuff 
# ===================
if [[ "$(uname)" == "Darwin" ]]; then
    # Mac
    [ -s "/Applications/Android Studio.app/Contents/jbr/Contents/Home" ] && export JAVA_HOME="/Applications/Android Studio.app/Contents/jbr/Contents/Home"
    export ANDROID_HOME="$HOME/Library/Android/sdk"
else
    # Linux
    export ANDROID_HOME="$HOME/Android/Sdk"
fi

# =======
#  Pyenv
# =======
export PYENV_ROOT="$HOME/.pyenv"
[[ -d $PYENV_ROOT/bin ]] && export PATH="$PYENV_ROOT/bin:$PATH"
# The eval pyenv init line is in the shell-specific rc file, as it differs by shell

# ============
#  PATH setup
# ============
add_to_path_end "$HOME/.local/bin"
# Set up Android tooling on the PATH
if [ -d "$ANDROID_HOME" ]; then
    add_to_path_end "$ANDROID_HOME/platform-tools"
    add_to_path_end "$ANDROID_HOME/emulator"
    add_to_path_end "$ANDROID_HOME/cmdline-tools/latest/bin"
    add_latest_to_path_end "$ANDROID_HOME/build-tools" "*"
fi
add_to_path_end "$HOME/bin"
add_latest_to_path_end "$HOME/bin" "ghidra_*"

# =====
#  nvm
# =====
if [ -d "$HOME/.nvm" ]; then
    export NVM_DIR="$HOME/.nvm"
    [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
fi