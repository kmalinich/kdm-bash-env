# kdm bash-env
# .bashrc

# Last modified : Sun 18 Dec 2016 12:39:51 PM EST

# Source global bashrc
[[ -f /etc/bashrc ]] && . /etc/bashrc

#### Aliases: Function names ==start ####

alias android-make-md5='_android_make_md5'

alias convert-squid-timestamp='_convert_squid_timestamp'
alias convert-temperature='_convert_temperature'

alias find-file='_find_file'
alias find-largest='_find_largest'

alias fix-bash-pids='_fix_bash_pids'
alias fix-hung-java='_fix_hung_java'
alias fix-osx-files='_fix_osx_files'

alias g-gca='_g_gca'
alias g-gpo='_g_gpo'
alias g-gs='_g_gs'
alias g-gu='_g_gu'

alias kdm-help='_kdm_help'
alias kdm-pull='_kdm_pull'

alias net-curl-usage='_net_curl_usage'
alias net-curl='_net_curl'
alias net-dns-lookup='_net_dns_lookup'
alias net-info='_net_info'
alias net-mac-format='_net_mac_format'
alias net-mac-lookup='_net_mac_lookup'
alias net-ping-average-csv='_net_ping_average_csv'
alias net-ping-average='_net_ping_average'
alias net-ping-subnet='_net_ping_subnet'
alias net-webserver='_net_webserver'

alias prompt-generate='_prompt_generate'

alias setup-ssh-aliases='_setup_ssh_aliases'

alias show-array-width='_show_array_width'
alias show-bin='_show_bin'
alias show-clock-loop='_show_clock_loop'
alias show-clock='_show_clock'
alias show-colors='_show_colors'
alias show-motd='_show_motd'
alias show-scp-path='_show_scp_path'
alias show-top-cmds='_show_top_cmds'

alias ssh-c='_ssh_c'
alias ssh-ping='_ssh_ping'
alias ssh-x='_ssh_x'
alias ssh-xc='_ssh_xc'

alias time-elapsed-chrono='_time_elapsed_chrono'
alias time-elapsed-text='_time_elapsed_text'

alias update-all='_update_all'
alias update-cpan='_update_cpan'

#### Aliases: Function names ==final ####


#### Functions: Misc ==start ####

# Renders a hex color code in 24bit color output, and generates the corresponding ANSI escape sequence
hex2color() {
	local USAGE_STRING="hex2color '#4e0d92'"
	[[ -z "${1}" ]] && output usage "${USAGE_STRING}" && return

	COLOR_HEX="${1//\#/}"
	COLOR="38;2;$((0x${COLOR_HEX:0:2}));$((0x${COLOR_HEX:2:2}));$((0x${COLOR_HEX:4:2}))"
	echo -e "\e[${COLOR};m#${COLOR_HEX} -> ${COLOR}${COLOR_RESET}"
}

# Check if a binary is installed/present in ${PATH}, without stdout/stderr
# This is for bash, not for POSIX
hash() {
	builtin hash ${1+"$@"} &> /dev/null
	return "${?}"
}

# Convert squid timestamps to human date and time
_convert_squid_timestamp() {
	local USAGE_STRING="convert-squid-timestamp <squid log timestamp>"
	[[ -z "${1}" ]] && output usage "${USAGE_STRING}" && return

	echo "${1}" | perl -p -e 's/^([0-9]*)/"[".localtime($1)."]"/e'
}

#### Functions: Misc ==final ####


#### Functions: Text ==start ####

# Output formatted text
# I would have used an associative array (and in one version, I did),
# but it's only in bash 4+ which is ... more rarely seen than I'd like
output() {
	# Array of options
	local ARRAY_USAGE_OPTIONS=(
	alert
	black
	blue
	cyan
	error
	failure
	green
	leadup
	purple
	red
	stderr
	success
	usage
	white
	yellow
	)

	# Create variable of pipe-separated options from array
	local USAGE_OPTIONS_STRING="$(echo ${ARRAY_USAGE_OPTIONS[@]} | sed 's/ /|/g')"
	local USAGE_STRING="output <${USAGE_OPTIONS_STRING}> <string>"

	# Case statement for output color/format
	case "${1}" in
		alert)
			local COLOR_SELECTED="${COLOR_ALERT}"
			;;
		black)
			local COLOR_SELECTED="${COLOR_FG_BLK}"
			;;
		blue)
			local COLOR_SELECTED="${COLOR_FG_BLU}"
			;;
		cyan)
			local COLOR_SELECTED="${COLOR_FG_CYN}"
			;;
		error)
			# Special function to output to stderr
			local OUTPUT_STDERR="1"
			local OUTPUT_FORMAT="${COLOR_FG_BOLD_RED}Error${COLOR_RESET} : ${COLOR_FG_RED}%s${COLOR_RESET}\n"
			;;
		failure)
			# Special function for failure message, no string input
			local COLOR_SELECTED="${COLOR_FG_BOLD_RED}"
			local OUTPUT_STRING="failure"
			;;
		green)
			local COLOR_SELECTED="${COLOR_FG_GRN}"
			;;
		leadup)
			# Special function for leadup to status message, no newline
			local LOADING_DOT_COUNT="$((50-${#2}))"

			# Create dot string
			printf -v LOADING_DOT_STRING '%*s' ${LOADING_DOT_COUNT} ''
			local LOADING_DOT_STRING=$(printf '%s' ${LOADING_DOT_STRING// /.})
			local OUTPUT_FORMAT="${COLOR_RESET}Performing ${COLOR_BOLD}'${COLOR_FG_YLW}%s${COLOR_RESET}${COLOR_BOLD}'${COLOR_RESET} ${LOADING_DOT_STRING} ${COLOR_RESET}"
			;;
		purple)
			local COLOR_SELECTED="${COLOR_FG_PRP}"
			;;
		red)
			local COLOR_SELECTED="${COLOR_FG_RED}"
			;;
		stderr)
			# Special function to output to stderr
			local COLOR_SELECTED="${COLOR_FG_BLU}"
			local OUTPUT_STDERR="1>&2"
			;;
		success)
			# Special function for success message, no string
			local COLOR_SELECTED="${COLOR_FG_BOLD_GRN}"
			local OUTPUT_STRING="success"
			;;
		usage)
			# Special function to output formatted usage string, with stderr output
			local OUTPUT_FORMAT="${COLOR_FG_BOLD_YLW}Usage${COLOR_RESET} : ${COLOR_FG_YLW}%s${COLOR_RESET}\n"
			local OUTPUT_STDERR="1>&2"
			;;
		white)
			COLOR_SELECTED="${COLOR_FG_WHT}"
			;;
		yellow)
			local COLOR_SELECTED="${COLOR_FG_YLW}"
			;;
		*)
			# If nothing matches, reset color
			local COLOR_SELECTED="${COLOR_RESET}"
			;;
	esac

	# Check for variables and throw usage message if issue
	if [[ -z "${OUTPUT_STRING-${2}}" ]]; then
		output usage "${USAGE_STRING}"
		return
	fi

	# Output to stdout or stderr based on switch
	#[[ "${OUTPUT_STDERR}" == "1" ]] && printf "${OUTPUT_FORMAT}" "${OUTPUT_STRING}" 1>&2 || printf "${OUTPUT_FORMAT}" "${OUTPUT_STRING}"
	printf "${OUTPUT_FORMAT-${COLOR_SELECTED}%s${COLOR_RESET}\n}" "${OUTPUT_STRING-${2}}"
}

#### Functions: Text ==final ####


#### Functions: Ping ==start ####

# Custom fping commands
kping() {
	local USAGE_STRING="kping <target IP/host> [<optional interval in milliseconds>]"
	[[ -z "${1}" ]] && output usage "${USAGE_STRING}" && return

	# Default interval is 500ms
	local PING_INTERVAL="500"
	# Unless otherwise specified
	[[ "${2}" ]] && local PING_INTERVAL="${2}"

	fping -AdDelsu -H 254 -p "${PING_INTERVAL}" -t 1000 ${1}
}

#### Functions: Ping ==final ####


#### Functions: Time ==start ####

# Elapsed time function
# Outputs in chrono format - '01:23:44'
# Arg1: start time in seconds
# Arg1: end time in seconds
_time_elapsed_chrono() {
	# Array of options
	ARRAY_USAGE_OPTIONS=(current end)

	# Create variable of pipe-separated options from array
	local USAGE_OPTIONS_STRING="$(echo ${ARRAY_USAGE_OPTIONS[@]} | sed 's/ /|/g')"

	if [[ -z "${1}" || -z "${2}" ]]; then
		output usage "time-elapsed-chrono <start> <${USAGE_OPTIONS_STRING}>"
		output usage "If using 'current' as end time, start time must be in sec sinch epoch (date +%s)"
	else
		# Case statement to setup current time as end time if specified
		case "${2}" in
			current)
				# Get current time (sec since epoch)
				local TIME_END="$(date +%s)"
				;;
			*)
				local TIME_END="${2}"
				;;
		esac

		# Variable setup
		# Get start time from argument, then compare the two variables to get elapsed time
		# Math commands below are scale=0 because we only want integers
		local TIME_START="${1}"

		# Math for TOTAL timer
		local TOT[0]=$((TIME_END-TIME_START))
		local TOT[1]=$(echo "scale=0; ${TOT[0]}/60"       | bc)
		local TOT[2]=$(echo "scale=0; ${TOT[0]}/3600"     | bc)
		local TOT[3]=$(echo "scale=0; ${TOT[0]}/86400"    | bc)
		local TOT[4]=$(echo "scale=0; ${TOT[0]}/604800"   | bc)
		local TOT[5]=$(echo "scale=0; ${TOT[0]}/2419200"  | bc)
		local TOT[6]=$(echo "scale=0; ${TOT[0]}/29030400" | bc)

		# Math for clock timer
		# This outputs an actual working counter/clock/stopwatch type display i.e 12:34:33
		# This works because of PEMDAS (order of operations)
		local CLK[0]=$(echo "scale=0; ${TOT[0]}-${TOT[1]}*60" | bc)
		local CLK[1]=$(echo "scale=0; ${TOT[1]}-${TOT[2]}*60" | bc)
		local CLK[2]=$(echo "scale=0; ${TOT[2]}-${TOT[3]}*24" | bc)
		local CLK[3]=$(echo "scale=0; ${TOT[3]}-${TOT[4]}*7"  | bc)
		local CLK[4]=$(echo "scale=0; ${TOT[4]}-${TOT[5]}*4"  | bc)
		local CLK[5]=$(echo "scale=0; ${TOT[5]}-${TOT[6]}*12" | bc)
		local CLK[6]="${TOT[6]}"

		# Find how many units
		local CLK_UNIT_COUNT="6"
		local CLK_UNIT_OUT="6"

		# This basically finds the first non-zero digit in the array,
		# Starting from the top and working backwards
		while [[ "${CLK_UNIT_COUNT}" -gt "0" ]]; do
			[[ "${CLK[$CLK_UNIT_COUNT]}" == "0" ]] && local CLK_UNIT_OUT=$((CLK_UNIT_OUT-1)) || break
			local CLK_UNIT_COUNT=$((CLK_UNIT_COUNT-1))
		done

		while [[ "${CLK_UNIT_OUT}" -ge "0" ]]; do
			if [[ "${OUTPUT_STRING}" ]]; then
				local OUTPUT_STRING="${OUTPUT_STRING}:$(printf %02d ${CLK[$CLK_UNIT_OUT]})"
			else
				local OUTPUT_STRING="$(printf %02d ${CLK[$CLK_UNIT_OUT]})"
			fi
			local CLK_UNIT_OUT=$((CLK_UNIT_OUT-1))
		done

		# If the total is less than 60 seconds, Append 00: and just output seconds
		[[ "${TOT[0]}" -lt "60" ]] && local OUTPUT_STRING="00:${OUTPUT_STRING}"
		echo "${OUTPUT_STRING}"
	fi
}

