#!/bin/sh

mkdir -p $HOME/.config/nvim
stow -v -t $HOME/.config/nvim .
