# kdm bash-env
# .bash_profile

# kdm bash-env variables
export BASH_ENV_DIR_KDM="${HOME}/.kdm"
export BASH_ENV_DIR_INCLUDE="${BASH_ENV_DIR_KDM}/include"

# Source data from include dir
echo -en "\nLoading...\r"
for i in {0..21}; do
	. ${BASH_ENV_DIR_INCLUDE}/$(printf '%02d' ${i})-*
done
echo -en "          \r"

# Show MOTD
_show_motd

# vim: set syntax=sh filetype=sh ts=2 sw=2 tw=0 noet :
