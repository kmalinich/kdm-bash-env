# kdm bash-env
# .bashrc

# Last modified : Fri 31 Mar 2017 10:25:45 AM EDT

# Workaround for non-login shells that do not source .bash_profile

# if ${BASH_ENV_FILE_BASHRC} is already populated,
#   ~/.bash_profile must have been sourced, so source ~/.kdm/bashrc
# else
#   ~/.bash_profile must NOT have been sourced, so source ~/.bash_profile
# fi

# File paths
FILE_RC="${HOME}/.kdm/bashrc"
FILE_PF="${HOME}/.bash_profile"

# Determine which file to source
[[ "${BASH_ENV_FILE_BASHRC}" ]] &&
	SOURCE="${FILE_RC}" ||
	SOURCE="${FILE_PF}"

# Go!
[[ -s "${SOURCE}" ]] && . ${SOURCE} || echo "Error : Failed to source '${SOURCE}'"
