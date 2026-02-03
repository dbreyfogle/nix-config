OS := $(shell uname -v)
IS_NIXOS := $(findstring NixOS,$(OS))
IS_DARWIN := $(findstring Darwin,$(OS))

ifneq (,$(wildcard .env))
	include .env
	export
endif

.PHONY: all switch clean

all: switch

switch: check_flake_output
ifdef IS_NIXOS
	sudo nixos-rebuild switch --flake .#$(FLAKE_OUTPUT)
else ifdef IS_DARWIN
	sudo darwin-rebuild switch --flake .#$(FLAKE_OUTPUT)
else
	home-manager switch -b bak --flake .#$(FLAKE_OUTPUT)
endif

clean:
ifneq (,$(IS_NIXOS)$(IS_DARWIN))
	sudo nix-collect-garbage -d
endif
	nix-collect-garbage -d

update:
	./scripts/update

install_nix:
ifdef IS_DARWIN
	sh <(curl --proto '=https' --tlsv1.2 -L https://nixos.org/nix/install)
else
	sh <(curl --proto '=https' --tlsv1.2 -L https://nixos.org/nix/install) --daemon
endif

bootstrap_darwin: check_flake_output
	sudo nix --extra-experimental-features "nix-command flakes" \
	  run nix-darwin/master#darwin-rebuild -- switch --flake .#$(FLAKE_OUTPUT)

bootstrap_hm: check_flake_output
	nix --extra-experimental-features "nix-command flakes" \
	  run home-manager/master -- init --switch
	home-manager --extra-experimental-features "nix-command flakes" \
	  switch -b bak --flake .#$(FLAKE_OUTPUT)

check_flake_output:
ifndef FLAKE_OUTPUT
	$(error FLAKE_OUTPUT is not defined)
endif
