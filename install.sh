#!/bin/sh

sudo cp nixos/* /etc/nixos/
sudo nix flake update --flake /etc/nixos 
sudo nixos-rebuild switch --flake /etc/nixos#nixos --commit-lock-file --upgrade
home-manager switch --flake /etc/nixos#srp@nixos
