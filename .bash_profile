# kdm bash-env
# .bash_profile (wrapper)


# File paths
DIR_KDM="${HOME}/.kdm"
FILE_PF="${DIR_KDM}/profile"

# shellcheck disable=SC1090
[[ -s "${FILE_PF}" ]] && . "${FILE_PF}" || echo "[.bash_profile] Error : Failed to source '${FILE_PF}'"


# vim: set filetype=sh ts=2 sw=2 tw=0 noet :
