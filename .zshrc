is_linux() {
    if [[ "$(uname)" == "Linux" ]]; then
        return 0  # true
    else
        return 1  # false
    fi
}

is_macos() {
    if [[ "$(uname)" == "Darwin" ]]; then
        return 0  # true
    else
        return 1  # false
    fi
}

# Homebrew
if is_macos; then
    eval "$(/opt/homebrew/bin/brew shellenv)"
fi

# Prompt theme (with Oh My Posh)
# See https://ohmyposh.dev/docs/installation/customize
eval "$(oh-my-posh init zsh --config ~/.local/share/oh-my-posh/theme.omp.json)"

# Command completion
# See https://wiki.archlinux.org/title/Zsh#Command_completion
autoload compinit
compinit
zstyle ':completion:*' menu select

# Fish-like syntax highlighting
# See https://wiki.archlinux.org/title/Zsh#Fish-like_syntax_highlighting_and_autosuggestions
if is_macos; then
    source /opt/homebrew/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
    source /opt/homebrew/share/zsh-autosuggestions/zsh-autosuggestions.zsh
elif is_linux; then
    source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
    source /usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh
fi

# Command-not-found handler
# See https://wiki.archlinux.org/title/Zsh#pkgfile_%22command_not_found%22_handler
if is_linux; then
    source /usr/share/doc/pkgfile/command-not-found.zsh
fi

# Terminal application mode (to make $terminfo valid)
# See https://wiki.archlinux.org/title/Zsh#Key_bindings
if [[ -n "$terminfo[smkx]" && -n "$terminfo[rmkx]" ]]; then
    autoload add-zle-hook-widget
    function zle_application_mode_start {
        echoti smkx
    }
    function zle_application_mode_stop {
        echoti rmkx
    }
    add-zle-hook-widget -Uz zle-line-init zle_application_mode_start
    add-zle-hook-widget -Uz zle-line-finish zle_application_mode_stop
fi

bind_key() {
    local key="$1"
    local action="$2"
    [[ -n "$key" ]] && bindkey -- "$key" "$action"
}

# Basic key bindings
bind_key "$terminfo[khome]" beginning-of-line
bind_key "$terminfo[kend]" end-of-line
bind_key "$terminfo[kdch1]" delete-char
bind_key "$terminfo[kcbt]" reverse-menu-complete

# Key bindings for history search of matching commands
# See https://wiki.archlinux.org/title/Zsh#History_search
autoload up-line-or-beginning-search down-line-or-beginning-search
zle -N up-line-or-beginning-search
zle -N down-line-or-beginning-search
bind_key "$terminfo[kcuu1]" up-line-or-beginning-search
bind_key "$terminfo[kcud1]" down-line-or-beginning-search

# Aliases
alias ls="ls --color=auto"
alias ll="ls -lh"
alias la="ls -lAh"

# Kubernetes
if command -v kubectl 2>&1 >/dev/null; then
    source <(kubectl completion zsh)
fi

# ER Cloud
if is_macos; then
    source $HOME/.ercloud
fi
