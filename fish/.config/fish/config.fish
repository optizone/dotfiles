###
# https://fishshell.com/docs/current/index.html
# https://github.com/jorgebucaran/cookbook.fish

# themes
# https://github.com/oh-my-fish/oh-my-fish/blob/master/docs/Themes.md

# Plugins
# https://github.com/jethrokuan/fzf
# https://github.com/IlanCosman/tide.git - fisher install IlanCosman/tide@v5
# https://github.com/jhillyerd/plugin-git

# tools
# https://github.com/jorgebucaran/fisher
# https://github.com/oh-my-fish/oh-my-fish
# https://github.com/danhper/fundle

#set VIRTUAL_ENV_DISABLE_PROMPT "1"

if not status --is-interactive
    exit
end

#set -g fish_term24bit 0

# Load private config
if [ -f $HOME/.config/fish/private.fish ]
    source $HOME/.config/fish/private.fish
end

# Git
if [ -f $HOME/.config/fish/git.fish ]
    source $HOME/.config/fish/git.fish
end

eval $(ssh-agent -c) &>/dev/null
ssh-add ~/.ssh/id_github &>/dev/null
ssh-add ~/.ssh/id_rsa &>/dev/null

# Aliases
if [ -f $HOME/.config/fish/alias.fish ]
    source $HOME/.config/fish/alias.fish
end

# reload fish config
function reload
    exec fish
    set -l config (status -f)
    echo "reloading: $config"
end

# User paths
set -e fish_user_paths
set -U fish_user_paths $HOME/.bin $HOME/.local/bin $HOME/Applications $fish_user_paths

# Starship prompt
if command -sq starship
    starship init fish | source
end

# sets tools
set -x EDITOR nvim
set -x VISUAL nvim
#set -x TERM alacritty
# Sets the terminal type for proper colors
set TERM xterm-256color

# Suppresses fish's intro message
set fish_greeting
#function fish_greeting
#    fish_logo
#end

# Prevent directories names from being shortened
set fish_prompt_pwd_dir_length 0
set -x FZF_DEFAULT_OPTS "--color=16,header:13,info:5,pointer:3,marker:9,spinner:1,prompt:5,fg:7,hl:14,fg+:3,hl+:9 --inline-info --tiebreak=end,length --bind=shift-tab:toggle-down,tab:toggle-up"
# "bat" as manpager
set -x MANPAGER "sh -c 'col -bx | bat -l man -p'"
set -x MANROFFOPT -c
set -g theme_nerd_fonts yes


if status --is-login
    set -gx PATH $PATH ~/.bin
end

if status --is-login
    set -gx PATH $PATH ~/.local/bin
end

if type -q bat
    alias cat="bat --paging=never"
end

if command -sq fzf && type -q fzf_configure_bindings
    fzf_configure_bindings --directory=\ct
end

if not set -q -g fish_user_abbreviations
    set -gx fish_user_abbreviations
end

#if type -f fortune >/dev/null
#  set -l fortune "fortune -a"
#  if type -f lolcat >/dev/null
#    set fortune "$fortune | lolcat"
#  end
#  eval $fortune
#  echo
#end

if test tree >/dev/null
    function l1
        tree --dirsfirst -ChFL 1 $argv
    end
    function l2
        tree --dirsfirst -ChFL 2 $argv
    end
    function l3
        tree --dirsfirst -ChFL 3 $argv
    end
    function ll1
        tree --dirsfirst -ChFupDaL 1 $argv
    end
    function ll2
        tree --dirsfirst -ChFupDaL 2 $argv
    end
    function ll3
        tree --dirsfirst -ChFupDaL 3 $argv
    end
end

if type -q direnv
    eval (direnv hook fish)
end



### FUNCTIONS ###
# Fish command history
function history
    builtin history --show-time='%F %T ' | sort
end

# Make a backup file
function backup --argument filename
    cp $filename $filename.bak
end

function ex --description "Extract bundled & compressed files"
    if test -f "$argv[1]"
        switch $argv[1]
            case '*.tar.bz2'
                tar xjf $argv[1]
            case '*.tar.gz'
                tar xzf $argv[1]
            case '*.bz2'
                bunzip2 $argv[1]
            case '*.rar'
                unrar $argv[1]
            case '*.gz'
                gunzip $argv[1]
            case '*.tar'
                tar xf $argv[1]
            case '*.tbz2'
                tar xjf $argv[1]
            case '*.tgz'
                tar xzf $argv[1]
            case '*.zip'
                unzip $argv[1]
            case '*.Z'
                uncompress $argv[1]
            case '*.7z'
                7z $argv[1]
            case '*.deb'
                ar $argv[1]
            case '*.tar.xz'
                tar xf $argv[1]
            case '*.tar.zst'
                tar xf $argv[1]
            case '*'
                echo "'$argv[1]' cannot be extracted via ex"
        end
    else
        echo "'$argv[1]' is not a valid file"
    end
end

function less
    command less -R $argv
end

function cd
    builtin cd $argv; and ls
end

### ALIASES ###

#list
alias ls="ls --color=auto"
alias la="ls -a"
alias ll="ls -alFh"
alias l="ls"
alias l.="ls -A | grep -E '^\.'"
alias listdir="ls -d */ > list"

if type -q exa
    alias ls="exa --group-directories-first --color=always"
    alias ll="exa -lag --icons --color=always --group-directories-first --octal-permissions"
end

if type -q zoxide
    alias cd="z"
end

#fix obvious typo's
alias cd..="cd .."
alias pdw="pwd"

if type -q ripgrep
    alias grep="rg"
end

## Colorize the grep command output for ease of use (good for log files)##
alias grep="grep --color=auto"
alias egrep="egrep --color=auto"
alias fgrep="fgrep --color=auto"

# Color output of ip
alias ip="ip -color"

#readable output
alias df="df -h"

#pacman unlock
alias unlock="sudo rm /var/lib/pacman/db.lck"
alias rmpacmanlock="sudo rm /var/lib/pacman/db.lck"

# Aliases for software managment
#grub update
alias update-grub="sudo grub-mkconfig -o /boot/grub/grub.cfg"
alias grub-update="sudo grub-mkconfig -o /boot/grub/grub.cfg"
#grub issue 08/2022
alias install-grub-efi="sudo grub-install --target=x86_64-efi --efi-directory=/boot/efi --bootloader-id=ArcoLinux"

# audio check pulseaudio or pipewire
alias audio="pactl info | grep 'Server Name'"

#search content with ripgrep
alias rg="rg --sort path"

if type -q zoxide
    zoxide init fish | source
end

fastfetch
