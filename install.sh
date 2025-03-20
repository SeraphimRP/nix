#!/bin/sh

sudo cp -R nixos/* /etc/nixos/
#nix flake update --flake /etc/nixos 
sudo nixos-rebuild switch --flake /etc/nixos#nixos --commit-lock-file --upgrade --show-trace
home-manager switch --flake /etc/nixos#srp@nixos --show-trace
