# ~/.bashrc: executed by bash(1) for non-login shells.
# see /usr/share/doc/bash/examples/startup-files (in the package bash-doc)
# for examples

# If not running interactively, don't do anything
case $- in
*i*) ;;
*) return ;;
esac

# don't put duplicate lines or lines starting with space in the history.
# See bash(1) for more options
HISTCONTROL=ignoreboth

# append to the history file, don't overwrite it
shopt -s histappend

PROMPT_COMMAND='exit_code=$?; timestamp=$(date +%T);prompt_content="$exit_code | $timestamp"; separator=$(printf "%0.s=" $(seq ${#prompt_content})); printf "%s\n%s\n%s\n" "$separator" "$prompt_content" "$separator" && history -a'

# for setting history length see HISTSIZE and HISTFILESIZE in bash(1)
HISTSIZE=1000
HISTFILESIZE=20000

# check the window size after each command and, if necessary,
# update the values of LINES and COLUMNS.
shopt -s checkwinsize

# If set, the pattern "**" used in a pathname expansion context will
# match all files and zero or more directories and subdirectories.
#shopt -s globstar

# make less more friendly for non-text input files, see lesspipe(1)
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# set variable identifying the chroot you work in (used in the prompt below)
if [ -z "${debian_chroot:-}" ] && [ -r /etc/debian_chroot ]; then
  debian_chroot=$(cat /etc/debian_chroot)
fi

# set a fancy prompt (non-color, unless we know we "want" color)
case "$TERM" in
xterm-color | *-256color) color_prompt=yes ;;
esac

# uncomment for a colored prompt, if the terminal has the capability; turned
# off by default to not distract the user: the focus in a terminal window
# should be on the output of commands, not on the prompt
#force_color_prompt=yes

if [ -n "$force_color_prompt" ]; then
  if [ -x /usr/bin/tput ] && tput setaf 1 >&/dev/null; then
    # We have color support; assume it's compliant with Ecma-48
    # (ISO/IEC-6429). (Lack of such support is extremely rare, and such
    # a case would tend to support setf rather than setaf.)
    color_prompt=yes
  else
    color_prompt=
  fi
fi

parse_git_dirty() {
  [[ $(git status --porcelain 2>/dev/null) ]] && echo "*"
}

parse_git_branch() {
  git branch --no-color 2>/dev/null | sed -e '/^[^*]/d' -e "s/* \(.*\)/ (\1$(parse_git_dirty))/"
}

if [ "$color_prompt" = yes ]; then
  PS1='\n${debian_chroot:+($debian_chroot)}\[\033[01;32m\]\u@\h\[\033[00m\]:\[\033[01;34m\]\w\[\033[00m\]$(parse_git_branch)\n\$ '
else
  PS1='\n${debian_chroot:+($debian_chroot)}\u@\h:\w$(parse_git_branch)\n\$ '
fi
unset color_prompt force_color_prompt

# If this is an xterm set the title to user@host:dir
case "$TERM" in
xterm* | rxvt*)
  PS1="\[\e]0;${debian_chroot:+($debian_chroot)}\u@\h: \w\a\]$PS1"
  ;;
*) ;;
esac

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
  test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
  alias ls='ls --color=auto'
  #alias dir='dir --color=auto'
  #alias vdir='vdir --color=auto'

  alias grep='grep --color=auto'
  alias fgrep='fgrep --color=auto'
  alias egrep='egrep --color=auto'
fi

# colored GCC warnings and errors
#export GCC_COLORS='error=01;31:warning=01;35:note=01;36:caret=01;32:locus=01:quote=01'

# some more ls aliases
alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'

# Add an "alert" alias for long running commands.  Use like so:
#   sleep 10; alert
alias alert='notify-send --urgency=low -i "$([ $? = 0 ] && echo terminal || echo error)" "$(history|tail -n1|sed -e '\''s/^\s*[0-9]\+\s*//;s/[;&|]\s*alert$//'\'')"'

# Alias definitions.
# You may want to put all your additions into a separate file like
# ~/.bash_aliases, instead of adding them here directly.
# See /usr/share/doc/bash-doc/examples in the bash-doc package.

if [ -f ~/.bash_aliases ]; then
  . ~/.bash_aliases
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

bind 'set completion-ignore-case on'

kdelock() {
  qdbus org.kde.plasmashell /PlasmaShell evaluateScript 'lockCorona(!locked)'
}

setup_tar() {
    mkdir -p ~/.local/lib/
    tar -xvf "$1" -c ~/.local/lib/
}


cpu() {
  if [ -z "$1" ]; then
    cat /sys/devices/system/cpu/cpu0/cpufreq/scaling_governor
  else
    if [ "$1" = "0" ]; then
      echo powersave | sudo tee /sys/devices/system/cpu/cpu*/cpufreq/scaling_governor
    elif [ "$1" = "1" ]; then
      echo performance | sudo tee /sys/devices/system/cpu/cpu*/cpufreq/scaling_governor
    fi
  fi
}

addToPath() {
  if [ -d "$1" ]; then
    if [[ "$PATH" != *"$1"* ]]; then
      export PATH=$PATH:$1
    fi
  fi
}

addToPathFront() {
  if [ -d "$1" ]; then
    if [[ "$PATH" != *"$1"* ]]; then
      export PATH=$1:$PATH
    fi
  fi
}

sourceFile() {
  if [ -f "$1" ]; then
    source "$1"
  fi
}

addToPath ~/Apps/bin

addToPath ~/Apps/node/bin

addToPath ~/Apps/nvim/bin

addToPath ~/Apps/go/bin

addToPathFront ~/.local/share/uv/python/cpython-3.13.2-linux-x86_64-gnu/bin

addToPath ~/.local/share/go/bin

alias mymy='sudo systemctl start mysql.service'
alias pgrep='pgrep -af'

completion_dir="$HOME/Apps/completions/bash"
for completion_file in "$completion_dir"/*; do
    if [ -f "$completion_file" ]; then
        source "$completion_file"
    fi
done

reso() {
  ml=$(cvt $1 $2 | grep -i modeline | sed 's/Modeline //g')
  m=$(echo $ml | cut -d' ' -f1)

  sudo xrandr --newmode $ml

  sudo xrandr --addmode eDP $m

  echo "Put this in ~/.xprofile"
  echo "xrandr --output eDP --set \"scaling mode\" \"Full aspect\""
  echo "xrandr --newmode $ml"
  echo "xrandr --addmode eDP $m"

}


set_gnome() {
    gsettings set org.gnome.shell.extensions.dash-to-dock isolate-workspaces true
    gsettings set org.gnome.shell.window-switcher app-icon-mode 'app-icon-only'
    
}

# ripgrep->fzf->vim [QUERY]
fzg() (
  RELOAD='reload:rg --column --color=always --smart-case {q} || :'
  OPENER='if [[ $FZF_SELECT_COUNT -eq 0 ]]; then
            nvim {1} +{2}     # No selection. Open the current line in Vim.
          else
            nvim +cw -q {+f}  # Build quickfix list for the selected items.
          fi'
  fzf --disabled --ansi --multi \
      --bind "start:$RELOAD" --bind "change:$RELOAD" \
      --bind "enter:become:$OPENER" \
      --bind "ctrl-o:execute:$OPENER" \
      --bind 'alt-a:select-all,alt-d:deselect-all,ctrl-/:toggle-preview' \
      --delimiter : \
      --preview 'bat --style=full --color=always --highlight-line {2} {1}' \
      --preview-window '~4,+{2}+4/3,<80(up)' \
      --query "$*"
)





