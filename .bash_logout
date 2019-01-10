# kdm bash-env
# .bash_logout


# Source bash libraries from ~/.kdm/extra-logout
for ENTRY in $(find -L "${BASH_ENV_DIR_EXTRA_LOGOUT}" -maxdepth 1 -type f -executable | sort); do
	# Skip README
	[[ "${ENTRY}" == "README" ]] && continue

	unset SOURCE_EXIT
	unset SOURCE_FILE

	# shellcheck disable=SC1090
	. "${ENTRY}"; SOURCE_EXIT="${?}"

	[[ "${SOURCE_VERBOSE}" != "true" ]] && continue

	SOURCE_FILE="${ENTRY/${HOME}\/\.kdm\//}"
	if [[ "${SOURCE_EXIT}" == "0" ]]; then
		output keyval-p "Loaded" "${SOURCE_FILE}"
		continue
	fi

	output keyval-f "Failed" "${SOURCE_FILE}"
done

unset SOURCE_EXIT
unset SOURCE_FILE
