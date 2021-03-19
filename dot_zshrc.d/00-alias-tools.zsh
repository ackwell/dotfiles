typeset -gxU __CHAIN_ALIAS_ALIASED

# Remove any existing chained aliases, let them be re-built
for aliased in $__CHAIN_ALIAS_ALIASED; do
	unalias $aliased
done
__CHAIN_ALIAS_ALIASED=()

chain-alias() {
	local short="$1"
	local expansion="$2"

	local existing
	existing=${aliases[$short]:-$short}

	local expanded
	expanded=${expansion/$short/$existing}

	alias $short=$expanded

	__CHAIN_ALIAS_ALIASED+=($short)
}