# Elapsed time function
# Outputs in text format - '01 hours, 23 minutes, 44 seconds'
# Arg1: start time in seconds
# Arg1: end time in seconds
_time_elapsed_text() {
	# Array of options
	local ARRAY_USAGE_OPTIONS=(current end)

	# Create variable of pipe-separated options from array
	local USAGE_OPTIONS_STRING="$(echo ${ARRAY_USAGE_OPTIONS[@]} | sed 's/ /|/g')"

	if [[ -z "${1}" || -z "${2}" ]]; then
		output usage "time-elapsed-text <start> <${USAGE_OPTIONS_STRING}>"
		output usage "If using 'current' as end time, start time must be in sec sinch epoch (date +%s)"
	else
		# Case statement to setup current time as end time if specified
		case "${2}" in
			current)
				# Get current time (sec since epoch)
				local TIME_END="$(date +%s)"
				;;
			*)
				local TIME_END="${2}"
				;;
		esac

		# Variable setup
		# Get start time from argument, then compare the two variables to get elapsed time
		# Math commands below are scale=0 because we only want integers
		local TIME_START="${1}"

		# Math for TOTAL timer
		local TOT[0]=$((TIME_END-TIME_START))
		local TOT[1]=$(echo "scale=0; ${TOT[0]}/60"       | bc)
		local TOT[2]=$(echo "scale=0; ${TOT[0]}/3600"     | bc)
		local TOT[3]=$(echo "scale=0; ${TOT[0]}/86400"    | bc)
		local TOT[4]=$(echo "scale=0; ${TOT[0]}/604800"   | bc)
		local TOT[5]=$(echo "scale=0; ${TOT[0]}/2419200"  | bc)
		local TOT[6]=$(echo "scale=0; ${TOT[0]}/29030400" | bc)

		# Math for clock timer
		# This outputs an actual working COUNTER/clock/stopwatch type display i.e 12:34:33
		# This works because of PEMDAS (order of operations)
		local CLK[0]=$(echo "scale=0; ${TOT[0]}-${TOT[1]}*60" | bc)
		local CLK[1]=$(echo "scale=0; ${TOT[1]}-${TOT[2]}*60" | bc)
		local CLK[2]=$(echo "scale=0; ${TOT[2]}-${TOT[3]}*24" | bc)
		local CLK[3]=$(echo "scale=0; ${TOT[3]}-${TOT[4]}*7"  | bc)
		local CLK[4]=$(echo "scale=0; ${TOT[4]}-${TOT[5]}*4"  | bc)
		local CLK[5]=$(echo "scale=0; ${TOT[5]}-${TOT[6]}*12" | bc)
		local CLK[6]="${TOT[6]}"

		# Find how many units
		local CLK_UNIT_COUNT="6"
		local CLK_UNIT_OUT="6"
		# This basically finds the first non-zero digit in the array,

		# Starting from the top and working backwards
		while [[ "${CLK_UNIT_COUNT}" -gt "0" ]]; do
			[[ "${CLK[$CLK_UNIT_COUNT]}" == "0" ]] && local CLK_UNIT_OUT=$((CLK_UNIT_OUT-1)) || break
			local CLK_UNIT_COUNT=$((CLK_UNIT_COUNT-1))
		done

		local ARRAY_UNIT=(second minute hour day week month year)
		local ARRAY_UNIT_COUNTER="0"

		while [[ "${CLK_UNIT_OUT}" -ge "0" ]]; do
			local TIME_UNIT_CURRENT="${ARRAY_UNIT[$CLK_UNIT_OUT]}"

			# Find if unit is plural or singular
			# i.e. not 1 of whatever time unit
			# Add the 's' at the end (plural)
			[[ "${CLK[$CLK_UNIT_OUT]}" != "1" ]] && local TIME_UNIT_CURRENT="${TIME_UNIT_CURRENT}s"

			# Append the value and unit to the string
			if [[ "${OUTPUT_STRING}" ]]; then
				local OUTPUT_STRING="${OUTPUT_STRING}, ${CLK[$CLK_UNIT_OUT]} ${TIME_UNIT_CURRENT}"
			else
				local OUTPUT_STRING="${CLK[$CLK_UNIT_OUT]} ${TIME_UNIT_CURRENT}"
			fi

			# Find out if it's the last one in the array
			# If not, add a comma to the end
			[[ "${CLK_UNIT_OUT}" != "0" ]] && local TIME_UNIT_CURRENT="${TIME_UNIT_CURRENT}, "

			# Decrement counter
			local CLK_UNIT_OUT=$((CLK_UNIT_OUT-1))
		done
		echo "${OUTPUT_STRING}"
	fi
}

#### Functions: Time ==final ####


#### Functions: Number base conversion ==start ####

# Convert temperatures to other formats
_convert_temperature() {
	local USAGE_STRING="temp-conv <temperature[c|f|k|r]>"
	[[ "${1}" != *[0-9][CcFfKkRr]* ]] && output usage "${USAGE_STRING}" && return

	# Set calculation scale
	local SCALE="2"

	# Detect input format (the ghetto way) and convert to Kelvin
	if [[ "${1}" == *[Cc]* ]]; then
		local TEMP_C=${1//[!0-9]/}
		local TEMP_K=$(echo "scale=${SCALE}; ${TEMP_C}+273.15" | bc)
	elif [[ "${1}" == *[Ff]* ]]; then
		local TEMP_F=${1//[!0-9]/}
		local TEMP_K=$(echo "scale=${SCALE}; (${TEMP_F}+459.67)*(5/9)" | bc)
	elif [[ "${1}" == *[Kk]* ]]; then
		local TEMP_K=${1//[!0-9]/}
	elif [[ "${1}" == *[Rr]* ]]; then
		local TEMP_R=${1//[!0-9]/}
		local TEMP_K=$(echo "scale=${SCALE}; ${TEMP_R}*(5/9)" | bc)
	fi

	# Calculate missing values (yes, I shave off a single CPU cycle not computing, only to spend it evaluating)
	[[ -z "${TEMP_C}" ]] && local TEMP_C=$(echo "scale=${SCALE}; ${TEMP_K}-273.15"         | bc)
	[[ -z "${TEMP_F}" ]] && local TEMP_F=$(echo "scale=${SCALE}; (${TEMP_K}*(9/5))-459.67" | bc)
	[[ -z "${TEMP_R}" ]] && local TEMP_R=$(echo "scale=${SCALE}; ${TEMP_K}*(9/5)"          | bc)

	# Set margin for printf commands
	local PF_FMT="%-8s${COLOR_FG_PRP}%s${COLOR_RESET}\n"

	# Output temperatures in various formats! yay!
	printf "${PF_FMT}" "${TEMP_C}" "C"
	printf "${PF_FMT}" "${TEMP_F}" "F"
	printf "${PF_FMT}" "${TEMP_K}" "K"
	printf "${PF_FMT}" "${TEMP_R}" "R"
}

# Convert hexadecimal<->decimal
dechex() {
	local USAGE_STRING="dec2hex <decimal number>"
	[[ -z "${1}" ]] && output usage "${USAGE_STRING}" && return

	# Add '0x0' to the hex string if single digit (under 16 in decimal)
	# or just 0x if 2 or more digits
	local PREFIX="0x"
	[[ "${#HEX}" == "1" ]] && local PREFIX="0x0"

	# Detect if input is in hex or dec
	if [[ "${1}" == *[x]* ]]; then
		local PROCESS="hex2dec"
		local HEX="${1#0x}"
		local DEC="$((${PREFIX}${HEX}))"
	else
		local PROCESS="dec2hex"
		local DEC="${1}"
		local HEX="$(printf '%x\n' ${DEC})"
	fi

	output purple "Process     : ${PROCESS}"
	output yellow "Decimal     : ${DEC}"
	output green  "Hexadecimal : ${PREFIX}${HEX}"
}

# Command aliases for above function
alias hexdec='dechex'

#### Functions: Number base conversion ==final ####


#### Functions: Android ==start ####

# Make md5sum file for a Android recovery
_android_make_md5() {
	local USAGE_STRING="android-make-md5 <filename>"
	[[ -z "${1}" ]] && output usage "${USAGE_STRING}" && return

	local FILE_NAME="${1}"
	local FILE_MD5="$(md5sum ${FILE_NAME} | awk '{print $1}')"
	echo ''"${FILE_MD5}"' *'"${FILE_NAME}"'' > ${FILE_NAME}.md5sum

	output purple "md5sum created"
	output yellow "Filename  : ${FILE_NAME}.md5sum"
	output green  "Signature : ${FILE_MD5}"
}

#### Functions: Android ==final ####


#### Functions: SSH ==start ####

# Ping it, then ssh to it
_ssh_ping() {
	local USAGE_STRING="ssh-ping <host>"
	[[ -z "${1}" ]] && output usage "${USAGE_STRING}" && return

	ping ${1}
	ssh  ${1} "${2}"
}

# Show full path for SCPing
_show_scp_path() {
	# If no argument, select current directory
	local SELECTED="${PWD}"
	[[ "${1}" ]] && local SELECTED="${1}"

	# Check if file exists
	[[ ! -e "${SELECTED}" ]] && output error "'./${1}' is not a valid file" && return

	# Get realpath of argument, and then swap out the home directory with a tilde
	local SELECTED="$(realpath ${SELECTED})"
	local SCP_PATH="$(echo ${SELECTED} | sed "s,${HOME},~,g")"

	# Check if argument is a file or folder, fill variables accordingly
	if [[ -d "${SELECTED}" ]]; then
		local FILE_NAME="${SCP_PATH}"
		local FILE_TYPE="folder"
		local SCP_CMD="scp -r"
	else
		local FILE_NAME="$(basename ${SCP_PATH})"
		local FILE_TYPE="file"
		local SCP_CMD="scp"
	fi

	echo
	output purple "Download ${FILE_NAME} from ${HOST_SHORT}:"

	echo -e "${SCP_CMD} ${BASH_ENV_COLOR}${USER}@${HOST_SHORT}${COLOR_RESET}:${COLOR_FG_BLU}${SCP_PATH}${COLOR_RESET} ."
	echo -e "${SCP_CMD} ${BASH_ENV_COLOR}${USER}@${HOSTNAME}${COLOR_RESET}:${COLOR_FG_BLU}${SCP_PATH}${COLOR_RESET} ."
	echo -e "${SCP_CMD} ${BASH_ENV_COLOR}${USER}@${HOST_IP}${COLOR_RESET}:${COLOR_FG_BLU}${SCP_PATH}${COLOR_RESET} ."
	echo

	# Output upload instructions if FILE_TYPE is folder
	[[ ! -d "${SELECTED}" ]] && return

	output purple "Upload \${FILE} to ${HOST_SHORT}:${SCP_PATH}/ (fill in the blank variable)"

	echo -e "${COLOR_FG_CYN}FILE${COLOR_RESET}=${COLOR_FG_YLW}\"\"; ${COLOR_RESET}scp ${COLOR_FG_PRP}-r ${COLOR_FG_YLW}\"${COLOR_FG_PRP}\${FILE}${COLOR_FG_YLW}\"${COLOR_RESET} ${BASH_ENV_COLOR}${USER}@${HOST_SHORT}${COLOR_RESET}:${COLOR_FG_BLU}${SCP_PATH}/${COLOR_RESET}"
	echo -e "${COLOR_FG_CYN}FILE${COLOR_RESET}=${COLOR_FG_YLW}\"\"; ${COLOR_RESET}scp ${COLOR_FG_PRP}-r ${COLOR_FG_YLW}\"${COLOR_FG_PRP}\${FILE}${COLOR_FG_YLW}\"${COLOR_RESET} ${BASH_ENV_COLOR}${USER}@${HOSTNAME}${COLOR_RESET}:${COLOR_FG_BLU}${SCP_PATH}/${COLOR_RESET}"
	echo -e "${COLOR_FG_CYN}FILE${COLOR_RESET}=${COLOR_FG_YLW}\"\"; ${COLOR_RESET}scp ${COLOR_FG_PRP}-r ${COLOR_FG_YLW}\"${COLOR_FG_PRP}\${FILE}${COLOR_FG_YLW}\"${COLOR_RESET} ${BASH_ENV_COLOR}${USER}@${HOST_IP}${COLOR_RESET}:${COLOR_FG_BLU}${SCP_PATH}/${COLOR_RESET}"
	echo
}

# With compression
_ssh_c() {
	local USAGE_STRING="ssh-c <host>"
	[[ -z "${1}" ]] && output usage "${USAGE_STRING}" && return

	ssh -o Compression=yes ${1}
}

# With X forwarding
_ssh_x() {
	local USAGE_STRING="ssh-x <host>"
	[[ -z "${1}" ]] && output usage "${USAGE_STRING}" && return

	ssh -o ForwardX11=yes -o ForwardX11Trusted=yes ${1}
}

# With compressed X forwarding
_ssh_xc() {
	local USAGE_STRING="ssh-xc <host>"
	[[ -z "${1}" ]] && output usage "${USAGE_STRING}" && return

	ssh -o Compression=yes -o ForwardX11=yes -o ForwardX11Trusted=yes ${1}
}

# Create bash aliases of all the configured ssh hosts from ${BASH_ENV_FILE_SSH_CONFIG}
_setup_ssh_aliases() {
	awk -F ' ' '/^Host(\s){1,5}[a-z].*/ {print "alias " $2 "='"'"'ssh " $2 "'"'"'"}' ${BASH_ENV_FILE_SSH_CONFIG} > ${BASH_ENV_FILE_SSH_ALIAS}
	. ${BASH_ENV_FILE_SSH_ALIAS}
}

#### Functions: SSH ==final ####


#### Functions: Git ==start ####

# Git status
_g_gs() {
	git status
}

# Git fetch, git pull
_g_gu() {
	git fetch
	git pull
	git status
}

# Git commit all
_g_gca() {
	local USAGE_STRING="g-gca <commit message>"
	[[ -z "${1}" ]] && output usage "${USAGE_STRING}" && return

	git commit -a -m "${1}"
	git status
}

# Git push origin
_g_gpo() {
	# Array of options
	local ARRAY_USAGE_OPTIONS=(
	d
	t
	m
	p
	)

	# Create variable of pipe-separated options from array
	local USAGE_OPTIONS_STRING="$(echo ${ARRAY_USAGE_OPTIONS[@]} | sed 's/ /|/g')"

	# Array of branches
	local ARRAY_BRANCHES=(
	development
	testing
	master
	production
	)

	# Create variable of pipe-separated branches from array
	local BRANCHES_STRING="$(echo ${ARRAY_BRANCHES[@]} | sed 's/ /|/g')"

	case "${1}" in
		d)
			git push origin development
			;;
		t)
			git push origin testing
			;;
		m)
			git push origin master
			;;
		p)
			git push origin production
			;;
		*)
			output usage  "g-gpo <${USAGE_OPTIONS_STRING}> <${BRANCHES_STRING}>"
	esac
}

