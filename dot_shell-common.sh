# Common to both zsh and bash
# Interactive shell stuff only

[ -x "$(command -v code)" ] && export EDITOR="code -w"

# =====
#  nvm
# =====
if [ -d "$HOME/.nvm" ]; then
    export NVM_DIR="$HOME/.nvm"
fi

# ==============
#  Load aliases
# ==============
source ~/.aliases.sh
