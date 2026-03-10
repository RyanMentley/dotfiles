# Common to both zsh and bash

[ -s "$HOME/.local/bin" ] && export PATH="$HOME/.local/bin:$PATH"
[ -s "$HOME/Library/Android/sdk" ] && export PATH="$HOME/Library/Android/sdk:$PATH"

[ -x "$(command -v code)" ] && export EDITOR="code -w"

# Mac stuff
if [[ "$(uname)" == "Darwin" ]]; then
    [ -s "/Applications/Android Studio.app/Contents/jbr/Contents/Home" ] && export JAVA_HOME="/Applications/Android Studio.app/Contents/jbr/Contents/Home"
fi

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

source ~/.aliases.sh
