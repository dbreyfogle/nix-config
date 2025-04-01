#!/usr/bin/env bash

set -euo pipefail

if [ -f "flake.nix" ]; then
	echo "Updating top-level flake..."
	nix flake update
else
	echo "Error: flake.nix not found in the repository root." >&2
	exit 1
fi

# Loop through subdirectories in templates
if [ ! -d "templates" ]; then
	echo "Error: Templates directory not found." >&2
	exit 1
else
	for d in templates/*/; do
		if [ -f "${d}flake.nix" ]; then
			echo "Updating flake in ${d}..."
			(cd "$d" && nix flake update)
		else
			echo "Error: flake.nix not found in ${d}." >&2
			exit 1
		fi
	done
fi

echo "Flake update process completed."
