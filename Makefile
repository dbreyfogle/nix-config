ifneq (,$(wildcard .env))
	include .env
	export
endif

OS := $(shell uname -v)
IS_NIXOS := $(findstring NixOS,$(OS))
IS_DARWIN := $(findstring Darwin,$(OS))
GC_OLDER_THAN := 7d

.PHONY: all switch clean

all: switch

switch: check_flake_output
ifdef IS_NIXOS
	sudo nixos-rebuild switch --flake .#$(FLAKE_OUTPUT)
else ifdef IS_DARWIN
	darwin-rebuild switch --flake .#$(FLAKE_OUTPUT)
else
	home-manager switch -b bak --flake .#$(FLAKE_OUTPUT)
endif

clean:
ifneq (,$(IS_NIXOS)$(IS_DARWIN))
	sudo nix profile wipe-history --profile /nix/var/nix/profiles/system  --older-than $(GC_OLDER_THAN)
	sudo nix-collect-garbage --delete-older-than $(GC_OLDER_THAN)
endif
	nix-collect-garbage --delete-older-than $(GC_OLDER_THAN)

update:
	./scripts/update-flakes.sh

install_nix:
	curl --proto '=https' --tlsv1.2 -sSf -L https://install.determinate.systems/nix | sh -s -- install

bootstrap_darwin: check_flake_output
	nix run nix-darwin/nix-darwin-24.11#darwin-rebuild -- switch --flake .#$(FLAKE_OUTPUT)

bootstrap_hm: check_flake_output
	nix run home-manager/master -- init --switch
	home-manager switch -b bak --flake .#$(FLAKE_OUTPUT)

check_flake_output:
ifndef FLAKE_OUTPUT
	$(error FLAKE_OUTPUT is not defined)
endif
