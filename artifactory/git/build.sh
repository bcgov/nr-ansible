#!/bin/bash
set -euo nounset

GIT_VERSION=$1

# Build
podman build --build-arg GIT_VERSION=${GIT_VERSION} -t git-${GIT_VERSION} .

# Run (remove stale)
podman rm -fv git-origin || true
podman run --name=git-origin -tid git-${GIT_VERSION} bash

# Copy out
podman cp git-origin:/dropbox/git.tar.gz .

# Clean up
podman rm -fv git-origin

# Artifactory instructions
#echo -e "\nUpload to Artifactory:"
#curl -X PUT -u "${ARTIFACTORY_USER}:${ARTIFACTORY_PASS}" -T fluent-bit.tar.gz "https://bwa.nrs.gov.bc.ca/int/artifactory/ext-binaries-local/fluent/fluent-bit/${FLUENT_BIT_VERSION}/fluent-bit.tar.gz"
