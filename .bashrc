#!/bin/bash

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

# ...the promt
PS1='\[\e[38;5;34m\]\u@\h\[\e[0m\]: \[\e[38;5;33m\]\w/\[\e[0m\] \\$ '

# ...Editors
export HISTCONTROL=ignoreboth
export EDITOR="nano"
export VISUAL="nano"

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    
    alias df='df -h'
    alias ls='ls -la --color=auto'
    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
# shellcheck source=/dev/null
if ! shopt -oq posix; then
    if [ -f /usr/share/bash-completion/bash_completion ]; then
        . /usr/share/bash-completion/bash_completion
        elif [ -f /etc/bash_completion ]; then
        . /etc/bash_completion
    fi
fi

# shellcheck source=/dev/null
if [ -x ~/.profile ]; then
    source "$HOME/.profile"
fi

# ...enable ccache
if [ -d "/usr/lib/ccache/bin" ]; then
    export PATH="/usr/lib/ccache/bin:$PATH"
fi

# ...Alacritty completion
# shellcheck source=/dev/null
if [ -x "$HOME/.bash_completion/alacritty" ]; then
    source "$HOME/.bash_completion/alacritty"
fi

# ...Android SDK
if [ -d "$HOME/Android/Sdk" ]; then
    export ANDROID_SDK="$HOME/Android/Sdk"
    export ANDROID_HOME="$ANDROID_SDK"
    export PATH="$PATH:$ANDROID_SDK/platform-tools"
fi

# ...Arduino Stuff
if [ -d "$HOME/Arduino" ]; then
    export PATH="$PATH:$HOME/Arduino/libraries"
fi

if [ -d "/opt/arduino-ide" ]; then
    export ARDUINO_PATH="/opt/arduino-ide"
fi

if [ -d "$HOME/.arduino15" ]; then
    export PATH="$PATH:$HOME/.arduino15"
fi

# ...dotNet support
if [ -d "$HOME/.dotnet/tools" ]; then
    export PATH="$PATH:$HOME/.dotnet/tools"
    export DOTNET_ROOT=/usr/share/dotnet
fi

# ...vcpkg
if [ -d "$HOME/Github/vcpkg" ]; then
    export VCPKG_FORCE_SYSTEM_BINARIES=true
    export VCPKG_ROOT=$HOME/Github/vcpkg
    export PATH="$PATH:$VCPKG_ROOT"
fi

# Espressif IDE
if [ -d "/opt/esp-idf" ]; then
    alias enable_idf='source /opt/esp-idf/export.sh'
fi

# ...Prüfen, ob neofetch installiert ist
if command -v neofetch &> /dev/null; then
    clear
    echo ""
    echo ""
    neofetch
    echo ""
fi

