# Common to both zsh and bash

# Add a directory to $PATH if it exists
add_to_path_end() {
    [ -d "$1" ] && export PATH="$PATH:$1"
}
add_to_path_start() {
    [ -d "$1" ] && export PATH="$1:$PATH"
}

add_to_path_end "$HOME/.local/bin"
add_to_path_end "$HOME/Library/Android/sdk/platform-tools"
add_to_path_end "$HOME/Library/Android/sdk/cmdline-tools/latest/bin"

[ -x "$(command -v code)" ] && export EDITOR="code -w"

# Mac stuff
if [[ "$(uname)" == "Darwin" ]]; then
    [ -s "/Applications/Android Studio.app/Contents/jbr/Contents/Home" ] && export JAVA_HOME="/Applications/Android Studio.app/Contents/jbr/Contents/Home"
fi

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

source ~/.aliases.sh
