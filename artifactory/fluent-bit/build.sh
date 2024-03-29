#!/usr/bin/env bash
set -euo nounset

: ${1?"Usage: $0 FLUENT_BIT_VERSION RHEL_VERSION"}

FLUENT_BIT_VERSION=$1
RHEL_VERSION=$2

# Build
podman build --build-arg FLUENT_BIT_VERSION=${FLUENT_BIT_VERSION} -t fb-${FLUENT_BIT_VERSION} -f Dockerfile-rhel${RHEL_VERSION}

# Run (remove stale)
podman rm -fv fb-origin || true
podman run --name=fb-origin -tid fb-${FLUENT_BIT_VERSION} bash

# Copy out
podman cp fb-origin:/dropbox/fluent-bit-rhel${RHEL_VERSION}.tar.gz .

# Clean up
podman rm -fv fb-origin

# Artifactory instructions
echo -e "\nUpload to Artifactory:"
curl -X PUT -u "${ARTIFACTORY_USER}:${ARTIFACTORY_PASS}" -T "fluent-bit-rhel${RHEL_VERSION}.tar.gz" "https://bwa.nrs.gov.bc.ca/int/artifactory/ext-binaries-local/fluent/fluent-bit/${FLUENT_BIT_VERSION}/fluent-bit-rhel${RHEL_VERSION}.tar.gz"