#### Functions: Git ==final ####


#### Functions: Net ==start ####

# Check URL
_net_curl() {
	_net_curl_usage() {
		output usage "net-curl -u <URL> [-x <proxy>]"
	}

	local OPTS=":hu:x:"
	local OPTIND h u x

	while getopts "${OPTS}" OPT; do
		case "${OPT}" in
			h)
				net-curl-usage
				;;
			u)
				local URL="${OPTARG}"
				;;
			x)
				local CURL_PROXY="${OPTARG}"
				;;
			:)
				output usage "ERROR: Option -${OPTARG} requires an argument"
				echo
				net-curl-usage
				;;
			\?)
				output usage "ERROR: Option -${OPTARG} is not a valid command line switch"
				echo
				net-curl-usage
				;;
			*)
				net-curl-usage
				break
				;;
		esac
	done

	shift $((OPTIND-1))

	if [[ -z "${URL}" ]]; then
		net-curl-usage
	else
		output usage "Using URL   : '${URL}'"

		if [[ -z "${CURL_PROXY}" ]]; then
			local CURL_PROXY_STRING=''
		else
			output usage "Using proxy : 'http://${CURL_PROXY}:8080'"
			local CURL_PROXY_STRING="-x http://${CURL_PROXY}:8080"
		fi
		echo

		curl -fLsvv ${CURL_PROXY_STRING} -o /dev/null "${URL}" 2>&1
		local CURL_EXIT="${?}"
		echo

		output usage "cURL exit code: ${CURL_EXIT}"
	fi
}

# Python webserver
_net_webserver() {
	# Array of options
	local ARRAY_USAGE_OPTIONS=(
	start
	stop
	)

	# Create variable of pipe-separated options from array
	local USAGE_OPTIONS_STRING="$(echo ${ARRAY_USAGE_OPTIONS[@]} | sed 's/ /|/g')"

	local USAGE_STRING="net-webserver <${USAGE_OPTIONS_STRING}>"
	[[ -z "${1}" ]] && output usage "${USAGE_STRING}" && return

	case "${1}" in
		start)
			if [[ "${WEBSERVER_RUNNING}" == "1" ]]; then
				output cyan "Webserver already running on port 8000"
			else
				# Start webserver
				{
					python -m SimpleHTTPServer &> /dev/null & disown
				}
				export WEBSERVER_PID="${!}"
				export WEBSERVER_RUNNING="1"
				output green "Webserver started on port 8000"
			fi
			;;
		stop)
			if [[ "${WEBSERVER_RUNNING}" != "1" ]]; then
				output yellow "Webserver not running"
			else
				kill -9 "${WEBSERVER_PID}"
				output red "Webserver stopped"
			fi
			;;
	esac
}

# Search a subnet for pinging IPs
_net_ping_subnet() {
	[[ -z "${1}" ]] && output usage "${USAGE_STRING}" && return
	local USAGE_STRING="net-ping-subnet <CIDR range>"

	# Return if fping is missing
	! hash fping && output error "fping not installed" && return

	output purple "Pinging subnet '${1}'"
	# Sort by IP octets
	fping -a -i 10 -r 1 -p 20 -t 250 -g ${1} 2> /dev/null | sort -t . -k 1,1n -k 2,2n -k 3,3n -k 4,4n
}

# Ping something 100 times and show a running average with printf
_net_ping_average() {
	local USAGE_STRING="net-ping-average <target> [<optional count, default 100>]"
	[[ -z "${1}" ]] && output usage "${USAGE_STRING}" && return

	# printf format used below
	local PF_FMT="%-7s %s"

	# Print header
	printf "${COLOR_FG_PRP}${PF_FMT}${COLOR_RESET}\n" "Count" "Average (ms)"

	# Use the 2nd argument (ping total) if present, if not present, default of 100
	local PING_COUNT_FINAL="${2-100}"

	# Init loop variables
	local PING_COUNT="0"
	local PING_TOTAL="0"
	local PING_AVERAGE="0"
	local PING_COLOR="${COLOR_FG_GRN}"

	# Print inital line so you have something to stare at before the first ping returns
	printf "${PING_COLOR}${PF_FMT}${COLOR_RESET}\r" "${PING_COUNT}" "${PING_AVERAGE}"

	# Loop until PING_COUNT reaches limit (PING_COUNT_FINAL)
	while [[ "${PING_COUNT}" -lt "${PING_COUNT_FINAL}" ]]; do
		# Ping host:
		# 1 ping
		# OS-specific ping timeout
		# pipe into awk to get ping time
		local PING_CURRENT=$(ping -c 1 ${PING_WAIT} ${1} 2> /dev/null | awk -F '[ =]' '/from/ {printf $10; printf " "}' | sed 's/ //g')

		# If the ping inside of PING_CURRENT variable didn't return,
		# set PING_CURRENT to be the current average so as to not skew
		# the results
		#
		# Also, set output color to green if PING_CURRENT is populated,
		# else, set to red
		local PING_COLOR="${COLOR_FG_GRN}"
		[[ -z "${PING_CURRENT}" ]] && local PING_CURRENT="${PING_AVERAGE}" && local PING_COLOR="${COLOR_FG_RED}"

		# Increment counter
		((PING_COUNT++))

		# Calculate total and average
		local PING_TOTAL=$(  echo "scale=5; ${PING_TOTAL}+${PING_CURRENT}" | bc)
		local PING_AVERAGE=$(echo "scale=5; ${PING_TOTAL}/${PING_COUNT}"   | bc)

		# Output string
		printf "${PING_COLOR}${PF_FMT}${COLOR_RESET}\r" "${PING_COUNT}" "${PING_AVERAGE}"
	done
	echo
}

# Ping something many times and output results in CSV for parsing
_net_ping_average_csv() {
	local USAGE_STRING="net-ping-average-csv <target> [<optional count, default 100>]"
	[[ -z "${1}" ]] && output usage "${USAGE_STRING}" && return

	# printf format used below
	local PF_FMT="%-7s %s"

	# Print header
	printf "${COLOR_FG_PRP}${PF_FMT}${COLOR_RESET}\n" "Count" "Average (ms)" 1>&2

	# Use the 2nd argument (ping total) if present, if not present, default of 100
	local PING_COUNT_FINAL="${2-100}"

	# Init loop variables
	local PING_COUNT="0"
	local PING_TOTAL="0"
	local PING_AVERAGE="0"
	local PING_COLOR="${COLOR_FG_YLW}"

	# Loop until PING_COUNT reaches limit (PING_COUNT_FINAL)
	while [[ "${PING_COUNT}" -lt "${PING_COUNT_FINAL}" ]]; do
		# Ping host:
		# 1 ping
		# OS-specific ping timeout
		# pipe into awk to get ping time
		local PING_CURRENT=$(ping -c 1 ${PING_WAIT} ${1} 2> /dev/null | awk -F '[ =]' '/from/ {printf $10; printf " "}' | sed 's/ //g')

		# If the ping inside of PING_CURRENT variable didn't return,
		# set PING_CURRENT to be the current average so as to not skew
		# the results
		#
		# Also, set output color to green if PING_CURRENT is populated
		[[ -z "${PING_CURRENT}" ]] && local PING_CURRENT="${PING_AVERAGE}"

		# Increment counter
		local PING_COUNT=$((PING_COUNT+1))

		# Calculate total and average
		local PING_TOTAL=$(  echo "scale=5; ${PING_TOTAL}+${PING_CURRENT}" | bc)
		local PING_AVERAGE=$(echo "scale=5; ${PING_TOTAL}/${PING_COUNT}"   | bc)

		# Output data string to stderr
		printf "${PING_COLOR}${PF_FMT}${COLOR_RESET}\r" "${PING_COUNT}" "${PING_AVERAGE}" 1>&2
	done
	echo -e "\n"             1>&2
	output purple "Results:" 1>&2

	# Output CSV string for passing to log
	echo "${PING_AVERAGE},${1}"
}

