# kdm bash-env
# .bash_profile (wrapper)


# File paths
DIR_KDM="${HOME}/.kdm"
FILE_PF="${DIR_KDM}/profile"

# shellcheck disable=SC1090
[[ -s "${FILE_PF}" ]] && . "${FILE_PF}" || echo "Error : Failed to source '${FILE_PF}'"


# vim: set filetype=sh ts=2 sw=2 tw=0 noet :

##
# Your previous /Users/kdm/.bash_profile file was backed up as /Users/kdm/.bash_profile.macports-saved_2024-06-18_at_12:06:35
##

# MacPorts Installer addition on 2024-06-18_at_12:06:35: adding an appropriate MANPATH variable for use with MacPorts.
export MANPATH="/opt/local/share/man:$MANPATH"
# Finished adapting your MANPATH environment variable for use with MacPorts.

