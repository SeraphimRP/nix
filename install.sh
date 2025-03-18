#!/bin/sh

sudo cp nixos/* /etc/nixos/
sudo nixos-rebuild switch

mkdir -p $HOME/.config/home-manager
cp .config/home-manager/flake.nix
home-manager switch