# Formats MAC address for all eventualities
_net_mac_format() {
	# Quit if nothing is entered
	local USAGE_STRING="net-mac-format <MAC address, any format>"
	[[ -z "${1}" ]] && output usage "${USAGE_STRING}" && return

	# Strip mac of anything other than 0-9, a-f, and A-F
	local CLEAN_MAC="${1//[^a-fA-F0-9 ]/}"

	# Check the length of the cleaned MAC address. It should be 12 characters.
	if [[ "${#CLEAN_MAC}" != "12" ]]; then
		output error "The provided MAC address, '${1}', was not the proper format (the string was '${CLEAN_MAC}' after sanitizing)"
		return
	fi

	# If the MAC entered is kosher, build out the variables
	# Lowercase
	local NONE_LOWER=$(  echo "${CLEAN_MAC}"  | tr '[:upper:]' '[:lower:]')
	local COLONS_LOWER=$(echo "${NONE_LOWER}" | sed -e 's/\([0-9A-Fa-f]\{2\}\)/\1:/g' -e 's/\(.*\):$/\1/')
	local DASHES_LOWER=$(echo "${NONE_LOWER}" | sed -e 's/\([0-9A-Fa-f]\{2\}\)/\1-/g' -e 's/\(.*\)-$/\1/')
	local SPACES_LOWER=$(echo "${NONE_LOWER}" | sed -e 's/\([0-9A-Fa-f]\{2\}\)/\1 /g' -e 's/\(.*\) $/\1/')

	# Uppercase
	local NONE_UPPER=$(  echo "${CLEAN_MAC}"  | tr '[:lower:]' '[:upper:]')
	local COLONS_UPPER=$(echo "${NONE_UPPER}" | sed -e 's/\([0-9A-Fa-f]\{2\}\)/\1:/g' -e 's/\(.*\):$/\1/')
	local DASHES_UPPER=$(echo "${NONE_UPPER}" | sed -e 's/\([0-9A-Fa-f]\{2\}\)/\1-/g' -e 's/\(.*\)-$/\1/')
	local SPACES_UPPER=$(echo "${NONE_UPPER}" | sed -e 's/\([0-9A-Fa-f]\{2\}\)/\1 /g' -e 's/\(.*\) $/\1/')

	# Set margin for printf commands
	local PF_FMT="${COLOR_FG_PRP}%-10s${COLOR_RESET}%-20s%s\n"

	# Output MAC address in various formats
	output purple "------------------------------ Formatted MAC --"
	printf "${PF_FMT}" "Colons" "${COLONS_LOWER}" "${COLONS_UPPER}"
	printf "${PF_FMT}" "Dashes" "${DASHES_LOWER}" "${DASHES_UPPER}"
	printf "${PF_FMT}" "Spaces" "${SPACES_LOWER}" "${SPACES_UPPER}"
	printf "${PF_FMT}" "None"   "${NONE_LOWER}"   "${NONE_UPPER}"

	# Perform IEEE MAC lookup
	echo
	net-mac-lookup "${COLONS_LOWER}"
}

# Look up MAC address against IEEE database
_net_mac_lookup() {
	# Check if oui npm package is installed
	if ! hash oui; then
		output error "oui not installed (via npm); cannot continue"
		return
	fi

	local USAGE_STRING="net-mac-lookup <MAC address with colons [at least first 3 octets]>"
	[[ -z "${1}" ]] && output usage "${USAGE_STRING}" && return

	local IEEE_STRING="$( oui ${1} | sed 's/,/ /g' | sed 's/  / /g' | sed ':a;N;$!ba;s/\n/,/g')"
	local IEEE_COMPANY="$(echo ${IEEE_STRING} | awk -F ',' '{print $1}')"
	local IEEE_ADDRESS="$(echo ${IEEE_STRING} | awk -F ',' '{print $2 ", " $3}')"
	local IEEE_COUNTRY="$(echo ${IEEE_STRING} | awk -F ',' '{print $4}')"

	local PF_FMT="${COLOR_FG_PRP}%-10s${COLOR_RESET}%s\n"

	output purple "-------------------------------- IEEE lookup --"
	printf "${PF_FMT}" "Company" "${IEEE_COMPANY}"
	printf "${PF_FMT}" "Address" "${IEEE_ADDRESS}"
	printf "${PF_FMT}" "Country" "${IEEE_COUNTRY}"
}

# Lookup DNS information
_net_dns_lookup() {
	local USAGE_STRING="net-dns-lookup <hostname/IP> <optional DNS server>"
	[[ -z "${1}" ]] && output usage "${USAGE_STRING}" && return

	local LOOKUP_INPUT="${1}"
	local LOOKUP_SERVER="${2}"

	# Set up command string to include server if passed
	local HOST_CMD_INPUT="host ${LOOKUP_INPUT} ${LOOKUP_SERVER}"

	# If alpha hostname, do lookup of hostname to get
	local LOOKUP_IP="${LOOKUP_INPUT}"
	[[ "${LOOKUP_INPUT}" == *[aA-zZ]* ]] &&  local LOOKUP_IP="$(${HOST_CMD_INPUT} | awk -F 'has address ' '/has address / {print $2}')"

	[[ -z "${LOOKUP_IP}" ]] && output yellow "Lookup of ${LOOKUP_INPUT} failed" && return

	output purple "--------------------------------- DNS lookup --"
	local HOST_CMD_IP="host ${LOOKUP_IP} ${LOOKUP_SERVER}"
	local LOOKUP_REVERSE=($(${HOST_CMD_IP} | awk -F 'domain name pointer ' '/domain name pointer / {print $2}' | sed 's/\.$//g'))

	# Set margin for printf commands
	local PF_FMT="${COLOR_FG_PRP}%-10s${COLOR_RESET}%s\n"

	# Set color output to red if failed
	local PF_FMT_REV="${PF_FMT}"
	[[ -z "${LOOKUP_REVERSE}" ]] && local LOOKUP_REVERSE="Failed" && local PF_FMT_REV="${COLOR_FG_PRP}%-10s${COLOR_FG_RED}%s${COLOR_RESET}\n"

	# Output returned data
	printf "${PF_FMT}" "Input" "${LOOKUP_INPUT}"
	[[ "${LOOKUP_SERVER}"  ]] && printf "${PF_FMT}" "Server" "${LOOKUP_SERVER}"

	if [[ "${LOOKUP_REVERSE}" ]]; then
		# Loop through array of reverse DNS lookup entries
		for ENTRY in ${LOOKUP_REVERSE[@]}; do
			printf "${PF_FMT_REV}" "Reverse" "${ENTRY}"
		done
	fi

	printf "${PF_FMT}" "Forward" "${LOOKUP_IP}"
}

#### Functions: Net ==final ####


#### Functions: Fix ==start ####

# Fix hung java processes
_fix_hung_java() {
	local JAVA_PIDS=($(ps -ef | awk '/[j]ava/ {print $2}'))
	[[ -z "${JAVA_PIDS}" ]] && output yellow "No Java PIDs detected" && return

	for PID in ${JAVA_PIDS[@]}; do
		if ! kill -9 ${PID} &> /dev/null; then
			output red "Failed to kill Java PID ${PID}"
		else
			output green "Killed Java PID ${PID}"
		fi
	done
}

# Stale bash threads fix
_fix_bash_pids() {
	# Array of options
	local ARRAY_USAGE_OPTIONS=(
	show
	kill
	)

	# Create variable of pipe-separated options from array
	local USAGE_OPTIONS_STRING="$(echo ${ARRAY_USAGE_OPTIONS[@]} | sed 's/ /|/g')"

	local FIX_BASH_PIDS_PID_LIST=($(ps aux | grep -E '[b]ash' | grep -Ev 'root|s00\.' | sort -r | awk '{print $2}'))
	local FIX_BASH_PIDS_PID_COUNT="${#FIX_BASH_PIDS_PID_LIST[@]}"

	output purple "Number of stale bash PIDs: ${FIX_BASH_PIDS_PID_COUNT}"

	if [[ ! "${FIX_BASH_PIDS_PID_COUNT}" == "0" ]]; then
		case "${1}" in
			show)
				output purple "PID list:"
				for PID in "${FIX_BASH_PIDS_PID_LIST[@]}"; do
					output yellow "${PID}"
				done
				;;
			kill)
				read -p "Kill stale bash PIDs? Enter Y/N: " FIX_BASH_PIDS_YN

				if [[ "${FIX_BASH_PIDS_YN}" != [Yy] ]]; then
					output purple "No PIDs killed"
				else
					for PID in ${FIX_BASH_PIDS_PID_LIST[@]}; do
						output yellow "Killing PID ${PID}"
						kill -9 ${PID}
					done

					output green "Complete"

					# Check the PIDs again
					fix-bash-pids show
				fi
				;;
			*)
				output usage "fix-bash-pids <${USAGE_OPTIONS_STRING}>"
				;;
		esac
	fi
}

# Remove / clean macOS .DS_Store / attribute files
_fix_osx_files() {
	output purple "Finding all macOS metadata files under '${PWD}'"

	# Backup current IFS, change IFS to \n\b so as to parse file array
	local OLD_IFS="${IFS}"
	IFS=$(echo -en "\n\b")

	# File array of macOS-specific junk files
	local FILES_TO_REMOVE=($(find . -iname '*DS_Store' -o -iname '._*'))

	# Restore previous IFS
	IFS="${OLD_IFS}"

	[[ -z "${FILES_TO_REMOVE}" ]] && output purple "No macOS attribute/Finder files under '${PWD}' to remove" && return

	output yellow "Removing these macOS attribute/Finder files under '${PWD}':"

	echo
	for FILE in "${FILES_TO_REMOVE[@]}"; do
		output yellow "${FILE}"
	done
	echo

	read -p "Are you sure you want to remove these files? Enter Y/N: " FIX_MACOS_FILES_YN
	echo

	if [[ "${FIX_MACOS_FILES_YN}" != [Yy] ]]; then
		output purple "No macOS attribute/Finder files under '${PWD}' removed"
	else
		for FILE in "${FILES_TO_REMOVE[@]}"; do
			output yellow "Removing '${FILE}'"
			rm -f "${FILE}"
		done
		echo

		output green "All macOS attribute/Finder files under '${PWD}' removed"
	fi
}

#### Functions: Fix ==final ####


#### Functions: Find ==start ####

# Find file function
# Case insensitive, double wildcard search of CURRENT dir
_find_file() {
	local USAGE_STRING="find-file <filename>"
	[[ -z "${1}" ]] && output usage "${USAGE_STRING}" && return

	output usage "Finding '${1}' in '${PWD}'"
	find . -iname "*${1}*" | sed 's/ /\\ /g' | sed 's/\[/\\\[/g' | sed 's/\]/\\\]/g' |sed 's/(/\\(/g' | sed 's/)/\\)/g' | sed 's/-/\\-/g' | sed "s/'/\\\'/g" | sed 's/!/\\!/g' | sed 's/&/\\\&/g' | sed 's/,/\\\,/g' | sed 's/\$/\\\$/g'
}

# Find ${COUNT} largest items in current directory
_find_largest() {
	local COUNT="10"
	output stderr "Searching for ${COUNT} largest items in '${PWD_FINAL}'"
	output stderr " "

	du -hs * | sort -hr | head -n 10
}

#### Functions: Find ==final ####


#### Functions: Show ==start ####

