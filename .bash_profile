# kdm bash-env
# .bash_profile

# Last modified : Fri 31 Mar 2017 10:24:56 AM EDT

#### Init functions ==start ####

# Output loading message with auto-increment
alias bash-env-loading='_bash_env_loading'
_bash_env_loading() {
	# Clear line function - 29 spaces
	if [[ "${1}" == "clear" ]]; then
		printf '%*s\r' 29 ''
		return
	fi

	# Init variables
	LOADING_DOT_COUNT="${LOADING_DOT_COUNT-1}"
	LOADING_WHITESPACE_COUNT="${LOADING_WHITESPACE_COUNT-23}"

	# Create dot string
	local LOADING_DOT_STRING="$(printf '%*s' ${LOADING_DOT_COUNT} '' | sed 's/\ /\./g')"

	# Create whitespace string
	printf -v LOADING_WHITESPACE_STRING '%*s' ${LOADING_WHITESPACE_COUNT} ''

	# Assemble string
	local LOADING_STRING="${LOADING_DOT_STRING}${LOADING_WHITESPACE_STRING}"

	# Output message (if on Bash 4+)
	if [[ "${BASH_VERSINFO[0]}" -ge "4" ]]; then
		echo -en "${C_YLW_BLD}init ${LOADING_STRING}${COLOR_RESET}\r"
	fi

	# Increment counter if until 24, then decrement
	[[ "${LOADING_DOT_COUNT}" == "24" ]] && LOADING_DOT_DIRECTION="down"
	[[ "${LOADING_DOT_COUNT}" == "1"  ]] && LOADING_DOT_DIRECTION="up"

	if [[ "${LOADING_DOT_DIRECTION}" == "up" ]]; then
		((LOADING_DOT_COUNT++))
		((LOADING_WHITESPACE_COUNT--))
	else
		((LOADING_DOT_COUNT--))
		((LOADING_WHITESPACE_COUNT++))
	fi
}

# Check if a binary is installed/present in ${PATH}, without stdout/stderr
# This is for bash, not for POSIX
hash() {
	builtin hash ${1+"$@"} &> /dev/null
	return "${?}"
}

#### Init functions ==final ####


#### Data arrays for init ==start ####

# bash-env variable set
export BASH_ENV_DIR_CODE="${HOME}/code"
export BASH_ENV_DIR_KDM="${HOME}/.kdm"
export BASH_ENV_DIR_NMAP="${HOME}/.nmap"
export BASH_ENV_DIR_SNMP="${HOME}/.snmp"
export BASH_ENV_DIR_SSH="${HOME}/.ssh"
export BASH_ENV_DIR_VIM="${HOME}/.vim"

export BASH_ENV_DIR_EXTRA="${BASH_ENV_DIR_KDM}/extra"
export BASH_ENV_FILE_BASHHISTORY="${BASH_ENV_DIR_KDM}/history"

export BASH_ENV_FILE_BASHLOGOUT="${HOME}/.bash_logout"
export BASH_ENV_FILE_BASHPROFILE="${HOME}/.bash_profile"
export BASH_ENV_FILE_BASHRC="${BASH_ENV_DIR_KDM}/bashrc"
export BASH_ENV_FILE_COLORS="${BASH_ENV_DIR_KDM}/bash-env-colors"
export BASH_ENV_FILE_CONFIG="${BASH_ENV_DIR_KDM}/bash-env.conf"
export BASH_ENV_FILE_DIRCOLORS="${HOME}/.dircolors"
export BASH_ENV_FILE_GEMRC="${HOME}/.gemrc"
export BASH_ENV_FILE_GITCONFIG="${HOME}/.gitconfig"
export BASH_ENV_FILE_GITIGNORE="${HOME}/.gitignore"
export BASH_ENV_FILE_INPUTRC="${HOME}/.inputrc"
export BASH_ENV_FILE_NLOAD="${HOME}/.nload"
export BASH_ENV_FILE_PIPRC="${HOME}/.piprc"
export BASH_ENV_FILE_SCREENRC="${HOME}/.screenrc"
export BASH_ENV_FILE_SSH_AUTHKEYS="${BASH_ENV_DIR_SSH}/authorized_keys"
export BASH_ENV_FILE_SSH_CONFIG="${BASH_ENV_DIR_SSH}/config"
export BASH_ENV_FILE_TOPRC="${HOME}/.toprc"
export BASH_ENV_FILE_VIMRC="${HOME}/.vimrc"

