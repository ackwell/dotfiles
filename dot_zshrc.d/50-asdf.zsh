# Install asdf
export ASDF_HOME=$HOME/.asdf
if [[ ! -d $ASDF_HOME ]]; then
    echo "Installing asdf..."
    mkdir -p $ASDF_HOME
	chmod g-rwX $ASDF_HOME
	git clone https://github.com/asdf-vm/asdf.git $ASDF_HOME \
		&& echo "Cloned." \
		|| echo "Clone failed."
    pushd $ASDF_HOME
    git checkout "$(git describe --abbrev=0 --tags)"
    popd
fi

# Initialise
source $ASDF_HOME/asdf.sh
fpath=(${ASDF_DIR}/completions $fpath)