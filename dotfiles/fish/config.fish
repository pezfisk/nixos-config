alias snr "sudo nixos-rebuild"
alias rvim "EDITOR=nvim sudoedit"
alias ls "eza -lh --icons=auto --group-directories-first"
alias l "ls -a"
alias lt "eza --tree --level=2 --icons --git --long"
alias lta "lt -a"
alias ff "fzf --preview 'bat --color=always --style=numbers {}'"
alias cd "z"
alias du "dust"
alias df "duf"
alias cat "bat"
alias man "tldr"

alias .. "cd .."
alias ... "cd ../.."
alias .... "cd ../../.."

set fish_greeting

function reload_i3
    i3-msg reload
end

function fish_command_not_found
    echo "fish: Unknown command: $argv"
end

function editnixos
    nvim /home/$USER/nixos/
end

function reload_fish --description "Reload fish config"
    source /home/$USER/.config/fish/config.fish
end

function nf
    nix-shell $argv
end

function rebuild-nix
    z /home/$USER/nixos
    sudo nixos-rebuild switch --flake ".#$argv"
end

function test-nix
    z /home/$USER/nixos
    sudo nixos-rebuild test --flake ".#$argv"
end


if status is-interactive
    # Commands to run in interactive sessions can go here
end


direnv hook fish | source
zoxide init fish | source
