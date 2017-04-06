# kdm bash-env
# .bashrc (wrapper)

# Last modified : Wed 05 Apr 2017 02:03:31 PM EDT

# File paths
FILE_RC="${HOME}/.kdm/bashrc"
FILE_PF="${HOME}/.bash_profile"

# Workaround for non-login shells that do not source .bash_profile
_validate_before_source() {
	# Return if we're not in a terminal
	[[ -t 2 ]] || return

	# Determine which file to source
	# if ${BASH_ENV_FILE_BASHRC} is already populated,
	#   ~/.bash_profile must have been sourced, so source ~/.kdm/bashrc
	# else
	#   ~/.bash_profile must NOT have been sourced, so source ~/.bash_profile
	# fi
	[[ "${BASH_ENV_FILE_BASHRC}" ]] && SOURCE="${FILE_RC}" || SOURCE="${FILE_PF}"

	# Go!
	[[ -s "${SOURCE}" ]] && . ${SOURCE} || echo "Error : Failed to source '${SOURCE}'"
}

_validate_before_source
