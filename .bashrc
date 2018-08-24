# kdm bash-env
# .bashrc (wrapper)


# File paths
DIR_KDM="${HOME}/.kdm"
FILE_RC="${DIR_KDM}/rc"
FILE_PF="${DIR_KDM}/profile"

# Test for interactivity
[[ "${-}" == *"i"* ]] && export BASH_INTERACTIVE="true"


# Workaround for non-login shells that do not source .bash_profile
_validate_before_source() {
	# Return if we're not in a terminal
	[[ "${BASH_INTERACTIVE}" ]] || return

	# Determine which file to source
	# if ${BASH_ENV_FILE_RC} is already populated,
	#   ~/.bash_profile must have been sourced, so source ~/.kdm/rc
	# else
	#   ~/.bash_profile must NOT have been sourced, so source ~/.kdm/profile
	# fi
	[[ "${BASH_ENV_FILE_RC}" ]] && SOURCE="${FILE_RC}" || SOURCE="${FILE_PF}"

	# Go!
	# shellcheck disable=SC1090
	[[ -s "${SOURCE}" ]] && . "${SOURCE}" || echo "Error : Failed to source '${SOURCE}'"
}


_validate_before_source


# vim: set syntax=sh filetype=sh ts=2 sw=2 tw=0 noet :
