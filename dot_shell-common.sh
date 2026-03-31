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


# ============
#  PATH setup
# ============
add_to_path_end "$HOME/.local/bin"
add_to_path_end "$ANDROID_HOME/platform-tools"
add_to_path_end "$ANDROID_HOME/cmdline-tools/latest/bin"
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
