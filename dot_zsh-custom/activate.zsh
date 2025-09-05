#!/bin/sh

# Activate a Python virtualenv from the current working directory,
# or any parent directory, if it exists.
# Set ACTIVATE_DEBUG to a non-empty value to enable debug output.

__activate_python_virtualenv() {
    __debug() {
        if test "${ACTIVATE_DEBUG}x" != "x"; then
            echo "DEBUG: $1"
        fi
    }

    dir="$(pwd)"
    __debug "Starting activate from ${dir}"

    while true; do
        venv_bin_dir="${dir}/.venv/bin"
        __debug "Checking for venv at {$dir} ..."
        if test -d "$venv_bin_dir" -a -f "${venv_bin_dir}/activate"; then
            __debug "Activating virtualenv at ${dir}"
            . "${venv_bin_dir}/activate"
            return
        else
            dir=$(readlink -f "${dir}/..")
            if test "${dir}" = "/"; then
                __debug "Reached filesystem root, stopping"
                return
            fi
        fi
    done
}

alias activate=__activate_python_virtualenv
