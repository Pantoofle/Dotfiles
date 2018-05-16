#!/bin/sh

userresources=$HOME/.Xresources
usermodmap=$HOME/.Xmodmap
sysresources=/etc/X11/xinit/.Xresources
sysmodmap=/etc/X11/xinit/.Xmodmap

# merge in defaults and keymaps

setxkbmap fr bepo  -option lv3:ralt_switch  -option caps:swapescape &

if [ -f $sysresources ]; then
    xrdb -merge $sysresources
fi
[[ -f ~/.Xresources ]] && xrdb -merge -I$HOME ~/.Xresources

if [ -f $sysmodmap ]; then
    xmodmap $sysmodmap
fi

if [ -f "$userresources" ]; then
    xrdb -merge "$userresources"
fi

if [ -f "$usermodmap" ]; then
    xmodmap "$usermodmap"
fi

# start some nice programs

if [ -d /etc/X11/xinit/xinitrc.d ] ; then
 for f in /etc/X11/xinit/xinitrc.d/?*.sh ; do
  [ -x "$f" ] && . "$f"
 done
 unset f
fi

xsetroot -cursor_name left_ptr &
xmodmap ~/.Xmodmap

xmodmap -e "keycode 66=Hankaku"
xmodmap -e "add Mod5 = Hankaku"
xmodmap -e "keycode any=Escape"
xcape -e "Hankaku=Escape"

xmodmap -e "keycode 44 = t T t T h H"
xmodmap -e "keycode 45 = s S s S j J"
xmodmap -e "keycode 46 = r R r R k K"
xmodmap -e "keycode 47 = n N n N l L"

# Redshift
pgrep redshift &> /dev/null || redshift &> /dev/null &

#xclock -geometry 50x50-1+1 &
#xterm -geometry 80x50+494+51 &
#xterm -geometry 80x20+494-0 &
#exec xterm -geometry 80x66+0+0 -name login
#exec ~/.fehbg 
exec /usr/bin/awesome
#exec /usr/bin/i3