# Check if an executable exists, if so, show info about it
_show_bin() {
	if ! hash "${1}"; then
		output error "Could not find '${1}' in defined PATH"
		return 1
	fi

	# Get full file path, type, and MIME encoding/type
	local FILE_PATH="$(which --skip-alias --skip-functions ${1})"
	local FILE_TYPE="$(file -bNn                             ${FILE_PATH})"
	local FILE_MIME="$(file -bNn --mime-encoding --mime-type ${FILE_PATH})"

	# Detect GNU ls or stock macOS ls to enable color output properly
	[[ "${MACOS_GNU}" || "${UNAME_KERNEL_NAME}" == "Linux" ]] && local LS='ls -hl --color=auto' || local LS='ls -Ghl'
	${LS} ${FILE_PATH} 2> /dev/null
	echo

	output green "Name : '${1}'"
	output blue  "Path : '${FILE_PATH}'"
	output blue  "Type : '${FILE_TYPE}'"
	output blue  "MIME : '${FILE_MIME}'"
}

# Show a clock
_show_clock() {
	date '+%a %b %d %Y %r | %F %R:%S | %:z (%Z)'
}

# Show a continuous clock
_show_clock_loop() {
	while true; do
		echo -ne "$(date '+%a %b %d %Y %r | %F %R:%S | %:z (%Z)')   \r"
		sleep 1
	done
}

# Show all of the bash colors
_show_colors() {
	echo " 30-37 : foreground color"
	echo " 40-47 : background color"
	echo " 1     : bold"
	echo " 2     : dim"
	echo " 4     : underline"
	echo " 5     : flashing"
	echo " 7     : inverted"
	echo

	# Foreground colors
	for COLORS_FOREGROUND in {30..37}; do
		# No background
		local COLOR_VALS="${COLORS_FOREGROUND:+$COLORS_FOREGROUND;}"
		local COLOR_VALS="${COLOR_VALS%%;}"
		local SEQUENCE="${COLOR_VALS:+\e[${COLOR_VALS}m}"

		printf " %-6s" "${SEQUENCE:-(default)}"
		printf " ${SEQUENCE}text\e[m"
		printf " \e[${COLOR_VALS:+${COLOR_VALS+$COLOR_VALS;}}1mbold\e[m"

		# Flashing
		local COLOR_VALS="${COLORS_FOREGROUND:+$COLORS_FOREGROUND;}5"
		local COLOR_VALS="${COLOR_VALS%%;}"
		local SEQUENCE="${COLOR_VALS:+\e[${COLOR_VALS}m}"

		printf " %-6s" "${SEQUENCE:-(default)}"
		printf " ${SEQUENCE}text\e[m"
		printf " \e[${COLOR_VALS:+${COLOR_VALS+$COLOR_VALS;}}1mbold\e[m"

		# Background colors
		for COLORS_BACKGROUND in {40..47}; do
			# White
			local COLORS_FOREGROUND=${COLORS_FOREGROUND#37}

			# Black
			local COLOR_VALS="${COLORS_FOREGROUND:+$COLORS_FOREGROUND;}${COLORS_BACKGROUND}"
			local COLOR_VALS="${COLOR_VALS%%;}"
			local SEQUENCE="${COLOR_VALS:+\e[${COLOR_VALS}m}"

			printf " %-9s" "${SEQUENCE:-(default)}"
			printf " ${SEQUENCE}text\e[m"
			printf " \e[${COLOR_VALS:+${COLOR_VALS+$COLOR_VALS;}}1mbold\e[m"
		done
		echo
	done
}

# Show most frequently executed commands
_show_top_cmds() {
	if [[ -s ${HISTFILE} ]]; then
		local BASH_HISTORY_CMDS="$(grep -cv '#' ${HISTFILE})"
		local COUNT="15"

		output usage  "Bash history length: ${BASH_HISTORY_CMDS} commands"
		output purple "-- Top commands --"
		echo

		grep -v '#' ${HISTFILE} | sort | uniq -c | sort -rn | head -n ${COUNT}
	else
		output error "bash history file missing or empty"
	fi
}

# Function to get the length of the longest string in an array
_show_array_width() {
	if [[ -z "${1}" ]]; then
		output usage "show-array-width array[@]"
		output error "NOTICE how there are NO curly brackets or quotes when you pass the variable"
		output error "Don't say I didn't warn you"
		return
	fi

	declare -a ARRAY=("${!1}")

	for STRING in ${ARRAY[@]}; do
		local STRING_LENGTH=${#STRING}
		[[ "${STRING_LENGTH}" -gt "${LONGEST_LENGTH}" ]] && local LONGEST_LENGTH="${STRING_LENGTH}"
	done

	# Add 1 to the length
	((LONGEST_LENGTH++))
	echo "${LONGEST_LENGTH}"
}

#### Functions: Show ==final ####


#### Functions: PS1/bashrc ==start ####

# Create ps1 prompt and do every-5-min timestamp
_prompt_generate() {
	export PROMPT_DIRTRIM="2"
	# Get the current directory, swap out the home directory with a tilde
	export PWD_FMT=${PWD/${HOME}/\~}

	# Here we modify the pwd string to shorten the display
	# Find how many folders deep we are
	export PWD_FMT_DEPTH="$(echo ${PWD_FMT} | awk -F '/' '{print NF-1}')"

	# If we're LESS than 3 folders deep, pwd for titlebar and prompt is normal
	# If we're MORE than 3 folders deep, show ../previous_dir/current_dir
	export PWD_CUSTOM=$(printf "${PWD_FMT}" | rev | awk -F '/' '{printf $1"/"$2"/.."}' | rev)
	[[ "${PWD_FMT_DEPTH}" -lt "3" ]] && export PWD_FINAL="${PWD_FMT}" || export PWD_FINAL="${PWD_CUSTOM}"

	# Generate titlebar text string
	local TITLEBAR_TEXT="${HOST_SHORT}:${PWD_FINAL}"

	# Only apply custom titlebar if we're in xterm
	[[ "${TERM}" == *"xterm"* ]] && echo -en "\e]0;${TITLEBAR_TEXT}\007"

	# Generate / export PS1 prompt with color specfied by BASH_ENV_COLOR
	# It would also be neat to do a color-responsive system load monitor... but not today
	#export PS1="${COLOR_BOLD}┌[${COLOR_RESET} \[${BASH_ENV_COLOR_BOLD}\]${HOST_SHORT}\[${COLOR_RESET}\]:\[${COLOR_FG_BOLD_BLU}\]${PWD_FINAL}\[${COLOR_RESET}\]\[${BASH_ENV_COLOR_BOLD}\]\[${COLOR_RESET}\] ${COLOR_BOLD}]\n└> "
	#export PS1="${BASH_ENV_COLOR_BOLD}╔╣${COLOR_RESET}\[${BASH_ENV_COLOR_BOLD}\]${HOST_SHORT}\[${COLOR_RESET}\]:\[${COLOR_FG_BOLD_BLU}\]${PWD_FINAL}\[${COLOR_RESET}\]\[${BASH_ENV_COLOR_BOLD}\]\[${COLOR_RESET}\]${BASH_ENV_COLOR_BOLD}\n╚═${COLOR_RESET} "

	# Older full PS1
	export PS1="\[${BASH_ENV_COLOR}\]${HOST_SHORT}\[\e[0m\]:\[\e[34m\]${PWD_FINAL} \[${BASH_ENV_COLOR}\]\\$\[\e[0m\] "
}

# Dynamic MOTD with facter (if present)
_show_motd() {
	# Use facter if possible, if not, too bad..
	if ! hash facter; then
		echo "Facter not installed; dynamic MOTD not possible"
		echo
		return 1
	fi

	# Generate the OS info string differently, based on OS
	local OS_FAMILY="$(facter os.family)"
	case ${OS_FAMILY} in
		Darwin)
			local DST="macOS"
			local VER="$(facter os.macosx.version.major)"
			;;
		Debian)
			local DST="$(facter os.distro.id)"
			local VER="$( facter os.release.major)"
			;;
		RedHat)
			local DST="$(facter os.name)"
			case "$(facter os.distro.id)" in
				CentOS|RedHat*)
					local VER="$(facter os.release.major).$(facter os.release.minor)"
					;;
				Fedora)
					local VER="$(facter os.release.major)"
					;;
				*)
					local VER="$(facter os.release.full)"
					;;
			esac
	esac

	# Get CPU, RAM, uptime, sysload, perhaps do some formatting
	local CPU="$( facter processors.models.0 | sed -r -e 's/(^\s?)|(\s?CPU)|(\s?@)|(\s?Processor)|(\(.?.?\))|(\s?[0-9]\.[0-9]{1,3}GHz\s?)|(\s[0-9]\s)|(Intel\(..?\)\sCore\(..?\)\s?)|Intel\sCore\s|\(|\)|Intel\(..?\)\s|Atom|Xeon|\sv[1-9]|\s//g' -e 's/(\s)+/\ /g')"
	local RAM="$( facter memory.system.total)"
	local RAMC="$(facter memory.system.capacity)"
	local UPT="$( facter uptime)"
	local LOAD="$(facter load_averages.5m)"

	# kdm bash-env git hash/revision info
	local OLD_PWD="${PWD}"
	local HASH="#$(cd ${HOME}; git log --pretty=format:'%h' -n 1; cd ${OLD_PWD})"
	local REV="v$(awk -F ',' '{print $1}' ${BASH_ENV_FILE_REV})"

	# Format a couple things
	local UPT="${UPT:0:8}"
	local UPT="${UPT/\ hou/}"
	local UPT="${UPT/\ ho/}"
	local LOAD="${LOAD:0:4}"
	local RAMC="${RAMC%%.*}%"
	local RAM="${RAM%%.*}G/${RAMC}"

	# Find longest string in array for dynamic width
	local ARRAY_VALUES=(
	"bash-env"
	"${HASH}"
	"${REV}"
	"${CPU}"
	"${RAM}"
	"${DST}"
	"${VER}"
	"${UPT}"
	"${LOAD}"
	)

	# Find the length of the longest string among the values
	for STRING in "${ARRAY_VALUES[@]}"; do
		local STRING_LENGTH=${#STRING}

		# If the current string is longer than MAX_LEN, set MAX_LEN to the current string's length
		[[ "${STRING_LENGTH}" -gt "${MAX_LEN}" ]] && local MAX_LEN="${STRING_LENGTH}"

		# Quick dirty check if data exists
		if [[ -z "${STRING}" ]]; then
			echo "Failed evaluating data; dynamic MOTD not possible"
			echo
			return 2
		fi
	done

	# Example output:
	#
	# kdm > bash-env | #8af151d < v749
	# cpu >  i7-3770 | 16G      < ram
	#  os >    macOS | 10.11    < ver
	#  up >     1:04 | 1.28     < load

	# Set up printf format strings with BASH_ENV_COLOR
	# PF_FMT_KEY : Outer strings, on far left or right

	# Color shortcuts
	local CLR_ENV="${BASH_ENV_COLOR_BOLD}"
	local CLR_BLU="${COLOR_FG_BOLD_BLU}"
	local CLR_BLK="${COLOR_FG_BOLD_BLK}"
	local CLR_RST="${COLOR_RESET}"

	local ARROW_L="${CLR_BLK}<${CLR_RST}"
	local ARROW_R="${CLR_BLK}>${CLR_RST}"
	local BAR="${CLR_BLK}|${CLR_RST}"

	local BASE_KEY="%s${CLR_RST}"
	local BASE_VAL1="%+${MAX_LEN}s${CLR_RST}"
	local BASE_VAL2="%-${MAX_LEN}s${CLR_RST}"

	local MOTD_KEY="${CLR_BLU}${BASE_KEY}"
	local MOTD_VAL1="${CLR_ENV}${BASE_VAL1}"
	local MOTD_VAL2="${CLR_ENV}${BASE_VAL2}"

	local HEAD_KEY="${CLR_ENV}${BASE_KEY}"
	local HEAD_VAL1="${CLR_BLU}${BASE_VAL1}"
	local HEAD_VAL2="${CLR_BLU}${BASE_VAL2}"

	# Assemble format strings
	local HEAD_FMT="${HEAD_KEY} ${ARROW_R} ${HEAD_VAL1} ${BAR} ${HEAD_VAL2} ${ARROW_L} ${HEAD_KEY}\n"
	local MOTD_FMT="${MOTD_KEY} ${ARROW_R} ${MOTD_VAL1} ${BAR} ${MOTD_VAL2} ${ARROW_L} ${MOTD_KEY}\n"

	# Output the header line, then the MOTD
	printf "${HEAD_FMT}" "kdm" "bash-env" "${HASH}" "${REV}"
	printf "${MOTD_FMT}" "cpu"   "${CPU}" "${RAM}"  "ram"
	printf "${MOTD_FMT}" " os"   "${DST}" "${VER}"  "ver"
	printf "${MOTD_FMT}" " up"   "${UPT}" "${LOAD}" "load"

	echo
}

