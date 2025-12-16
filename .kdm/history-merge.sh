# Merge .bash_history and in memory history together, sort it by timestamp, and store it into the history file.
# This is basically a 'clean merged write'.
# Result may optionally be read back into memory.
#
# Commands are sorted by their recorded timestamps.
# The command order in a single timestamped entry is preserved for multi-line commands
# File locking is used to prevent clashes due to multiple shells exiting simultaniously.
#
# This assumes files has bash timestamps.
# That is $HISTTIMEFORMAT is set, even if set to '' so as NOT to print timestamps in "history" command output.
# If it is NOT set, then this script will NOT work as the whole history file will be thought to be a single command.
#
# Adjust script to suit your needs.
#
# Includes optional code remove older 'duplicate' commands, and to delete commands which are 'too simple', or which may contain sensitive information.


### Anthony Thyssen,   8 October 2020

##.bash_profile
#
#HISTTIMEFORMAT=''        # Save the timestamp, but don't output it
##HISTTIMEFORMAT='%F_%T ' # output the time in 'history' see "ht" alias
#
# last few history commands
#h() {
#	history 30
#}
#
## history with time stamps
#ht() {
#	HISTTIMEFORMAT='%F_%T  ' history 30
#}
#
## merge, clean and write history
## shellcheck disable=SC1091
#hc() {
#	source "${HOME}/.kdm/history_merge.bash"
#}
#
## Replace in-memory history with written history
#hr() {
#	if [[ -n "${HISTFILE}" ]]; then
#		history -c
#		history -r
#		echo "history read (replace)"
#	else
#		echo "history is disabled"
#	fi
#}
#
## Just write the in-memory history to the history file
#hw() {
#	if [[ -n "${HISTFILE}" ]]; then
#		history -w
#		echo "history write (no merge)";
#	else
#		echo "history is disabled";
#	fi
#}


## .bash_logout
## merge and clean history before exiting
#hc

SCRIPT_DIR="$(realpath "$(dirname "${0}")")"

DATE="$(date '+%Y%m%d-%H%M%S')"

HISTFILE_INPUT="${1-$HISTFILE}"
HISTFILE_PRE="${HISTFILE_INPUT}.${DATE}.pre-merge"
HISTFILE_POST="${HISTFILE_INPUT}.${DATE}.post-merge"

# Make backup of history file
cp -v "${HISTFILE_INPUT}" "${HISTFILE_PRE}"

# Break up history into NUL separate records
# This makes processing a LOT easier, especially with regards to handling multi-line history commands (such as quoted multi-line string args)
# Then pipe it into the history-merge perl script
perl -pe '$_ = "\0$_" if /^#\d+/' "${HISTFILE_PRE}" | perl -0 "${SCRIPT_DIR}/history-merge.pl" > "${HISTFILE_INPUT}"

# Copy edited file to save post-merge state for potential later analysis
cp -v "${HISTFILE_INPUT}" "${HISTFILE_POST}"

echo "Done"


# vim: set filetype=sh ts=2 sw=2 tw=0 noet :
