# Syntax highlighting
zinit light zdharma/fast-syntax-highlighting

# LS_COLORS w/ precompilation
zinit ice \
	atclone"dircolors -b LS_COLORS > lscolors.zsh" atpull'%atclone' \
	pick"lscolors.zsh" nocompile'!'  \
	atload'zstyle ":completion:*" list-colors "${(s.:.)LS_COLORS}"'
zinit light trapd00r/LS_COLORS

# Ensure tools are actually using colours
chain-alias ls "ls --color=auto"
chain-alias grep "grep --color=auto"
