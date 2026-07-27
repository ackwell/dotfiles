set -g fish_greeting

if status is-interactive
	starship init fish | source
	enable_transience

	# I can't live without sudo !! please understand
	function last_history_item; echo $history[1]; end
	abbr --add !! --position anywhere --function last_history_item
end