# Custom pip config file path
export PIP_CONFIG_FILE="${BASH_ENV_FILE_PIPRC}"

ARRAY_INIT_CONFIG=(
WARN_FACTER
)

ARRAY_MKDIR=(
${BASH_ENV_DIR_KDM}
${BASH_ENV_DIR_SSH}
${BASH_ENV_DIR_VIM}
)

ARRAY_PATH=(
${HOME}/bin
${HOME}/.local/bin
${HOME}/perl5/bin
${HOME}/.composer/vendor/bin
${HOME}/Library/Android/sdk/platform-tools
/usr/local/opt/libxml2/bin
/usr/local/opt/libxslt/bin
/usr/local/rvm/gems/ruby-2.4.0/bin
/usr/local/rvm/gems/ruby-2.4.0@global/bin
/usr/local/rvm/rubies/ruby-2.4.0/bin
/usr/local/rvm/bin
/usr/local/opt/coreutils/libexec/gnubin
/usr/local/sbin
/usr/local/bin
/opt/local/sbin
/opt/local/bin
/opt/puppetlabs/bin
/usr/lib/nvidia-367/bin
/usr/lib/nvidia-361/bin
/usr/lib/nvidia-340/bin
/usr/lib/nvidia-304-updates/bin
/usr/lib/nvidia-304/bin
/usr/pgsql-9.6/bin
/usr/pgsql-9.5/bin
/usr/pgsql-9.4/bin
/usr/libexec
/sbin
/bin
/usr/sbin
/usr/bin
/usr/bin/X11
/opt/X11/bin
/usr/X11R6/bin
/usr/games
/usr/lib/mit/bin
/usr/lib/mit/sbin
)

ARRAY_PACKAGE_MANAGERS=(
apt-get
brew
dnf
dnf-3
pacman
yum
zypper
)

ARRAY_MANPATH=(
${HOME}/perl5/man
/usr/local/share/man
/usr/pgsql-9.5/share/man
/usr/share/man/overrides
/usr/share/man/en
/usr/share/man
/usr/X11R6/share/man
/opt/X11/share/man
)

ARRAY_NODE_PATH=(
/usr/lib/nodejs
/usr/lib/node_modules
/usr/share/javascript
/usr/local/lib/node_modules
)

ARRAY_MIBDIRS=(
${BASH_ENV_DIR_SNMP}/mibs
/usr/share/snmp/mibs
)

ARRAY_RM=(
${HOME}/.bash_history
${HOME}/.profile
${BASH_ENV_FILE_TIME_TOTAL}
)

ARRAY_SOURCE=(
/etc/profile.d/bash_completion.sh
/usr/local/etc/profile.d/bash_completion.sh
/usr/local/etc/bash_completion
${BASH_ENV_FILE_BASHRC}
)

ARRAY_TOUCH=(
${BASH_ENV_FILE_BASHHISTORY}
${BASH_ENV_FILE_CONFIG}
${BASH_ENV_FILE_SSH_AUTHKEYS}
${BASH_ENV_FILE_SSH_CONFIG}
)

# Array of automatic sudo-ing commands (macOS-only)
export ARRAY_SUDO_MACOS=(
atsutil
chflags
cupsctl
defaults
diskutil
dscacheutil
dspci
fs_usage
gpt
installer
ioreg
kextcache
kextload
kextstat
kextunload
keytool
launchctl
log
mdutil
newfs_apfs
newfs_exfat
newfs_hfs
newfs_msdos
newfs_udf
nvram
pmset
productutil
puppet
reboot
repair_packages
scutil
security
shutdown
softwareupdate
spctl
ssdtprgen
system_profiler
systemsetup
systemstats
trimforce
xcode-select
xcodebuild
)

# Array of automatic sudo-ing commands (Linux-only)
export ARRAY_SUDO_LINUX=(
apt-cache
apt-get
crontab
dnf
dnf-3
ether-wake
fdisk
fedup
pacman
rpm
service
systemctl
yum
zypper
)

