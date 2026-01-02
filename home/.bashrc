#!/bin/bash
os=`uname`

if [ -f ~/.secrets ]; then
    source ~/.secrets
fi

alias ls='ls --color=auto'
alias noh='history -d $(history 1)'

# run local bash stuff (pc-specific aliases and such)
if [ -f ~/.bash_local ]; then
    . ~/.bash_local
fi

export PYENV_ROOT="$HOME/.pyenv"
export PATH="$PYENV_ROOT/bin:$PATH"

source ~/.exports
source $HOME/.homesick/repos/homeshick/homeshick.sh

PATH=$PATH:$HOME/bin

# Powerline Bash Prompt Setup https://github.com/b-ryan/powerline-shell#bash
export CLICOLOR=1
# export LSCOLORS=gxBxhxDxfxhxhxhxhxcxcx

function _update_ps1() {
    PS1=$(powerline-shell $?)
}

if [[ $TERM != linux && ! $PROMPT_COMMAND =~ _update_ps1 ]]; then
    PROMPT_COMMAND="_update_ps1; $PROMPT_COMMAND"
fi

###############################################################################
# Shortcuts                                                                   #
###############################################################################
alias yt='yt-dlp'
alias k='kubectl'
alias cocaine='xset s off -dpms && xset s noblank'

alias noh='history -d $(history 1)'

alias ll='ls -alFt'
alias l='ls -CF'

alias homesick-pull='homeshick pull dotfiles-full'

if [[ "$os" == 'Linux' ]]; then
  # Linux Business
  alias gh="google-chrome-stable https://github.com"
  alias ex='nautilus . &'
 elif [[ "$os" == 'Darwin' ]]; then
  # Mac Business
  alias ex='open . &'
fi

alias vvv=". venv/bin/activate"

alias gitlogs='git log --decorate --graph --oneline --all'

alias killds='rm -f $(find . -name ".DS_Store" -type f)'

alias resource='source ~/.bash_profile && echo "Done!"'
alias whatsmyip='ipconfig getifaddr en0'

# File System stuff.
alias cpwd='pwd|tr -d "\n"|pbcopy' # copy pwd
alias ..="cd ../"
alias ...="cd ../../"

# List declared aliases, functions
alias listaliases="alias | sed 's/=.*//'"
alias listfunctions="declare -f | grep '^[a-z].* ()' | sed 's/{$//'" # show non _prefixed functions

###############################################################################
# OSX                                                                         #
###############################################################################

if [[ "$os" == 'Darwin' ]]; then
  # Show/hide desktop icons
  alias desktopShow="defaults write com.apple.finder CreateDesktop -bool true && killall Finder"
  alias desktopHide="defaults write com.apple.finder CreateDesktop -bool false && killall Finder"

  # Show/hide hidden files by default
  alias hiddenFilesShow="defaults write com.apple.finder AppleShowAllFiles -bool true && killall Finder"
  alias hiddenFilesHide="defaults write com.apple.finder AppleShowAllFiles -bool false && killall Finder"

  # Show/hide all filename extensions
  alias fileExtensionsShow="defaults write NSGlobalDomain AppleShowAllExtensions -bool true && killall Finder"
  alias fileExtensionsHide="defaults write NSGlobalDomain AppleShowAllExtensions -bool false && killall Finder"
fi

################
# Docker
################

# alias dockerstop
# alias dockerkill
alias dockerps='docker ps --format "table {{.Names}}\t{{.ID}}\t{{.Status}}\t{{.RunningFor}}\t{{.Ports}}"'

# If not running interactively, don't do anything
case $- in
    *i*) ;;
      *) return;;
esac

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# Don't tab autocomplete when empty
shopt -s no_empty_cmd_completion

# If set, the pattern "**" used in a pathname expansion context will
# match all files and zero or more directories and subdirectories.
#shopt -s globstar

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    #alias dir='dir --color=auto'
    #alias vdir='vdir --color=auto'

    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi


# enable programmable completion features (you don't need to enable
# this, if it's already enabled in /etc/bash.bashrc and /etc/profile
# sources /etc/bash.bashrc).
if ! shopt -oq posix; then
  if [ -f /usr/share/bash-completion/bash_completion ]; then
    . /usr/share/bash-completion/bash_completion
  elif [ -f /etc/bash_completion ]; then
    . /etc/bash_completion
  fi
fi

# Avoid duplicates
export HISTCONTROL=ignoreboth:erasedups
# When the shell exits, append to the history file instead of overwriting it
shopt -s histappend

# After each command, append to the history file and reread it
# export PROMPT_COMMAND="${PROMPT_COMMAND:+$PROMPT_COMMAND$'\n'}history -a; history -c; history -r"

# add something to gitignore
function gi {
  echo "$1" >> .gitignore
}

# grab the ip of a docker contanier by name
function dockerip {
  docker inspect --format '{{ .NetworkSettings.IPAddress }}' $1
}

function docker-clean {
  docker rm $(docker ps -a -q)
  docker rmi $(docker images | grep "^<none>" | awk "{print $3}")
}

