# Mostly borrowed from sysr-q / aki-aki
# Snippet to source all the files in ~/.dotfiles/source
DOTFILES_SOURCED=1
export DOTFILES_SOURCED

if [[ "x$DOTFILES_DIR" == "x" ]]; then
	export DOTFILES_DIR="$HOME/.dotfiles"
fi

# Add the dotfiles bin folder to $PATH
export PATH="$DOTFILES_DIR/bin:$PATH"

# array of file globs to match
filematch=('*.sh')

# determine current shell
case "$(ps -o comm= -p $$)" in
	zsh)
		filematch+=('*.zsh')
		;;
	bash)
		filematch+=('*.bash')
		;;
esac

for n in $filematch; do
	for fn in $(find "$DOTFILES_DIR/source" -name "$n" -type f); do
		source "$fn"
	done
done

unset filematch n fn