# Array of automatic sudo-ing commands (Linux and OS X)
export ARRAY_SUDO=(
arp
arp-scan
dd
dhcping
dmesg
iftop
ioping
jnettop
mount
netstat
nload
noping
oping
reboot
route
shutdown
sntop
su
syslog
umount
virsh
virt-admin
virt-clone
virt-convert
virt-host-validate
virt-install
virt-manager
virt-pki-validate
virt-viewer
virt-xml
virt-xml-validate
visudo
)

# Array of shell options to be set
ARRAY_SHELL_OPTIONS=(
cdable_vars
cdspell
checkhash
checkwinsize
histappend
no_empty_cmd_completion
xpg_echo
)

# Array of shell options that only work with bash 4+
ARRAY_SHELL_OPTIONS_BASH4=(
autocd
dirspell
)

#### Data arrays for init ==final ####

# Init loading variables
unset LOADING_DOT_COUNT
unset LOADING_WHITESPACE_COUNT

# Source color library first
. ${BASH_ENV_FILE_COLORS}

# Locale configuration
# (mostly because OS X chokes on them over SSH for some reason..)
export LC_ALL="en_US.UTF-8"
export LANG="en_US.UTF-8"

# pycurl backend library fix on RHEL
[[ -s /etc/redhat-release ]] && export PYCURL_SSL_LIBRARY="nss"

# Perl 5 environment variables
if [[ -d "${HOME}/perl5" ]]; then
	export PERL5LIB="${HOME}/perl5/lib/perl5${PERL5LIB+:}${PERL5LIB}"
	export PERL_LOCAL_LIB_ROOT="${HOME}/perl5${PERL_LOCAL_LIB_ROOT+:}${PERL_LOCAL_LIB_ROOT}"
	export PERL_MB_OPT="--install_base '${HOME}/perl5'"
	export PERL_MM_OPT="INSTALL_BASE='${HOME}/perl5'"
fi

# Set timeout to something more reasonable
if [[ "${TMOUT}" ]]; then
	unset TMOUT
	export TMOUT="3600"
fi

# OS X -> GNU conversion
# Export variable for later use in detection OS X -> GNU conversion
[[ -d /usr/local/Cellar/coreutils                  ]] && export MACOS_GNU="1"
[[ -d /usr/local/lib/gdk-pixbuf-2.0/2.10.0/loaders ]] && export GDK_PIXBUF_MODULEDIR="/usr/local/lib/gdk-pixbuf-2.0/2.10.0/loaders"

# Configure PATH from array if entry is present
unset PATH
for ENTRY in ${ARRAY_PATH[@]}; do
	# Add entry from array if it is present and contains files
	[[ -d ${ENTRY} ]] && PATH="${PATH}${PATH+:}${ENTRY}"
done
export PATH

# Disable input
stty -echo
echo
bash-env-loading # Output loading message

# Detect package manager
for PACKAGE_MANAGER in "${ARRAY_PACKAGE_MANAGERS[@]}"; do
	hash ${PACKAGE_MANAGER} && break || unset PACKAGE_MANAGER
done
[[ "${PACKAGE_MANAGER}" ]] && export PACKAGE_MANAGER

# Configure MANPATH from array if entry is present
unset MANPATH
for ENTRY in ${ARRAY_MANPATH[@]}; do
	[[ -d ${ENTRY} ]] && MANPATH="${MANPATH}${MANPATH+:}${ENTRY}" && bash-env-loading
done
export MANPATH

# Configure NODE_PATH from array if entry is present
unset NODE_PATH
for ENTRY in ${ARRAY_NODE_PATH[@]}; do
	[[ -d ${ENTRY} ]] && NODE_PATH="${NODE_PATH}${NODE_PATH+:}${ENTRY}" && bash-env-loading
done
export NODE_PATH

# Configure MIBDIRS from array if entry is present
unset MIBDIRS
for ENTRY in ${ARRAY_MIBDIRS[@]}; do
	[[ -d ${ENTRY} ]] && MIBDIRS="${MIBDIRS}${MIBDIRS+:}${ENTRY}" && bash-env-loading
done
export MIBDIRS
export MIBS="ALL"

# Create directories if missing
for ENTRY in ${ARRAY_MKDIR[@]}; do
	[[ ! -d ${ENTRY} ]] && mkdir -p ${ENTRY} && bash-env-loading
done

# Remove files if present
for ENTRY in ${ARRAY_RM[@]}; do
	[[ -e ${ENTRY} ]] && rm -rf ${ENTRY} && bash-env-loading
