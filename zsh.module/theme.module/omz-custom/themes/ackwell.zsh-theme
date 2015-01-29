#/usr/bin/env zsh

function git-current-branch() {
	ref=$(git symbolic-ref HEAD 2> /dev/null) || \
	ref=$(git rev-parse --short HEAD 2> /dev/null) || return
	echo "${ref#refs/heads/}"
}

function git-current-status() {
	# grep pattern -> output symbol mapping
	mapping=(
		"^.?" "+"
		"^.M" "*"
		"^.D" "-"
	)

	# Get status
	current=$(git status --porcelain --branch)

	output=""

	# Get branch status first
	regex="\[(ahead|behind) ([0-9]*)"
	[[ $current =~ $regex ]]
	if [[ $match != "" ]]; then
		# Symbol
		if [[ $match[1] == "ahead" ]]; then
			symbol="↑"
		elif [[ $match[1] == "behind" ]]; then
			symbol="↓"
		fi

		output="${output} %{$fg[magenta]%}${symbol}%{$reset_color%}${match[2]}"
	fi

	# Loop the buggers
	for pattern symbol in $mapping
	do
		num=$(echo $current | grep "${pattern}" | wc -l | tr -d ' ')
		format="${output} %{$fg[magenta]%}${symbol}%{$reset_color%}${num}"
		[[ ${num} -eq "0" ]] || output=$format
	done

	echo $output
}

# Add ahead/behind when I can be assed. ↑↓

function git-dirty-colour() {
	[[ $(git diff-index --cached HEAD | wc -l) -eq "0" ]] && echo "%{$fg[green]%}" && return
	echo "%{$fg[magenta]%}"

}

function git-prompt-status {
	# Get branch, to make sure we are in a git repo
	branch=$(git-current-branch)
	[ ${branch} ] || return
	echo " %{$reset_color%}($(git-dirty-colour)${branch}$(git-current-status)%{$reset_color%})"
}

# Change prompt chr depending where we are
function prompt_chr {
	git branch >/dev/null 2>/dev/null && echo '±' && return
	echo "»"
}

# primary prompt
PROMPT='
%{$fg[yellow]%}${PWD/#$HOME/~}$(git-prompt-status) %{$fg[magenta]%}$(prompt_chr)%{$reset_color%} '

# Continuation prompt
PROMPT2='%{$fg[magenta]%}\ %{$reset_color%}'
RPS1='${return_code}'

# right prompt
RPROMPT='%{$fg[cyan]%}%n%{$reset_color%}@%{$fg[green]%}%m%{$reset_color%}'
