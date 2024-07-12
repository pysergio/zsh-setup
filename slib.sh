#!/usr/bin/env bash

function include_plugin() {
    for plugin in "$@"; do
        if ! grep -q $plugin $HOME/.zshrc; then
            sed -i "s/^plugins=(/plugins=($plugin /" $HOME/.zshrc
        fi
    done
}

function git_clone_if_not_exists() {
    if [ ! -d "$2" ]; then
        git clone $1 $2
    fi
}