#### Functions: PS1/bashrc ==final ####


#### Functions: kdm-bash-env ==start ####

# Help with/list bashrc functions
_kdm_help() {
	output purple "kdm bash-env functions:"
	echo

	local BASHRC_CMDS=($(grep -o 'alias\ .*.='  ${BASH_ENV_FILE_BASHRC} | sort -u | awk -F '[ =]' '{print $2}' | sort -u | sed -r '/^.{,3}$/d' | grep -Ev 'pign|tial|namp|mkdir|grep|grpe|ehco|clean|CMD|^config|^log|^html\-|^xml\-|^json\-|lsusb|md5sum'))

	# macOS commands
	if [[ "${UNAME_KERNEL_NAME}" == "Darwin" ]]; then
		for CMD in ${BASHRC_CMDS[@]}; do
			echo ${CMD}
		done | grep -Ev '^sys\-restart|^kvm\-'
	fi

	# Linux commands
	if [[ "${UNAME_KERNEL_NAME}" == "Linux" ]]; then
		for CMD in ${BASHRC_CMDS[@]}; do
			echo ${CMD}
		done | grep -Ev '^osx\-|^net\-listening|efi\-mount'
	fi
	echo
}

# Quick-draw pull bash env
_kdm_pull() {
	# Save current PWD
	local OLD_PWD=${PWD}
	cd ${HOME}

	output purple "Fetching superproject"
	if ! git fetch &> /dev/null; then
		output red "Failed fetching superproject"
		return
	fi

	# Check if there is an update
	if [[ "$(git log HEAD..origin/master --oneline 2>&1)" ]]; then
		# Perform git pull
		output yellow "Updating superproject"

		if ! git pull origin master &> /dev/null; then
			output red "Failed updating superproject"
			return
		fi
		output green "Superproject updated"
	else
		output cyan "No superproject update available"
	fi

	if ! git submodule update --init &> /dev/null; then
		output red "Failed updating submodules"
		return
	fi
	output green "Submodules updated"

	cd ${OLD_PWD}
}

#### Functions: kdm-bash-env ==final ####


#### Functions: Updates ==start ####

# Update all the things (except CPAN)
_update_all() {
	# Check 1st argument
	if [[ "${1}" != "-y" ]]; then
		# Check if they're sure
		read -p "Are you sure? Enter Y/N: " UPDATE_YN
		# Exit if they're not
		[[ "${UPDATE_YN}" != [Yy] ]] && output cyan "No updates performed" && return
	fi

	# Bounce if we couldn't find a supported package manager
	if [[ -z "${PACKAGE_MANAGER}" ]]; then
		output error "Could not detect package manager; cannot continue"
		return 1
	fi

	# Assemble array of command strings based on type of package manager
	unset ARRAY_COMMANDS
	case "${PACKAGE_MANAGER}" in
		"apt-get")
			local ARRAY_COMMANDS[0]="sudo ${PACKAGE_MANAGER} update"
			local ARRAY_COMMANDS[1]="sudo ${PACKAGE_MANAGER} -y upgrade"
			local ARRAY_COMMANDS[2]="sudo ${PACKAGE_MANAGER} -y dist-upgrade"
			;;
		"brew")
			local ARRAY_COMMANDS[0]="${PACKAGE_MANAGER} update"
			local ARRAY_COMMANDS[1]="${PACKAGE_MANAGER} upgrade --cleanup"
			# macOS software update
			local ARRAY_COMMANDS[2]="sudo softwareupdate -i -a"
			;;
		"yum")
			local ARRAY_COMMANDS[0]="sudo ${PACKAGE_MANAGER} -y update"
			local ARRAY_COMMANDS[1]="sudo ${PACKAGE_MANAGER} -y upgrade"
			;;
		"zypper")
			local ARRAY_COMMANDS[0]="sudo ${PACKAGE_MANAGER} -n update"
			;;
		*)
			local ARRAY_COMMANDS[0]="sudo ${PACKAGE_MANAGER} -y update"
			;;
	esac

	# Perform update commands
	for COMMAND in "${ARRAY_COMMANDS[@]}"; do
		output leadup "${COMMAND}"
		! ${COMMAND} &> /dev/null && output failure || output success
	done

	# Cleanup old kernels if possible (only with yum-utils installed)
	if hash package-cleanup; then
		local COMMAND="package-cleanup -y --oldkernels --count=2"
		output leadup "${COMMAND}"
		! ${COMMAND} &> /dev/null && output failure || output success
	fi

	# Raspberry Pi firmware update
	if hash rpi-update; then
		local COMMAND="rpi-update"
		output leadup "${COMMAND}"
		! ${COMMAND} &> /dev/null && output failure || output success
	fi

	# Update kdm-bash-env from Git
	if hash kdm-pull; then
		local COMMAND="kdm-pull"
		output leadup "${COMMAND}"
		if ! ${COMMAND} &> /dev/null; then output failure; else output success; break; fi
	fi

	# Check for npm, if it exists, update npm packages
	if hash npm; then
		# Loop npm update until it's fully updated, up to 5 times
		local COMMAND="npm -g update"

		local NPM_UPDATE_COUNT="1"
		while [[ "${NPM_UPDATE_COUNT}" -le "5" ]]; do
			output leadup "${COMMAND} (loop #${NPM_UPDATE_COUNT})"
			! ${COMMAND} &> /dev/null && output failure || output success; break

			# Increment loop counter
			((NPM_UPDATE_COUNT++))
		done
	fi

	# Check for python-pip, if it exists, update python-pip packages
	if hash pip; then
		# Array of pip packages to update, with pip and setuptools being first
		local COMMAND="pip list -o"
		output leadup "${COMMAND}"
		local ARRAY_PIP_PACKAGES=(pip setuptools $(pip list -o | awk '$0 !~ /pip|setuptools/ {print $1}'))
		output success

		# Perform update commands
		for PIP_PACKAGE in "${ARRAY_PIP_PACKAGES[@]}"; do
			local COMMAND="pip install --upgrade ${PIP_PACKAGE}"
			output leadup "${COMMAND}"
			! ${COMMAND} &> /dev/null && output failure || output success
		done
	fi

	# rubygems update
	if hash update_rubygems; then
		# Array of update commands
		unset ARRAY_COMMANDS
		local ARRAY_COMMANDS[0]="update_rubygems"
		local ARRAY_COMMANDS[1]="gem update  --silent --system"
		local ARRAY_COMMANDS[2]="gem update  --silent"
		local ARRAY_COMMANDS[3]="gem cleanup --silent"

		# Perform update commands
		for COMMAND in "${ARRAY_COMMANDS[@]}"; do
			output leadup "${COMMAND}"
			! ${COMMAND} &> /dev/null && output failure || output success
		done
	fi

	output green "update-all complete"
	return 0
}

# Update just CPAN packages
_update_cpan() {
	# Check 1st argument
	if [[ "${1}" != "-y" ]]; then
		# Check if they're sure
		read -p "Are you sure? Enter Y/N: " UPDATE_YN
		[[ "${UPDATE_YN}" != [Yy] ]] && output cyan "update-cpan not performed" && return
	fi

	# Bounce if we couldn't find a supported package manager
	if [[ -z "${PACKAGE_MANAGER}" ]]; then
		output error "Could not detect package manager; cannot continue"
		return 1
	fi
	# Install CPAN if missing
	if ! hash cpan; then
		local COMMAND="${PACKAGE_MANAGER} -y install perl-CPAN perl-App-cpanminus cpanminus"
		output leadup "${COMMAND}"
		! ${COMMAND} &> /dev/null && output failure || output success
	fi

	# Update CPAN itself, and YAML
	unset ARRAY_COMMANDS
	local ARRAY_COMMANDS[0]="cpan CPAN"
	local ARRAY_COMMANDS[1]="cpan YAML"
	for COMMAND in "${ARRAY_COMMANDS[@]}"; do
		output leadup "${COMMAND}"
		! ${COMMAND} &> /dev/null && output failure || output success
	done

	# Check for cpanm, install if missing
	if ! hash cpanm; then
		local ARRAY_COMMANDS[0]="sudo ${PACKAGE_MANAGER} -y install cpanminus"
		local ARRAY_COMMANDS[1]="cpan App::cpanminus"
		for COMMAND in "${ARRAY_COMMANDS[@]}"; do
			output leadup "${COMMAND}"
			! ${COMMAND} &> /dev/null && output failure || output success
		done
	fi

	# Check for cpan-outdated, install if missing
	if ! hash cpan-outdated; then
		local COMMAND="cpan App::cpanoutdated"
		output leadup "${COMMAND}"
		! ${COMMAND} &> /dev/null && output failure || output success
	fi

	# Check for cpanm and cpanm-outdated again
	if ! hash cpanm && hash cpan-outdated; then
		output error "cpanminus and cpan-outdated could not be found; cannot continue"
		return 1
	fi

	# Update outdated CPAN modules
	local COMMAND="cpan-outdated -p | cpanm"
	output leadup "${COMMAND}"
	# Custom due to command pipe
	! cpan-outdated -p | cpanm &> /dev/null && output failure || output success

	output green "update-cpan complete"
	return 0
}

#### Functions: Updates ==final ####


#### Functions: macOS-only (regardless of GNU conversion) ==start ####

