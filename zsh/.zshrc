[ -f /opt/anaconda/etc/profile.d/conda.sh ] && source /opt/anaconda/etc/profile.d/conda.sh


# zinit
source "/usr/share/zinit/zinit.zsh"
source "$HOME/.local/.openai_api_key"
source "$HOME/.local/.proxy"
autoload -Uz _zinit

# Load starship theme
zinit ice as"command" from"gh-r" atclone"./starship init zsh > init.zsh; ./starship completions zsh > _starship" atpull"%atclone" src"init.zsh"
zinit light starship/starship

# plugins

zinit light-mode for \
  zdharma/fast-syntax-highlighting \
  zsh-users/zsh-completions \
  zsh-users/zsh-autosuggestions \
  OMZ::lib/history.zsh \
  OMZ::lib/clipboard.zsh \
  OMZP::colored-man-pages \
  OMZP::extract \
  ajeetdsouza/zoxide \
  kutsan/zsh-system-clipboard\
  softmoth/zsh-vim-mode \
  # jeffreytse/zsh-vi-mode \
# bin
eval $(thefuck --alias)

# alias
# enable color support of ls and also add handy aliases
  if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    alias dir='dir --color=auto'
    alias vdir='vdir --color=auto'
    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
  fi

  alias ll='ls -alF'
  alias la='ls -A'
  alias l='ls -CF'

alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'
alias -- -='cd -'
alias ex='extract'
alias dmacs='emacs --with-profile doom'
alias smacs='emacs --with-profile space'
alias doom='~/.doomemacs.d/bin/doom'
alias proxyman='~/.local/bin/proxyman'
alias neovide='~/.cargo/bin/neovide'
alias rwaybar='killall -SIGUSR2 waybar'

alias lazy="NVIM_APPNAME=lazyvim"
alias nvchad="NVIM_APPNAME=nvchad"
alias astro="NVIM_APPNAME=astronvim"

alias neovide-m="neovide --multigrid"

function open {
    nohup xdg-open "$@" &
}

function ranger {
    local IFS=$'\t\n'
    local tempfile="$(mktemp -t tmp.XXXXXX)"
    local ranger_cmd=(
        command
        ranger
        --cmd="map Q chain shell echo %d > "$tempfile"; quitall"
    )
    
    ${ranger_cmd[@]} "$@"
    if [[ -f "$tempfile" ]] && [[ "$(cat -- "$tempfile")" != "$(echo -n `pwd`)" ]]; then
        cd -- "$(cat "$tempfile")" || return
    fi
    command rm -f -- "$tempfile" 2>/dev/null
}

# exports
export EDITOR=/usr/bin/nvim
export VISUAL=/usr/bin/nvim


set -o vi

# source .zshrc more than once will cause maximum nested function, 
# https://github.com/zsh-users/zsh-autosuggestions/issues/187
