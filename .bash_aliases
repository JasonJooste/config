#Add config command for git config repo
alias config='/usr/bin/git --git-dir=$HOME/.cfg --work-tree=$HOME'
### Useful little functions
calc() {
    echo "scale=3;$@" | bc -l
}
# Get container id of existing container
dgrep () {
    docker ps -a | grep "$1" | cut -d " " -f 1 
}
# Get the id of an image
digrep () {
    docker images -a | grep "$1" | tr -s " " | cut -d " " -f 3 
}
# Get the first instance of a docker container with a named
dgrepf () {
    docker ps -a | grep "$1" | cut -d " " -f 1 | head -n 1
}
# Bash into existing named container
dbash () {
    docker exec -it $(dgrepf "$1") /bin/bash
}

# Add key binding for copying the current command to the clipboard
if [[ -n $DISPLAY ]]; then
  copy_line_to_x_clipboard () {
    printf %s "$READLINE_LINE" | xclip -selection CLIPBOARD
  }
  bind -x '"\C-y": copy_line_to_x_clipboard' # bound to ctrl-y
fi

alias cxclip="xclip -rmlastnl -selection C"
# Cmdline tool overrides
alias ls=exa
alias cat=batcat
alias grep=rg
alias diff=delta
