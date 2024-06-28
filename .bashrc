# ~/.bashrc

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

# ...the promt
PS1='\[\e[38;5;34m\]\u@\h\[\e[0m\]: \[\e[38;5;33m\]\w/\[\e[0m\] \\$ '

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    
    alias df='df -h'
    alias ls='ls -la --color=auto'    
    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

if [ -x ~/.profile ]; then
    source ~/.profile
fi

# ...enable ccache
if [ -d "/usr/lib/ccache/bin" ]; then
    export PATH="/usr/lib/ccache/bin:$PATH"
fi

# ...Alacritty completion
if [ -x ~/.bash_completion/alacritty ]; then
    source ~/.bash_completion/alacritty
fi

# ...Android SDK
if [ -d "$HOME/Android/Sdk" ]; then
    export ANDROID_SDK="$HOME/Android/Sdk"
    export ANDROID_HOME="$ANDROID_SDK"
    export PATH="$PATH:$ANDROID_SDK/platform-tools"
fi

# ...dotNet support
if [ -d "$HOME/.dotnet/tools" ]; then
    export PATH="$PATH:$HOME/.dotnet/tools"
    export DOTNET_ROOT=/usr/share/dotnet
fi

# ...vcpkg
if [ -d "$HOME/Github/vcpkg" ]; then
    export VCPKG_ROOT=$HOME/Github/vcpkg
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

