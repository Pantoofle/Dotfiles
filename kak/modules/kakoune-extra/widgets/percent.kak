##
## percent.kak by lenormf
## Compute and store the relative position of the cursor in percent
##

## position of the cursor in the buffer, in percent
decl str modeline_pos_percent

hook global WinCreate .* %{
    hook window NormalIdle .* %{ eval %sh{
        echo "set window modeline_pos_percent '$(($kak_cursor_line * 100 / $kak_buf_line_count))'"
    } }
}
