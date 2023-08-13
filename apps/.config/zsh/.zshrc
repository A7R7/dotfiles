[ -f /opt/anaconda/etc/profile.d/conda.sh ] && source /opt/anaconda/etc/profile.d/conda.sh


# zinit
source "/usr/share/zinit/zinit.zsh"
source "$HOME/.local/.openai_api_key"
# source "$HOME/.local/.proxy"
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
  # kutsan/zsh-system-clipboard\
  # softmoth/zsh-vim-mode \

zinit ice depth=1
zinit light jeffreytse/zsh-vi-mode

# bin
eval $(thefuck --alias)

# alias
  alias sudo='sudo '
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
  alias l='ls -CF'
  alias ll='ls -alF'
  alias la='ls -ACF'

# helpful cds
  alias .='cd .'
  alias ..='cd ..'
  alias ...='cd ../..'
  alias ....='cd ../../..'
  alias -- -='cd -'
  function mkcd { mkdir "$1"; cd "$1"; }

# helpful tools
  alias ex='extract'
  alias open="exo-open"
  alias trash="gio trash"
  alias info="info --vi-keys"
  function bak { mv "${1}" "${1}.bak" }
  function unbak {
    if [[ -z "$1" ]]; then
        echo "Error: Please provide a file name."
        return 1
    fi

    local file="$1"
    local new_file="${file%.bak}"

    if [[ "$file" == "$new_file" ]]; then
        echo "The file does not end with '.bak' postfix. No changes needed."
        return 0
    fi

    if [[ -e "$new_file" ]]; then
        echo "Error: File '$new_file' already exists. Rename aborted."
        return 1
    fi

    mv "$file" "$new_file"
    echo "File '$file' has been renamed to '$new_file'."
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


# emacs
  # for chemacs2
  # alias dmacs='emacs --with-profile doom'
  # alias smacs='emacs --with-profile space'

  # for emacs29 and above
  alias dmacs='emacs --init-directory=~/.local/share/doom &'
  # alias smacs='emacs --init-directory=~/.spacemacs.d &'
  alias cmacs='emacs --init-directory=~/.config/centaur &'
  alias doom='~/.local/share/doom/bin/doom'

# nvim
  alias lazy="NVIM_APPNAME=lazyvim"
  alias nvchad="NVIM_APPNAME=nvchad"
  alias astro="NVIM_APPNAME=astronvim"
  alias neovide-m="neovide --multigrid"
  alias sudoedit='function _sudoedit(){sudo -e "$1";};_sudoedit'
# other programs
  alias jos="joshuto"
  alias proxyman='~/.local/bin/proxyman'
#  alias neovide='~/.cargo/bin/neovide'
  alias rwaybar='killall -SIGUSR2 waybar'

# vim key binds for zsh
set -o vi

# source .zshrc more than once will cause maximum nested function, 
# https://github.com/zsh-users/zsh-autosuggestions/issues/187
