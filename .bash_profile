# kdm bash-env
# .bash_profile

# Disable echo output
stty -echo

# kdm bash-env variables
export BASH_ENV_DIR_KDM="${HOME}/.kdm"
export BASH_ENV_DIR_INCLUDE="${BASH_ENV_DIR_KDM}/include"

# Source data from include dir
echo -en "\nLoading...\r"
for i in {0..22}; do
	# shellcheck disable=SC1090
	. "${BASH_ENV_DIR_INCLUDE}/$(printf '%02d' ${i})"-*
done

# Show MOTD
_show_motd

# Re-enable echo output
stty echo

# vim: set syntax=sh filetype=sh ts=2 sw=2 tw=0 noet :
