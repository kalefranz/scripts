#!/bin/bash -eu


#############
# This script should install all the needed dependencies for vagrant



prompt_bold="$(tput bold)"
prompt_reset="$(tput sgr0)"

prompt_black="$(tput setaf 0)"
prompt_red="$(tput setaf 1)"
prompt_green="$(tput setaf 2)"
prompt_yellow="$(tput setaf 3)"
prompt_blue="$(tput setaf 4)"
prompt_purple="$(tput setaf 5)"
prompt_cyan="$(tput setaf 6)"
prompt_white="$(tput setaf 7)"


SCRIPT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )" # the directory this file is in
cd ${SCRIPT_DIR}


sudo -v -p "${prompt_bold}${prompt_white}elevated privileges are required to run this script
enter sudo password: ${prompt_reset}"

# install command-line tools
if $(xcode-select -p 2>&1 | grep -q "error"); then
    echo "${prompt_bold}${prompt_white}XCode Tools must be installed.${prompt_reset}"
    echo "${prompt_bold}${prompt_white}Please complete the XCode Tools setup, then run this script again.${prompt_reset}"
    xcode-select --install
    exit 1
fi
echo "${prompt_green}✓ Xcode command-line tools are installed${prompt_reset}"

# install brew
if ! which brew > /dev/null; then
    ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)" < /dev/null
fi
echo "${prompt_green}✓ homebrew is installed${prompt_reset}"

# this is a lib file installed by Symmantec but apparently not needed
if test -f /usr/local/lib/libecomlodr.dylib; then
    sudo rm -f /usr/local/lib/libecomlodr.dylib
fi

# enforce brew-able environment
echo "${prompt_white}Updating homebrew.${prompt_reset}"
brew update
brew doctor
brew upgrade --all

# install ruby environment
if ! $(brew list | grep -q "rbenv$"); then
    brew install rbenv
    echo "${prompt_bold}${prompt_white}The following two lines have been added to your ~/.bash_profile file.${prompt_reset}"
    echo "${prompt_blue}export RBENV_ROOT=/usr/local/var/rbenv${prompt_reset}"
    export RBENV_ROOT=/usr/local/var/rbenv
    touch $HOME/.bash_profile
    grep -q "RBENV_ROOT" $HOME/.bash_profile || echo "export RBENV_ROOT=/usr/local/var/rbenv" >> $HOME/.bash_profile
    echo "${prompt_blue}if which rbenv > /dev/null; then eval \"\$(rbenv init -)\"; fi${prompt_reset}"
    if which rbenv > /dev/null; then eval "$(rbenv init -)"; fi
    grep -q "rbenv init" $HOME/.bash_profile || echo "if which rbenv > /dev/null; then eval \"\$(rbenv init -)\"; fi" >> $HOME/.bash_profile
    rbenv global system
fi
echo "${prompt_green}✓ rbenv is installed${prompt_reset}"
echo "${prompt_green}✓ system ruby set as global version ${prompt_reset}"

source $HOME/.bash_profile



if ! $(brew tap | grep -q binary); then
    brew tap homebrew/binary
fi
if ! $(brew tap | grep -q cask); then
    brew tap caskroom/cask
fi

brew_install() {
    local package=$1
    if ! $(brew list | grep -q "$package"); then
        brew install "$package"
    fi
    echo "${prompt_green}✓ $package is installed ${prompt_reset}"
}

declare -a arr=(
    "ruby-build"
    "rbenv-gem-rehash"
    "wget"
    "ansible"
    "git"
    "libyaml"
    "caskroom/cask/brew-cask"
    "ack"
    "gawk"
    "node"
    "packer"
    "pypy"
    "python3"
    "xz"
    "zsh"
)

for i in "${arr[@]}"; do
    brew_install "$i"
done


# python environment
if ! $(brew list | grep -q "python$"); then
    brew install python --universal
    /usr/local/bin/pip install --upgrade setuptools
    /usr/local/bin/pip install --upgrade pip
    /usr/local/bin/pip install python-dateutil
fi
echo "${prompt_green}✓ brewed python is installed ${prompt_reset}"


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
    )

for i in "${casks[@]}"; do
    brew_cask_install "$i"
done



if ! $(vagrant plugin list | grep -q "vagrant-vmware-fusion"); then
    vagrant plugin install vagrant-vmware-fusion
fi
echo "${prompt_green}✓ vagrant-vmware-fusion is installed and licensed${prompt_reset}"

if ! $(vagrant plugin list | grep -q "vagrant-hostsupdater"); then
    vagrant plugin install vagrant-hostsupdater
fi
echo "${prompt_green}✓ vagrant-hostsupdater is installed${prompt_reset}"

if ! $(vagrant plugin list | grep -q "vagrant-triggers"); then
    vagrant plugin install vagrant-triggers
fi
echo "${prompt_green}✓ vagrant-triggers is installed${prompt_reset}"

brew cleanup > /dev/null
brew cask cleanup > /dev/null


echo ""
echo "${prompt_bold}${prompt_green}✓✓✓ your vagrant environment is ready ✓✓✓${prompt_reset}"
echo ""
echo ""
