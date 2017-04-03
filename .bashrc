# kdm bash-env
# .bashrc (wrapper)

# Last modified : Mon 03 Apr 2017 12:05:42 PM EDT

SCRIPT_NAME=".bash_profile"
echo "[$(date '+%a %b %d %R:%S')] ${SCRIPT_NAME}" >> ~/.loadlog
unset SCRIPT_NAME

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
