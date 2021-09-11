#!/bin/bash
#%
#% Fluent Bit deployer
#%
#%   Requires Podman, a preloaded vault token ($VAULT_TOKEN) and privileged host access to /proc/stat.
#%
#% Usage:
#%
#%   ${THIS_FILE} [command]
#%
#% Commands:
#%   deploy Deploys Fluent Bit
#%   help   Displays this help dialog


# Specify halt conditions (errors, unsets, non-zero pipes), field separator and verbosity
#
set -euo pipefail
[ ! "${VERBOSE:-}" == "true" ] || set -x


# Parameters
#
COMMAND="${1:-help}"

# If no parameters have been passed show the help header from this script
#
[ "${COMMAND}" = "deploy" ] || {
	THIS_FILE="$(dirname ${0})/$(basename ${0})"

	# Cat this file, grep #% lines and clean up with sed
	cat ${THIS_FILE} |
		grep "^#%" |
		sed -e "s|^#%||g" |
		sed -e "s|\${THIS_FILE}|${THIS_FILE}|g"
	exit
}


# Vault vars
#
export VAULT_ADDR=https://vault-iit.apps.silver.devops.gov.bc.ca
export VAULT_TOKEN=$(vault login -method=oidc -format json 2>/dev/null | jq -r '.auth.client_token')


# Host vars
#
export HOST_OS_FAMILY=$(cat /etc/os-release | grep -e '^ID=' |  cut -d'=' -f2 | xargs)
export HOST_OS_KERNEL=$(uname -r)
export HOST_OS_NAME="$(cat /etc/os-release | grep -e '^NAME=' |  cut -d'=' -f2 | xargs)"
export HOST_OS_FULL=$(cat /etc/os-release | grep -e '^PRETTY_NAME=' |  cut -d'=' -f2 | xargs)
export HOST_OS_VERSION=$(cat /etc/os-release | grep -e '^VERSION_ID=' |  cut -d'=' -f2 | xargs)
export HOST_ID=$(hostname -f)
export HOST_HOSTNAME=$(hostname -s)
export HOST_NAME=$(domainname -A | tr " " "\n" | sort | uniq | tr '\n' ' ' | xargs)
export HOST_DOMAIN=$(printf "$HOST_NAME" | tr " " "\n" | awk -F. '{$1="";OFS="." ; print $0}' | sed 's/^.//' | sort | uniq | tr '\n' ' ' | xargs)
export HOST_ARCH=$(uname -m)
export HOST_IP=$(ip addr | grep 'inet' | tr -s " " | cut -d' ' -f3 | cut -d'/' -f1 | grep -v '127.0.0.1')
export HOST_MAC=$(ip link | grep 'link/ether' | tr -s " " | cut -d' ' -f3)


# Build
#
podman build .. -t fb


# Run in foreground, passing vars
#
podman run --name fluent-bit --rm -e VAULT_* -e HOST_* --pid="host" -v "/proc/stat:/proc/stat:ro" --privileged localhost/fb
