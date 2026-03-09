# Common to both zsh and bash

export PATH="$HOME/.local/bin:$PATH"
export EDITOR="code -w"

if [[ "$(uname)" == "Darwin" ]]; then
    [ -s "/Applications/Android Studio.app/Contents/jbr/Contents/Home" ] && export JAVA_HOME="/Applications/Android Studio.app/Contents/jbr/Contents/Home"
fi

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

source ~/.aliases.sh
