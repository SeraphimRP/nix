#!/bin/sh

dconf write /org/gtk/settings/file-chooser/clock-format "'12h'"
sudo cp -R nixos/* /etc/nixos/
#nix flake update --flake /etc/nixos 
sudo nixos-rebuild switch --flake /etc/nixos#nixos --commit-lock-file --upgrade --show-trace
home-manager switch --flake /etc/nixos#srp@nixos --show-trace