done

# Touch files
for ENTRY in ${ARRAY_TOUCH[@]}; do
	[[ ! -e ${ENTRY} ]] && touch ${ENTRY} && bash-env-loading
done

# Init entries in the config file if missing
for ENTRY in ${ARRAY_INIT_CONFIG[@]}; do
	grep -q ${ENTRY} ${BASH_ENV_FILE_CONFIG} || echo "${ENTRY}=0" >> ${BASH_ENV_FILE_CONFIG}
	bash-env-loading
done

# Fix SSH dir permissions
chmod 0700 ${BASH_ENV_DIR_SSH} &> /dev/null

# Default "user color" configuration, overridden by library in 'extra' dir if present
# Root = red, non-root = purple
[[ "${UID}" == "0" ]] && C_ENV="${C_RED}" || C_ENV="${C_ENV-${C_GRN}}"
export C_ENV
export C_ENV_BOLD="${C_BLD}${C_ENV}"

# Machine uname variables
export UNAME_KERNEL_NAME="$(uname -s)"
export UNAME_KERNEL_RELEASE="$(uname -r)"
# Commented these out as they are unused (for now)
#export UNAME="$(uname)"
#export UNAME_ALL="$(uname -a)"
#export UNAME_KERNEL_VERSION="$(uname -v)"
#export UNAME_MACHINE="$(uname -m)"
#export UNAME_NODE="$(uname -n)"
#export UNAME_PROCESSOR="$(uname -p)"

bash-env-loading # Output loading message

# Get IP, TTY, and hostname so the binaries doesn't have to be run again, if the ip binary exists
if hash ip; then
	export DEFROUTE_NIC="$(ip route | grep -Po '(?<=dev\ )(e(n|th|ns|np[1-9]s)|br|wlan)[0-9]{1,3}(?=(\s\sproto\ static)?(\s\smetric\ [1-9][0-9]{0,3})?\s?$)' | head -n 1)"
	[[ "${DEFROUTE_NIC}" ]] && export HOST_IP=$(ip addr  | grep -Po "(?<=inet\ )([1-9]([0-9]{1,2})\.([0-9]{1,3})\.([0-9]{1,3})\.([0-9]{1,3})(?=.*.[^vir]${DEFROUTE_NIC}$))")
	bash-env-loading # Output loading message
fi

export CURRENT_TTY="$(ps ax | awk '/'"${$}"'/ {printf $2; exit}')"
bash-env-loading # Output loading message

# If we have a hostname file, use it; otherwise call the hostname binary
[[ -s /etc/hostname ]] && HOSTNAME_DATA="$(cat /etc/hostname)" || HOSTNAME_DATA="$(hostname -f)"
# Determine subdomain count
DOMAIN_COUNT="${HOSTNAME_DATA//[^.]}"
DOMAIN_COUNT="${#DOMAIN_COUNT}"
# Parse for domain
if [[ "${DOMAIN_COUNT}" -ge "1" ]]; then
	export DOMAIN_FULL="$(echo ${HOSTNAME_DATA} | cut -d '.' -f 2-)"
fi
export DOMAIN_FULL="${DOMAIN_FULL-local}"
# Parse for hostname
export HOST_SHORT="${HOSTNAME_DATA%%.*}"
if [[ "${DOMAIN_COUNT}" -ge "3" ]]; then
	export DOMAIN=$(echo ${HOSTNAME_DATA} | cut -d '.' -f ${DOMAIN_COUNT}-)
	HOST_SUB="${HOST_SHORT}.${DOMAIN_FULL/\.${DOMAIN}/}"
fi
# Failstate catch
export HOST_SUB="${HOST_SUB-${HOST_SHORT}}"
export DOMAIN="${DOMAIN-local}"
# Populate ${HOSTNAME} environment variable if missing
export HOSTNAME="${HOSTNAME-${HOSTNAME_DATA}}"

bash-env-loading # Output loading message

# jenv setup to manage multiple java versions
# first, check if jenv is installed
if hash jenv; then
	# Java home variable on OS X
	[[ -d /usr/local/var/jenv ]] && export JENV_ROOT="/usr/local/var/jenv"
	# Load jenv automatically
	eval "$(jenv init - --no-rehash)"
	bash-env-loading # Output loading message
