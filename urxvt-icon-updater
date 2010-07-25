#!/bin/bash

pix='/usr/share/pixmaps'
theme='/usr/share/icons/oxygen'
icon='utilities-terminal.png'

mv -v "$pix/urxvt.xpm" "$pix/urxvt.xpm.orig"
convert -resize 32x32 "$theme/32x32/apps/$icon" \
    "$pix/urxvt.xpm"

for size in 16 32 48; do
    mv -v "$pix/urxvt_${size}x${size}.xpm" \
        "$pix/urxvt_${size}x${size}.xpm.orig"

    convert -resize ${size}x${size} "$theme/${size}x${size}/apps/$icon" \
        "$pix/urxvt_${size}x${size}.xpm"
done

echo
echo "All finished."
