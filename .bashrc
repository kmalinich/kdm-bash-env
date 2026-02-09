# kdm bash-env
# .bashrc (wrapper)


# Uncomment for debug mode
# set -x

# File paths
DIR_KDM="${HOME}/.kdm"
FILE_RC="${DIR_KDM}/rc"
FILE_PF="${DIR_KDM}/profile"


# Test for interactivity
[[ "${-}" == *"i"* ]] && export BASH_INTERACTIVE="true"


# Workaround for non-login shells that do not source .bash_profile
_validate_before_source() {
	# Return if we're not in a terminal
	[[ "${BASH_INTERACTIVE}" == "true" ]] || return

	# Determine which file to source
	[[ "${BASH_INTERACTIVE}" == "true" ]] && SOURCE="${FILE_PF}" || SOURCE="${FILE_RC}"

	# shellcheck disable=SC1090
	. "${SOURCE}"
}


_validate_before_source


# vim: set filetype=bash ts=2 sw=2 tw=0 noet :