else
	# If no jenv, setup JAVA_HOME variable.
	# Check if the java_home binary is present
	if [[ -s /usr/libexec/java_home ]]; then
		# Send all to stdout and grep for filepath
		JAVA_HOME="$(/usr/libexec/java_home 2>&1 | grep '\/')"
		# If the return is a path (aka not empty) - export it; otherwise, unset it
		[[ "${JAVA_HOME}" ]] && export JAVA_HOME || unset JAVA_HOME
		bash-env-loading # Output loading message
	fi
fi

# Set EDITOR and VISUAL variables to the proper vim path, if vim is installed
if hash vim; then
	! VIM_PATH="$(which --skip-alias vim 2> /dev/null)" && VIM_PATH="$(which vim)"
	unset EDITOR; export EDITOR="${VIM_PATH}"
	unset VISUAL; export VISUAL="${VIM_PATH}"
	unset VIM_PATH
	bash-env-loading # Output loading message
fi

# Set bash history size to unlimited
export HISTFILESIZE=
export HISTSIZE=
# Set bash history format
export HISTTIMEFORMAT="[%F %T] "
# Set bash history file location, certain bash sessions truncate ~/.bash_history on close
export HISTFILE=${BASH_ENV_FILE_BASHHISTORY}
# Get number of lines in history
[[ -s "${HISTFILE}" ]] && export HISTLENGTH="$(cat ${HISTFILE} | wc -l)"
# Ignore bland commands
export HISTIGNORE="..:cd:cd ..:clear:dl:dt:l:ll:lll:ls:ls -A:ls -l:ls -lh:ls -lha:reboot:shutdown -h now:shutdown -r now"

# Configure various shell options
for OPTION in ${ARRAY_SHELL_OPTIONS[@]}; do
	shopt -s ${OPTION} && bash-env-loading
done

# Configure bash 4+ shell options, if we're running it
if [[ "${BASH_VERSION%%.*}" -ge 4 ]]; then
	for OPTION in ${ARRAY_SHELL_OPTIONS_BASH4[@]}; do
		shopt -s ${OPTION} &> /dev/null && bash-env-loading
	done
fi

# Source the files in ARRAY_SOURCE if they exist
for ENTRY in ${ARRAY_SOURCE[@]}; do
	[[ -s ${ENTRY} ]] && . ${ENTRY} && bash-env-loading # Output loading message
done

# History control setup
# http://unix.stackexchange.com/questions/18212/bash-history-ignoredups-and-erasedups-setting-conflict-with-common-history
# Ignore/erase duplicates and space-prefixed commands ' ls'
export HISTCONTROL="ignoredups:ignorespace"
# Also generate prompt with _prompt_generate function in .bashrc and write lines to history file
export PROMPT_COMMAND="history -a; _prompt_generate"

bash-env-loading # Output loading message

# If dircolors exists, run it
if hash dircolors; then
	# If ~/.dircolors exists, use it
	[[ -s ${BASH_ENV_FILE_DIRCOLORS} ]] && DIRCOLOR_DATA="$(dircolors ${BASH_ENV_FILE_DIRCOLORS})" || DIRCOLOR_DATA="$(dircolors)"
	bash-env-loading # Output loading message
	[[ ! -z "${DIRCOLOR_DATA}" ]] && eval "${DIRCOLOR_DATA}" &> /dev/null
	bash-env-loading # Output loading message
	unset DIRCOLOR_DATA
fi

# Source bash libraries from the 'extra' dir
for ENTRY in $(ncls -A ${BASH_ENV_DIR_EXTRA} | ncgrep -Ev '\.sw|\._|README'); do
	[[ -e ${BASH_ENV_DIR_EXTRA}/${ENTRY} ]] && . ${BASH_ENV_DIR_EXTRA}/${ENTRY}
	bash-env-loading # Output loading message
done

# Setup SSH aliases from SSH config file
eval "$(awk -F ' ' '/^Host(\s){1,29}[a-z].*/ {print "alias " $2 "='"'"'ssh " $2 "'"'"'"}' ${BASH_ENV_FILE_SSH_CONFIG})"
bash-env-loading # Output loading message

# Re-init loading variables
unset LOADING_DOT_COUNT
unset LOADING_WHITESPACE_COUNT

# Show the MOTD
show-motd

# Re-enable input
stty echo
