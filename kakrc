# Toggle line numbering
addhl global number_lines
addhl global wrap
addhl global show_matching

colorscheme desertex

# Allow to paste things copied at an other place
map global user P '!xsel --output --clipboard<ret>'
map global user p '<a-!>xsel --output --clipboard<ret>'
map global user y '<a-|> xsel --input --clipboard <ret>'

# Allows selection indent
map global normal <tab> '<a-;><gt>'
map global normal <s-tab> '<a-;><lt>'

# Commenting area
map global normal '#' :comment-line<ret> -docstring 'comment line'
map global normal '<a-#>' :comment-block<ret> -docstring 'comment block'

# Default format
set global tabstop 4
set global indentwidth 4
set global ui_options ncurses_assistant=none
# set global syntastic_autoformat true

# Aliases
alias global term hatch-terminal-x11

# Creates the status line
%sh{
    tools=(
    	"%val{bufname}"
    	"%opt{filetype}"
    	"%val{cursor_line}:%val{cursor_char_column} (%opt{modeline_pos_percent}\%)"
    	"{{context_info}} {{mode_info}}"
    	"%opt{modeline_git_branch}"
    	"%val{client}@[%val{session}]"
    	)
	
    fmt_line=""

    for t in "${tools[@]}"; do
        test -z "${t}" && continue
        test -n "${fmt_line}" && fmt_line="${fmt_line} | ${t}" || fmt_line="${t}"
    done

    echo set global modelinefmt "'${fmt_line}'"
}

# Load the custom kakrc
%sh{
	proj_dir=$(git rev-parse --show-toplevel)
    echo try %{ source ${proj_dir}/.kakbis.kak }
    echo try %{ source .kakbis.kak }
    echo try %{ source .kakrc.kak }
}
