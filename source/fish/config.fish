if status is-interactive
    set -g fish_cursor_insert line
    set -g fish_vi_force_cursor
    fish_vi_key_bindings

    function gst
        git status $argv
    end

    function ga
        git add $argv
    end

    function gd
        git diff $argv
    end
end

function vim
    nvim $argv
end

set __fish_ls_command exa
    
