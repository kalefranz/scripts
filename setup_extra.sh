#!/bin/bash -eu


brew_cask_install() {
    local package=$1
    if ! $(brew cask list | grep -q "$package" > /dev/null); then
        brew cask install "$package" --appdir=/Applications
    fi
    echo "${prompt_green}✓ $package is installed ${prompt_reset}"
}


declare -a casks=(
    "vmware-fusion"
    "vagrant"


    "iterm2"
    "little-snitch"
    "google-drive"
    "dropbox"
    "airfoil"
    "caffeine"
    "flux"
    "istat-menus"
    "crashplan"
    "dash"
    "evernote"
    "lastpass"
    "firefox"
    "hipchat"
    "karabiner"
    "keyboard-maestro"
    "notational-velocity"
    "omnidisksweeper"
    "caskroom/homebrew-versions/java6"
    "pycharm"
    "quicksilver"
    "sizeup"
    "slack"
    "sourcetree"
    "sqlitebrowser"
    "the-unarchiver"
    "hyperdock"
    "osxfuse"
    "google-chrome"
    )


for i in "${casks[@]}"; do
    brew_cask_install "$i"
done

# sublime
# junos pulse
# pixelmator
# skiptunes
# tunespan
# veracrypt