# `tre` is a shorthand for `tree` with hidden files and color enabled, ignoring
# the `.git` directory, listing directories first. The output gets piped into
# `less` with options to preserve color and line numbers, unless the output is
# small enough for one screen.
function tre() {
  tree -aC -I '.git|node_modules|bower_components' --dirsfirst "$@" | less -FRNX;
}

# source ~/.prompt

export NVM_DIR="$HOME/.nvm"

[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_com pletion

function yts() {
    yt-dlp --extract-audio --audio-format mp3 "$1"
}

eval "$(pyenv init --path)"
eval "$(pyenv virtualenv-init -)"

BROWSER=/usr/bin/google-chrome

export PYENV_ROOT="$HOME/.pyenv"
export PATH="/home/ccc/.pyenv/shims:\
/home/ccc/.pyenv/bin:\
/home/ccc/.vscode/extensions/ms-python.python-2025.0.0-linux-x64/python_files/deactivate/bash:\
/home/ccc/.local/bin:\
/home/ccc/.go/bin:\
/home/ccc/go/bin:\
/home/ccc/bin:\
/usr/local/sbin:\
/usr/local/bin:\
/usr/sbin:\
/usr/bin:\
/sbin:\
/bin:\
/usr/games:\
/usr/local/games:\
/snap/bin:\
/home/ccc/.lmstudio/bin"

eval "$(pyenv init -)"
eval "$(pyenv virtualenv-init -)"

nvm use 22

combinevids() {
    echo "Preparing videos..."
    mkdir -p tmp_seq && > list.txt
    # Find files, sort alphabetically, process them
    find . -maxdepth 1 -name "*.mp4" -print0 | sort -z | while IFS= read -r -d '' f; do
        filename=$(basename -- "$f")
        out="tmp_seq/${filename%.*}_norm.mp4"
        echo -ne "Formatting: $filename\033[0K\r"
        ffmpeg -nostdin -v error -i "$f" -vf "scale=1200:1200:force_original_aspect_ratio=decrease,pad=1200:1200:(ow-iw)/2:(oh-ih)/2,setsar=1" -an -c:v libx264 -pix_fmt yuv420p "$out"
        echo "file '$PWD/$out'" >> list.txt
    done
    echo -e "\nStitching files..."
    ffmpeg -v error -f concat -safe 0 -i list.txt -c copy combined_video.mp4
    rm -rf tmp_seq list.txt
    echo "Done! Output saved to: combined_video.mp4"
}

combinevids_random() {
    echo "Preparing videos (Random Order)..."
    mkdir -p tmp_rand && > list.txt
    # Find files, SHUFFLE them, process them
    find . -maxdepth 1 -name "*.mp4" -print0 | shuf -z | while IFS= read -r -d '' f; do
        filename=$(basename -- "$f")
        # Use a timestamp in the temp name to avoid collisions if filenames are identical in different runs
        out="tmp_rand/$(date +%s%N).mp4"
        echo -ne "Formatting: $filename\033[0K\r"
        ffmpeg -nostdin -v error -i "$f" -vf "scale=1200:1200:force_original_aspect_ratio=decrease,pad=1200:1200:(ow-iw)/2:(oh-ih)/2,setsar=1" -an -c:v libx264 -pix_fmt yuv420p "$out"
        echo "file '$PWD/$out'" >> list.txt
    done
    echo -e "\nStitching files..."
    ffmpeg -v error -f concat -safe 0 -i list.txt -c copy combined_random.mp4
    rm -rf tmp_rand list.txt
    echo "Done! Output saved to: combined_random.mp4"
}

transcribe() {
    local file="$1"
    local model_size="${2:-medium}" # Default to medium (balanced)
    local device="${3:-cpu}"        # Default to CPU (Safe Mode)

    if [[ -z "$file" ]]; then
        echo "Usage: transcribe <file> [model_size] [device]"
        echo "Example: transcribe video.mp4 large-v3 cuda"
        return 1
    fi
    
    # Matches your UltraWhisper dependencies
    uv run --with faster-whisper python -c "
import sys, os
from faster_whisper import WhisperModel

file = sys.argv[1]
model_size = sys.argv[2]
device = sys.argv[3]
compute_type = 'float16' if device == 'cuda' else 'int8'

if not os.path.exists(file):
    print(f'❌ Error: File {file} not found.')
    sys.exit(1)

print(f'🚀 Loading {model_size} on {device} ({compute_type})...')
try:
    model = WhisperModel(model_size, device=device, compute_type=compute_type)
except Exception as e:
    print(f'❌ Error loading model: {e}')
    print('💡 If using CUDA, ensure cuDNN 9+ libraries are in LD_LIBRARY_PATH')
    sys.exit(1)

print(f'🎙️  Transcribing {file}...')
segments, info = model.transcribe(file, beam_size=5)

out_file = file + '.txt'
with open(out_file, 'w', encoding='utf-8') as f:
    for segment in segments:
        line = f'[{segment.start:.2f}s -> {segment.end:.2f}s] {segment.text}'
        print(line)
        f.write(line + '\n')

print(f'✅ Saved: {out_file}')
" "$file" "$model_size" "$device"
}

alias pbcopy='xclip -selection clipboard'
alias pbpaste='xclip -selection clipboard -o'