if [[ "${UNAME_KERNEL_NAME}" == "Darwin" ]]; then
	# Function aliases
	alias osx-hostname='_osx_hostname'
	alias osx-itunes='_osx_itunes'
	alias osx-notify='_osx_notify'
	alias osx-repair-office='_osx_repair-office'
	alias osx-volume='_osx_volume'

	# Hostname change function
	_osx_hostname() {
		local USAGE_STRING="osx-hostname <new hostname>"
		[[ -z "${1}" ]] && output usage "${USAGE_STRING}" && return

		local LOCAL_HOST_NAME="$(echo ${1} | awk -F '.' '{print $1}')"
		sudo scutil --set LocalHostName "${LOCAL_HOST_NAME}"
		sudo scutil --set ComputerName "${1}"
		sudo scutil --set HostName "${1}"
		output green "Hostname set to ${1}"
	}

	# iTunes control
	_osx_itunes() {
		# Array of options
		local ARRAY_USAGE_OPTIONS=(
		pause
		next
		prev
		)

		# Create variable of pipe-separated options from array
		local USAGE_OPTIONS_STRING="$(echo ${ARRAY_USAGE_OPTIONS[@]} | sed 's/ /|/g')"

		local USAGE_STRING="osx-itunes <${USAGE_OPTIONS_STRING}>"
		[[ -z "${1}" ]] && output usage "${USAGE_STRING}" && return

		case "${1}" in
			pause)
				osascript -e 'tell application "iTunes"' -e 'playpause' -e 'end tell'
				output green "Playback toggled"
				;;
			play)
				osascript -e 'tell application "iTunes"' -e 'playpause' -e 'end tell'
				output green "Playback toggled"
				;;
			next)
				osascript -e 'tell application "iTunes"' -e 'next track' -e 'end tell'
				output green "Skipped to next track"
				;;
			prev)
				osascript -e 'tell application "iTunes"' -e 'previous track' -e 'end tell'
				output green "Skipped to previous track"
				;;
		esac

		local ITUNES_NAME="$(osascript -e 'tell application "iTunes"' -e 'get name of current track' -e 'end tell')"
		local ITUNES_ARTIST="$(osascript -e 'tell application "iTunes"' -e 'get artist of current track' -e 'end tell')"
		local ITUNES_ALBUM="$(osascript -e 'tell application "iTunes"' -e 'get album of current track' -e 'end tell')"

		echo
		output cyan "Currently playing:"
		echo
		output purple "Name:   ${ITUNES_NAME}"
		output purple "Artist: ${ITUNES_ARTIST}"
		output purple "Album:  ${ITUNES_ALBUM}"
	}

	# Volume config function
	_osx_volume() {
		# Array of options
		local ARRAY_USAGE_OPTIONS=(
		mute
		max
		up
		down
		[0-100]
		)

		# Create variable of pipe-separated options from array
		local USAGE_OPTIONS_STRING="$(echo ${ARRAY_USAGE_OPTIONS[@]} | sed 's/ /|/g')"

		local VOLUME_CURRENT="$(osascript -e 'output volume of (get volume settings)')"
		local VOLUME_MUTE="$(osascript -e 'get output muted of (get volume settings)')"
		local VOLUME_SOUND_EFFECT="/System/Library/LoginPlugins/BezelServices.loginPlugin/Contents/Resources/volume.aiff"

		if [[ -z "${1}" ]]; then
			output usage "osx-volume <${USAGE_OPTIONS_STRING}>"
			echo
			output green "Current volume: ${VOLUME_CURRENT}%"
			output green "Mute status:    ${VOLUME_MUTE}"
			return
		fi

		case "${1}" in
			mute)
				if [[ "${VOLUME_MUTE}" == "false" ]]; then
					osascript -e 'set volume with output muted'
					output red "Volume muted"
				else
					osascript -e 'set volume without output muted'
					output green "Volume unmuted"
				fi
				;;
			max)
				osascript -e 'set volume output volume 100'
				output green "Volume set to 100%"
				;;
			up)
				if [[ "${VOLUME_CURRENT}" -lt "95" ]]; then
					osascript -e "set volume output volume $((VOLUME_CURRENT+5))"
					output green "Volume set to $((VOLUME_CURRENT+5))%"
				elif [[ "${VOLUME_CURRENT}" -ge "95" && "${VOLUME_CURRENT}" -lt "100" ]]; then
					osascript -e 'set volume output volume 100'
					output green "Volume set to 100%"
				else
					output red "Volume is already set to ${VOLUME_CURRENT}%"
				fi
				;;
			down)
				if [[ "${VOLUME_CURRENT}" -gt "5" ]]; then
					osascript -e "set volume output volume $((VOLUME_CURRENT-5))"
					output green "Volume set to $((VOLUME_CURRENT-5))%"
				elif [[ "${VOLUME_CURRENT}" -le "5" && "${VOLUME_CURRENT}" -gt "0" ]]; then
					osascript -e 'set volume output volume 0'
					output green "Volume set to 0%"
				else
					output red "Volume is already set to ${VOLUME_CURRENT}%"
				fi
				;;
			*)
				local VOLUME_CLEAN="${1//[^0-9]}"
				if [[ "${#VOLUME_CLEAN}" == "0" || "${#VOLUME_CLEAN}" -gt "100" ]]; then
					output red "Invalid volume entered"
				else
					osascript -e "set volume output volume ${VOLUME_CLEAN}"
					output green "Volume set to ${VOLUME_CLEAN}%"
				fi
				;;
		esac

		# Play volume change sound effect
		{
			afplay "${VOLUME_SOUND_EFFECT}" & disown
		} &> /dev/null
	}

	# Reset all Office Mac 2011 files
	_osx_repair_office() {
		# Check if they're sure
		read -p "Are you sure? Enter Y/N: " RESET_YN

		[[ "${RESET_YN}" != [Yy] ]] && output purple "No changes" && return

		output red "Resetting all Microsoft Office data"
		rm -rf                                                                                                                                \
			${HOME}/Documents/Microsoft\ User\ Data                                                                                             \
			${HOME}/Library/Application\ Support/CrashReporter/Microsoft*                                                                       \
			${HOME}/Library/Application\ Support/Microsoft                                                                                      \
			${HOME}/Library/Application\ Support/com.apple.sharedfilelist/com.apple.LSSharedFileList.ApplicationRecentDocuments/com.microsoft.* \
			${HOME}/Library/Caches/Microsoft                                                                                                    \
			${HOME}/Library/Caches/com.apple.helpd/Generated/com.microsoft.*                                                                    \
			${HOME}/Library/Caches/com.apple.helpd/SDMHelpData/Other/English/HelpSDMIndexFile/com.microsoft.*                                   \
			${HOME}/Library/Caches/com.microsoft.*                                                                                              \
			${HOME}/Library/Preferences/Microsoft                                                                                               \
			${HOME}/Library/Preferences/com.microsoft.* &> /dev/null

		defaults delete com.microsoft.Outlook &> /dev/null
		killall cfprefsd                      &> /dev/null
		output green "Complete; you should reboot, preferably"
	}

	_osx_notify() {
		local NOTIFY_TITLE="${1}"
		local NOTIFY_MESSAGE="${2}"
		local NOTIFY_SUBTITLE="${3}"

		local USAGE_STRING="osx-notify <title> <message> [<subtitle>]"
		[[ -z "${NOTIFY_TITLE}" || -z "${NOTIFY_MESSAGE}" ]] && output usage "${USAGE_STRING}" && return

		# Add subtitle to osascript string if present
		[[ "${NOTIFY_SUBTITLE}" ]] && local NOTIFY_SUBTITLE="subtitle \"${NOTIFY_SUBTITLE}\""

		osascript -e "display notification \"${NOTIFY_MESSAGE}\" with title \"${NOTIFY_TITLE}\" ${NOTIFY_SUBTITLE}"
	}

fi

#### Functions: macOS-only (regardless of GNU conversion) ==start ####


#### Functions: Linux-only ==start ####

if [[ "${UNAME_KERNEL_NAME}" == "Linux" ]]; then
	# Function aliases
	alias kvm-destroy-all='_kvm_destroy-all'
	alias kvm-running='_kvm_running'
	alias kvm-shutdown-all='_kvm_shutdown-all'
	alias kvm-start-all='_kvm_start-all'
	alias kvm-undefine='_kvm_undefine'
	alias kvm-watch='_kvm_watch'
	alias sys-restart='_sys_restart'

	# Restart with systemctl
	_sys_restart() {
		local USAGE_STRING="sys-restart <process name>"
		[[ -z "${1}" ]] && output usage "${USAGE_STRING}" && return

		! hash systemctl && output error "systemctl not available; perhaps this is not a systemd-enabled OS" && return

		output yellow "Stopping '${1}'"
		systemctl stop ${1}

		output yellow "Sleeping"
		sleep 1

		output yellow "Starting '${1}'"
		systemctl start ${1}

		echo
		systemctl status ${1}
	}

	# Network config information
	_net_info() {
		if hash hostname; then
			output purple "hostname    : '$(hostname)"
			output purple "hostname -s : '$(hostname -s)'"
			output purple "hostname -d : '$(hostname -d)'"
			output purple "hostname -f : '$(hostname -f)'"
		fi

		if [[ -s /etc/resolv.conf ]]; then
			output purple "resolv.conf :"
			grep -Ev '^#' /etc/resolv.conf
		fi

		if hash ip; then
			output purple "ip route    :"
			ip route show
			echo

			output purple "ip addr     :"
			ip addr show ${DEFROUTE_NIC}
			echo
		fi
	}

	# List running VMs
	_kvm_running() {
		local ARRAY_RUNNING="$(virsh list | awk '/running/ {print $2}')"
		[[ -z "${ARRAY_RUNNING}" ]] && output purple "No VMs running" && return

		output purple "Running VMs:"
		echo
		for VM in ${ARRAY_RUNNING[@]}; do
			output green "${VM}"
		done
	}

	# Watch until all VMs are shutdown
	_kvm_watch() {
		local KVM_COUNTER="0"

		while true; do
			local ARRAY_WATCH=($(virsh list | awk '/running/ {print $2}'))
			local VM_COUNT="${#ARRAY_WATCH[@]}"

			[[ -z "${ARRAY_WATCH}" ]] && output green "No VMs running" && break

			echo -en "${VM_COUNT} VMs ${COLOR_FG_GRN}running${COLOR_RESET}. ${KVM_COUNTER} sec elapsed     \r"

			sleep 1
			local KVM_COUNTER=$((KVM_COUNTER+1))
		done
	}

	# Undefine VMs based on a search string
	_kvm_undefine() {
		local USAGE_STRING="kvm-undefine <search string>"
		[[ -z "${1}" ]] && output usage "${USAGE_STRING}" && return

		local ARRAY_UNDEFINE=$(virsh list --all | awk '/'"${1}"'/ {print $2}')
		[[ -z "${ARRAY_UNDEFINE}" ]] && output yellow "No VMs running matching search string '${1}'" && return

		output purple "These VMs will be undefined:"
		echo

		for VM in ${ARRAY_UNDEFINE[@]}; do
			output red "${VM}"
		done
		echo

		read -p "Are you sure? Enter Y/N: " UNDEFINE_YN

		if [[ "${UNDEFINE_YN}" != [Yy] ]]; then
			output purple "No VMs undefined"
		else
			for VM in ${ARRAY_UNDEFINE[@]}; do
				output purple "Undefining '${VM}'"
				virsh undefine ${VM}
			done
			echo
		fi
	}

	# Destroy all VMs
	_kvm_destroy_all() {
		local ARRAY_DESTROY=($(virsh list | awk '/running/ {print $2}'))
		[[ -z "${ARRAY_DESTROY}" ]] && output purple "No VMs running" && return

		output purple "These VMs will be destroyed:"
		echo

		for VM in ${ARRAY_DESTROY[@]}; do
			output red "${VM}"
		done
		echo

		read -p "Are you sure? Enter Y/N: " DESTROY_YN

		if [[ "${DESTROY_YN}" != [Yy] ]]; then
			output purple "No VMs destroyed"
		else
			for VM in ${ARRAY_DESTROY[@]}; do
				output red "Destroying '${VM}'"
				virsh destroy "${VM}"
			done
			echo
		fi
	}

	# Shutdown all VMs
	_kvm_shutdown_all() {
		local ARRAY_SHUTDOWN=($(virsh list | awk '/running/ {print $2}'))
		[[ -z "${ARRAY_DESTROY}" ]] && output purple "No VMs running" && return

		output purple "These VMs will be shutdown:"
		echo

		for VM in ${ARRAY_SHUTDOWN[@]}; do
			output red "${VM}"
		done
		echo

		read -p "Are you sure? Enter Y/N: " SHUTDOWN_YN

		if [[ "${SHUTDOWN_YN}" != [Yy] ]]; then
			output purple "No VMs shutdown"
		else
			for VM in ${ARRAY_SHUTDOWN[@]}; do
				output yellow "Shutting down VM '${VM}'"
				virsh shutdown "${VM}"
			done
			echo
		fi
	}

	# Start all VMs
	_kvm_start_all() {
		local ARRAY_START=($(virsh list --all | awk '/shut off/ {print $2}' | sed '/Name/d' | sed '/^$/d'))
		[[ -z "${ARRAY_START}" ]] && output purple "No shut off VMs" && return

		output purple "These VMs will be started:"
		echo

		for VM in ${ARRAY_START[@]}; do
			output green "${VM}"
		done
		echo

		read -p "Are you sure? Enter Y/N: " START_YN

		if [[ "${START_YN}" != [Yy] ]]; then
			output purple "No VMs started"
		else
			for VM in ${ARRAY_START[@]}; do
				output green "Starting VM '${VM}'"
				virsh start "${VM}"
			done
			echo
		fi
	}

