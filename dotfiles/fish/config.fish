alias snr "sudo nixos-rebuild"
alias rvim "EDITOR=nvim sudoedit"

alias .. "cd .."
alias ... "cd ../.."
alias .... "cd ../../.."

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

if status is-interactive
    # Commands to run in interactive sessions can go here
end
