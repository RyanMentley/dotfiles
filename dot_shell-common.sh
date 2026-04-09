# Common to both zsh and bash

# ===================
#  Utility functions 
# ===================

# Add a directory to $PATH if it exists
add_to_path_end() {
    [ -d "$1" ] && export PATH="$PATH:$1"
}
add_to_path_start() {
    [ -d "$1" ] && export PATH="$1:$PATH"
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
    add_to_path_end "$ANDROID_HOME/cmdline-tools/latest/bin"
    if [ -d "$ANDROID_HOME/build-tools" ]; then
        # Build tools only exist in version-numbered directories, so find the latest
        latest_build_tools_dir=$(
            find "$ANDROID_HOME/build-tools" -mindepth 1 -maxdepth 1 -type d -exec basename {} \; |
            sort -t. -k1,1n -k2,2n -k3,3n |
            tail -n 1
        )
        [ -n "$latest_build_tools_dir" ] && add_to_path_end "$ANDROID_HOME/build-tools/$latest_build_tools_dir"
        unset latest_build_tools_dir
    fi
fi
add_to_path_end "$HOME/bin"

[ -x "$(command -v code)" ] && export EDITOR="code -w"


# =====
#  nvm
# =====
if [ -d "$HOME/.nvm" ]; then
    export NVM_DIR="$HOME/.nvm"
    [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
    [ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"
fi


# ==============
#  Load aliases
# ==============
source ~/.aliases.sh
