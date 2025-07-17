#!/bin/sh

dconf write /org/gtk/settings/file-chooser/clock-format "'12h'"
#sudo cp -R nixos/* /etc/nixos/
sudo cp profile.local /etc/profile.local
#nix flake update --flake /etc/nixos 
#sudo nixos-rebuild switch --flake /etc/nixos#nixos --commit-lock-file --upgrade --show-trace 2>/dev/stdout
nh os switch ./nixos -H nixos -u
nh home switch ./nixos -u
nh clean all --keep-since 4d --keep 3