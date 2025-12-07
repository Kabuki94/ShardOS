#!/usr/bin/env bash
set -euo pipefail

# Write the SIGNING_SECRET to cosign.key
if [ -z "${SIGNING_SECRET:-}" ]; then
  echo "ERROR: SIGNING_SECRET not provided." >&2
  echo "Please add SIGNING_SECRET to the repository secrets or disable signing (set build.sign: false in the recipe)." >&2
  exit 1
fi

echo "$SIGNING_SECRET" > ./cosign.key
chmod 600 ./cosign.key

# Verify cosign.pub exists (should be committed to repo)
if [ ! -f ./cosign.pub ]; then
  echo "ERROR: cosign.pub not found in repository root." >&2
  exit 1
fi

echo "Restored cosign.key from SIGNING_SECRET"
