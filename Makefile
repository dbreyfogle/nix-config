SHELL := /usr/bin/env bash

ifneq (,$(wildcard .env))
	include .env
	export
endif

OS := $(shell uname -s)
GC_OLDER_THAN := 7d

.SILENT: all switch bootstrap_darwin

all: switch

switch: check_flake_output
ifeq ($(OS), Darwin)
	darwin-rebuild switch --flake .#$(FLAKE_OUTPUT)
else
	sudo nixos-rebuild switch --flake .#$(FLAKE_OUTPUT)
endif

clean:
	sudo nix profile wipe-history --profile /nix/var/nix/profiles/system  --older-than $(GC_OLDER_THAN)
	sudo nix-collect-garbage --delete-older-than $(GC_OLDER_THAN)
	nix-collect-garbage --delete-older-than $(GC_OLDER_THAN)

update:
	./scripts/update-flakes.sh

bootstrap_darwin: check_flake_output
	nix run nix-darwin/nix-darwin-24.11#darwin-rebuild -- switch --flake .#$(FLAKE_OUTPUT)

install_nix:
	curl --proto '=https' --tlsv1.2 -sSf -L https://install.determinate.systems/nix | sh -s -- install

check_flake_output:
ifndef FLAKE_OUTPUT
	$(error FLAKE_OUTPUT is not defined)
endif