fi

#### Functions: Linux-only ==final ####


#### Aliases: Auto-sudo ==start ####

# First check if we're root. If so, we don't need any of this
if [[ "${UID}" != "0" ]]; then
	# If we're on macOS, add the macOS commands to the base array
	[[ "${UNAME_KERNEL_NAME}" == "Darwin" ]] && ARRAY_SUDO="${ARRAY_SUDO[@]} ${ARRAY_SUDO_MACOS[@]}"

	# If we're on Linux, add the Linux commands to the base array
	[[ "${UNAME_KERNEL_NAME}" == "Linux"  ]] && ARRAY_SUDO="${ARRAY_SUDO[@]} ${ARRAY_SUDO_LINUX[@]}"

	# Process auto-sudo-alias generation
	for CMD in ${ARRAY_SUDO[@]}; do
		# If it's installed, add sudo
		hash ${CMD} && alias ${CMD}="sudo ${CMD}"
	done
fi

#### Aliases: Auto-sudo ==final ####


#### Aliases: Global ==start ####

# Pre-sorted environment variables
alias env-sort='env | sort -h'

# Newline after screen clear
alias clear='clear; echo'

# Safety first on file operations
alias rm='rm -i'
alias cp='cp -iv'
alias mv='mv -i'
alias mkdir='mkdir -p'

# File list aliases
alias ll='ls -hl   2> /dev/null'
alias lll='ls -ahl 2> /dev/null'
alias la='ls -A    2> /dev/null'
alias l.='ls -d .* 2> /dev/null'
alias l='ls -CF    2> /dev/null'

# Quick up-directory-n-list
alias ..='cd ..; ll'

# Downloads and Desktop folder alases
[[ -d ${HOME}/Desktop   ]] && alias dt="cd ${HOME}/Desktop"
[[ -d ${HOME}/Downloads ]] && alias dl="cd ${HOME}/Downloads"

# Typo aliases
alias bim='vim'
alias cim='vim'
alias ehco='echo'
alias grpe='grep'
alias kk='ll'
alias namp='nmap'
alias pign='ping'
alias tial='tail'

# If it has dnsmasq
[[ -f "/etc/dnsmasq.conf" ]] && alias config-dnsmasq='vim /etc/dnsmasq.conf'
[[ -d "/var/log/dnsmasq"  ]] && alias log-dnsmasq='cd /var/log/dnsmasq'

# If it has squid
[[ -d "/etc/squid"     ]] && alias config-squid='cd /etc/squid'
[[ -d "/var/log/squid" ]] && alias log-squid='cd /var/log/squid'

# If it has apache2/httpd
[[ -d "/etc/apache2"     ]] && alias config-apache2='cd /etc/apache2'
[[ -d "/var/log/apache2" ]] && alias log-apache2='cd /var/log/apache2'
[[ -d "/etc/httpd"       ]] && alias config-httpd='cd /etc/httpd'
[[ -d "/var/log/httpd"   ]] && alias log-httpd='cd /var/log/httpd'

# If it has samba
[[ -d "/etc/samba"     ]] && alias config-samba='cd /etc/samba'
[[ -d "/var/log/samba" ]] && alias log-samba='cd /var/log/samba'

# If it has yum
[[ -d "/etc/yum.repos.d" ]] && alias config-yumrepos='cd /etc/yum.repos.d'

# If it has libvirt
[[ -d "/var/lib/libvirt" ]] && alias config-libvirt='cd /var/lib/libvirt'
[[ -d "/var/log/libvirt" ]] && alias log-libvirt='cd /var/log/libvirt'

# If it has nmap binary:
# only open ports, grepable output, aggressive and verbose aliases
if hash nmap; then
	# nmap needs sudo if not root
	# First, add one for not aggressive one (but still verbose)
	if [[ "${UID}" != "0" ]]; then
		alias nmap='sudo nmap --open'
		# nmap-v for very verbose scan
		alias nmap-v='sudo nmap -vv --open'
		# nmap-a for aggressive scripting scan
		alias nmap-a='sudo nmap -vv -A --open'
	else
		# already root, no need for sudo
		alias nmap='nmap --open'
		# nmap-v for very verbose scan
		alias nmap-v='nmap -vv --open'
		# nmap-a for aggressive scripting scan
		alias nmap-a='nmap -vv -A --open'
	fi
fi

# ping/noping command tweaks
# ping-slow : normal (1.0 second interval)
#      ping : fast   (0.5 second interval)
# ping-fast : faster (0.1 second interval)
alias ping='ping -i 0.5'
alias ping-fast='ping -i 0.1'
alias ping-slow='ping -i 1.0'

# noping commands, if noping is present
if hash noping; then
	# noping needs sudo if not root
	if [[ "${UID}" != "0" ]]; then
		alias noping='sudo noping -i 0.5'
		alias noping-fast='sudo noping -i 0.1'
		alias noping-slow='sudo noping -i 1.0'
	else
		alias noping='noping -i 0.5'
		alias noping-fast='noping -i 0.1'
		alias noping-slow='noping -i 1.0'
	fi
fi

# Prettyprint+colorize various formats, if supporting binaries are installed
if hash tidy && hash highlight; then
	alias html-format='tidy -i -w 200 -ashtml -utf8 2> /dev/null | pygmentize -l html -f terminal256 -O style=monokai'
	alias format-html='html-format'
fi
if hash json_reformat && hash pygmentize; then
	alias json-format='json_reformat | pygmentize -l json -f terminal256 -O style=monokai'
	alias format-json='json-format'
fi
if hash xmllint && hash pygmentize; then
	alias xml-format='xmllint --format - 2> /dev/null | pygmentize -l xml -f terminal256 -O style=monokai'
	alias format-xml='xml-format'
fi

#### Aliases: Global ==final ####


#### Aliases: Linux or macOS (with GNU conversion) ==start ####

if [[ "${MACOS_GNU}" || "${UNAME_KERNEL_NAME}" == "Linux" ]]; then
	# Color grep/ls, no stderr output
	alias egrep='egrep --color=auto 2> /dev/null'
	alias fgrep='fgrep --color=auto 2> /dev/null'
	alias grep=' grep  --color=auto 2> /dev/null'
	alias ls='   ls    --color=auto 2> /dev/null'

	# Sort by IP address octets
	alias sort-ip='sort -t . -k 1,1n -k 2,2n -k 3,3n -k 4,4n'
fi

#### Aliases: Linux or macOS (with GNU conversion) ==final ####


#### Aliases: macOS-only (without GNU conversion) ==start ####

if [[ "${UNAME_KERNEL_NAME}" == "Darwin" && -z "${MACOS_GNU}" ]]; then
	# Alias to make md5sum work like Linux
	alias md5sum='md5 -r'

	# Color ls output
	alias ls='ls -G 2> /dev/null'
fi

#### Aliases: macOS-only (without GNU conversion) ==final ####


#### Aliases: macOS-only (regardless of GNU conversion) ==start ####

if [[ "${UNAME_KERNEL_NAME}" == "Darwin" ]]; then
	# PING_WAIT for use in ping functions
	export PING_WAIT="-t 1"

	# EFI partition mount for disk0, disk1, and disk2
	alias efi-mount-0='diskutil mount /dev/disk0s1; cd /Volumes/EFI/EFI'
	alias efi-mount-1='diskutil mount /dev/disk1s1; cd /Volumes/EFI/EFI'
	alias efi-mount-2='diskutil mount /dev/disk2s1; cd /Volumes/EFI/EFI'

	# Show listening ports a bit easier
	alias net-listening-ipv4="netstat -p tcp -an | grep -E '^(tcp4|udp4).*.LISTEN' | sort"
	alias net-listening-ipv6="netstat -p tcp -an | grep -E '^(tcp6|udp6).*.LISTEN' | sort"

	# Network config information
	_net_info() {
		if hash hostname; then
			output purple "hostname    : '$(hostname)"
			output purple "hostname -s : '$(hostname -s)'"
			output purple "hostname -d : '$(hostname -d)'"
			output purple "hostname -f : '$(hostname -f)'"
			echo
		fi

		if hash ip; then
			output purple "ip addr show:"
			ip addr show
			echo

			output purple "ip route show:"
			ip route show
			echo
		fi

		if hash ifconfig; then
			output purple "ifconfig:"
			ifconfig
			echo
		fi

		if hash netstat; then
			output purple "netstat -nr:"
			netstat -nr
			echo
		fi

		if [[ -s /etc/resolv.conf ]]; then
			output purple "resolv.conf:"
			cat /etc/resolv.conf
		fi
	}

	# Fake lsusb
	alias lsusb='system_profiler SPUSBDataType'

	# Clear font cache
	alias osx-repair-fontcache='sudo atsutil databases -remove'

	# Lock screen and screensaver shortcuts
	alias osx-screen-off='pmset displaysleepnow'
	alias osx-screen-lock='/System/Library/CoreServices/Menu\ Extras/User.menu/Contents/Resources/CGSession -suspend'
	alias osx-screen-saver='open -a ScreenSaverEngine'
	alias osx-sleep="osascript -e 'tell app \"System Events\" to sleep'"

	# El Capitan and up
	if [[ "$(echo ${UNAME_KERNEL_RELEASE} | awk -F '.' '{print $1}')" -ge "15" ]]; then
		# Enable and disable indexing
		alias osx-indexing-enable='sudo mdutil -a -i on'
		alias osx-indexing-disable='sudo mdutil -a -i off'

		# Flush DNS cache
		alias osx-repair-dns='sudo dscacheutil -flushcache; sudo killall -HUP mDNSResponder'

		# Repair disk permissions
		alias osx-repair-diskperms="sudo repair_packages --repair --standard-pkgs /; sudo chown -R ${USER}/usr/local"
	else # Pre-El Capitan
		alias osx-repair-dns='sudo killall -HUP mDNSResponder'
		alias osx-repair-diskperms="sudo diskutil repairPermissions /; sudo chown -R ${USER} /usr/local"
	fi
fi

#### Aliases: macOS-only (regardless of GNU conversion) ==final ####


#### Aliases: Linux-only ==start ####

if [[ "${UNAME_KERNEL_NAME}" == "Linux" ]]; then
	# PING_WAIT for use in ping functions
	export PING_WAIT="-W 1"

	# Clean up old kernels, I can never remember this one
	alias kernel-cleanup='package-cleanup --oldkernels --count=2'
fi

#### Aliases: Linux-only ==final ####
