#!/bin/bash -eu


brew_install() {
    local package=$1
    if ! $(brew list | grep -q "$package"); then
        brew install "$package"
    fi
    echo "${prompt_green}✓ $package is installed ${prompt_reset}"
}

declare -a arr=(
    "docker"
    "docker-machine"
    "jq"
    "keybase"
    "node"
    "packer"
    "pypy"
    "python3"
)
# "zsh"

for i in "${arr[@]}"; do
    brew_install "$i"
done



brew_cask_install() {
    local package=$1
    if ! $(brew cask list | grep -q "$package" > /dev/null); then
        brew cask install "$package" --appdir=/Applications
    fi
    echo "${prompt_green}✓ $package is installed ${prompt_reset}"
}


declare -a casks=(
    "airfoil"
    "amazon-cloud-drive"
    "caffeine"
    "crashplan"
    "dash"
    "dropbox"
    "evernote"
    "firefox"
    "flux"
    "google-chrome"
    "google-drive"
    "hyperdock"
    "istat-menus"
    "iterm2"
    "karabiner"
    "keyboard-maestro"
    "lastpass"
    "little-snitch"
    "notational-velocity"
    "omnidisksweeper"
    "osxfuse"
    "pineapple-pro"
    "pycharm"
    "quicksilver"
    "sizeup"
    "slack"
    "soundcleod"
    "sourcetree"
    "sqlitebrowser"
    "sublime-text3"
    "the-unarchiver"
    "virtualbox"
    "xquartz"
    )


for i in "${casks[@]}"; do
    brew_cask_install "$i"
done

# junos pulse
# pixelmator
# skiptunes
# tunespan
# veracrypt
