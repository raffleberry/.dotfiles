# x11
ml=$(cvt $1 $2 | grep -i modeline | sed 's/Modeline //g')
m=$(echo $ml | cut -d' ' -f1)

sudo xrandr --newmode $ml

sudo xrandr --addmode eDP $m

echo "Put this in ~/.xprofile"
echo "xrandr --output eDP --set \"scaling mode\" \"Full aspect\""
echo "xrandr --newmode $ml"
echo "xrandr --addmode eDP $m"
