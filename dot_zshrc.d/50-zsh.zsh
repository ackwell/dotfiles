# Completion menu
zstyle ':completion:*' menu select
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'

# Suggestions
export ZSH_AUTOSUGGEST_USE_ASYNC=1
zinit light zsh-users/zsh-autosuggestions