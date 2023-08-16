#!/bin/sh

# how deep can plugins become? Validate a deep tree

mkdir -p ./lua/lacorte/config
touch ./lua/lacorte/config/{keymaps,options}.lua

mkdir -p ./lua/lacorte/plugins
touch ./lua/lacorte/plugins/{coding,colorscheme,telescope,treesitter}.lua
