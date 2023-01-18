# Install zinit if it isn't already
export ZINIT_HOME=$HOME/.zinit
if [[ ! -f $ZINIT_HOME/bin/zinit.zsh ]]; then
	echo "Installing zinit..."
	mkdir -p $ZINIT_HOME
	chmod g-rwX $ZINIT_HOME
	git clone https://github.com/zdharma-continuum/zinit.git $ZINIT_HOME/bin \
		&& echo "Cloned." \
		|| echo "Clone failed."
fi

# Initialise zinit
source "$ZINIT_HOME/bin/zinit.zsh"
autoload -Uz _zinit
(( ${+_comps} )) && _comps[zinit]=_zinit
